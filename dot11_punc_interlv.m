function interleaved_bits = dot11_punc_interlv(encoded_bits, rate, ofdm_symbol_index, pkt_type)
% DOT11_PUNC_INTERLV Modular MATLAB model of the 802.11 puncturing and interleaving block.
%
% Inputs:
%   encoded_bits: Vector of encoded bits for ONE OFDM symbol.
%                 Length must be 2 * N_DBPS (since code rate is 1/2 before puncturing).
%                 Input format: [A0, B0, A1, B1, ...] where A,B are outputs of the conv encoder.
%   rate:         Integer rate ID (see table below).
%   ofdm_symbol_index: Index of the current OFDM symbol (0-based).
%   pkt_type:     0 for LEGACY, 1 for HT.
%
% Outputs:
%   interleaved_bits: Vector of interleaved (and punctured) bits ready for modulation.
%                     Length will be N_CBPS.
%
% Rate Table (Decimal):
%   Legacy: 11 (6M), 15 (9M), 10 (12M), 14 (18M), 9 (24M), 13 (36M), 8 (48M), 12 (54M)
%   HT:     16 (MCS0) ... 23 (MCS7)

    % Constants
    LEGACY = 0;
    HT = 1;
    RATE_6MBPS = 11; % 5'b01011

    % Determine effective rate for this symbol (Preamble/Signal fields use fixed 6Mbps)
    current_rate = rate;
    is_ht_data = false;
    
    if pkt_type == LEGACY
        if ofdm_symbol_index == 0 % L-SIG
            current_rate = RATE_6MBPS;
        end
    elseif pkt_type == HT
        if ofdm_symbol_index <= 2 % L-SIG, HT-SIG
            current_rate = RATE_6MBPS;
        else
            is_ht_data = true;
        end
    end

    % Get parameters for the *target* rate
    [N_DBPS, N_CBPS, N_BPSC] = get_phy_params(current_rate);
    
    % Validate input length
    expected_len = 2 * N_DBPS;
    if length(encoded_bits) ~= expected_len
        error('Input encoded_bits length (%d) does not match expected length (%d) for rate %d', ...
              length(encoded_bits), expected_len, current_rate);
    end
    
    % Reshape input to pairs [A, B]
    pairs = reshape(encoded_bits, 2, []).'; % N_DBPS x 2 matrix. Row i is [A_i, B_i]
    
    % Initialize RAM (Bit-addressable, fixed size 416 bits)
    % ram_simo depth is 52 bytes -> 416 bits.
    ram_memory = zeros(416, 1);
    
    % 1. WRITE PHASE (Puncturing & Interleaving)
    for idx_i = 0 : N_DBPS-1
        % Get LUT output
        [idx_o, punc_o] = punc_interlv_lut(current_rate, idx_i);
        
        % Extract addresses (9 bits each)
        addr_high = bitshift(idx_o, -9);
        addr_low = bitand(idx_o, 511);
        
        % Extract puncturing info (2 bits)
        punc_high = bitget(punc_o, 2);
        punc_low = bitget(punc_o, 1);
        
        % Get input pair for this index
        odata_0 = pairs(idx_i+1, 1);
        odata_1 = pairs(idx_i+1, 2);
        
        if punc_o == 0
            % No puncturing: Write both bits
            ram_memory(addr_low + 1) = odata_1;
            ram_memory(addr_high + 1) = odata_0;
        else
            % Puncturing active: Write one bit
            if punc_low == 0
                waddr = addr_low;
                punc_bit = odata_1;
            else
                waddr = addr_high;
                punc_bit = odata_0;
            end
            ram_memory(waddr + 1) = punc_bit;
        end
    end
    
    % 2. READ PHASE (Modulation Order)
    % Determine read sequence based on packet type and symbol index
    if is_ht_data
        % HT Data (52 data subcarriers)
        % Order: Pos (26..51), Neg (0..25)
        read_addrs = [26:51, 0:25];
    else
        % Legacy / Signal (48 data subcarriers)
        % Order: Pos (24..47), Neg (0..23)
        read_addrs = [24:47, 0:23];
    end
    
    % Read bits from RAM
    interleaved_bits = zeros(N_CBPS, 1);
    out_idx = 1;
    
    for i = 1:length(read_addrs)
        raddr = read_addrs(i);
        
        % Each raddr corresponds to a byte (8 bits) in RAM, but we only use N_BPSC bits.
        % ram_simo logic: data_o[0] = mem[{raddr, 3'd0}] ...
        % So we read bits starting at raddr * 8.
        
        start_bit_addr = raddr * 8;
        
        for b = 0 : N_BPSC-1
            bit_addr = start_bit_addr + b;
            interleaved_bits(out_idx) = ram_memory(bit_addr + 1);
            out_idx = out_idx + 1;
        end
    end
end

function [N_DBPS, N_CBPS, N_BPSC] = get_phy_params(rate)
    % Returns N_DBPS, N_CBPS, and N_BPSC
    switch rate
        % Legacy
        case 11 % 6 Mbps
            N_DBPS = 24; N_CBPS = 48; N_BPSC = 1;
        case 15 % 9 Mbps
            N_DBPS = 36; N_CBPS = 48; N_BPSC = 1; % Wait, 9Mbps is BPSK 3/4. N_BPSC=1.
        case 10 % 12 Mbps
            N_DBPS = 48; N_CBPS = 96; N_BPSC = 2;
        case 14 % 18 Mbps
            N_DBPS = 72; N_CBPS = 96; N_BPSC = 2;
        case 9  % 24 Mbps
            N_DBPS = 96; N_CBPS = 192; N_BPSC = 4;
        case 13 % 36 Mbps
            N_DBPS = 144; N_CBPS = 192; N_BPSC = 4;
        case 8  % 48 Mbps
            N_DBPS = 192; N_CBPS = 288; N_BPSC = 6;
        case 12 % 54 Mbps
            N_DBPS = 216; N_CBPS = 288; N_BPSC = 6;
            
        % HT (MCS0-7)
        case 16 % MCS0
            N_DBPS = 26; N_CBPS = 52; N_BPSC = 1;
        case 17 % MCS1
            N_DBPS = 52; N_CBPS = 104; N_BPSC = 2;
        case 18 % MCS2
            N_DBPS = 78; N_CBPS = 104; N_BPSC = 2;
        case 19 % MCS3
            N_DBPS = 104; N_CBPS = 208; N_BPSC = 4;
        case 20 % MCS4
            N_DBPS = 156; N_CBPS = 208; N_BPSC = 4;
        case 21 % MCS5
            N_DBPS = 208; N_CBPS = 312; N_BPSC = 6;
        case 22 % MCS6
            N_DBPS = 234; N_CBPS = 312; N_BPSC = 6;
        case 23 % MCS7
            N_DBPS = 260; N_CBPS = 312; N_BPSC = 6;
            
        otherwise
            error('Unknown rate: %d', rate);
    end
end