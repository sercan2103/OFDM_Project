function config = read_plcp_config(bram_addr0, bram_addr1)
% READ_PLCP_CONFIG - Simulates reading PLCP headers from BRAM addresses 0 and 1
%
% This function reads the first two BRAM addresses and configures the OFDM
% transmitter parameters according to the 802.11 PLCP header format.
%
% Inputs:
%   bram_addr0 - 64-bit value from BRAM address 0 (Legacy PLCP header)
%   bram_addr1 - 64-bit value from BRAM address 1 (HT PLCP header)
%
% Outputs:
%   config - Structure containing:
%       .PKT_TYPE      - Packet type: 0=LEGACY, 1=HT
%       .RATE          - Rate field (5 bits)
%       .N_BPSC        - Number of bits per subcarrier (1,2,4,6)
%       .N_DBPS        - Number of data bits per OFDM symbol
%       .PSDU_BIT_LEN  - PSDU length in bits
%       .MCS           - Modulation and coding scheme (HT only)
%       .HT_AGGR       - HT aggregation flag (HT only)
%       .S_GI          - Short guard interval flag (HT only)
%       .data_rate_mbps - Data rate in Mbps

% Initialize configuration structure
config = struct();

%% Parse Legacy PLCP Header (BRAM Address 0)
% Extract rate field from bits [3:0]
rate_field = bitand(bram_addr0, 15); % Extract lower 4 bits

% Decode rate and set N_BPSC, N_DBPS according to 802.11 standard
switch rate_field
    case bin2dec('1011') %  6 Mbps - BPSK 1/2
        config.N_BPSC = 1;
        config.N_DBPS = 24;
        config.RATE = bin2dec('01011');
        config.data_rate_mbps = 6;
        
    case bin2dec('1111') %  9 Mbps - BPSK 3/4
        config.N_BPSC = 1;
        config.N_DBPS = 36;
        config.RATE = bin2dec('01111');
        config.data_rate_mbps = 9;
        
    case bin2dec('1010') % 12 Mbps - QPSK 1/2
        config.N_BPSC = 2;
        config.N_DBPS = 48;
        config.RATE = bin2dec('01010');
        config.data_rate_mbps = 12;
        
    case bin2dec('1110') % 18 Mbps - QPSK 3/4
        config.N_BPSC = 2;
        config.N_DBPS = 72;
        config.RATE = bin2dec('01110');
        config.data_rate_mbps = 18;
        
    case bin2dec('1001') % 24 Mbps - 16-QAM 1/2
        config.N_BPSC = 4;
        config.N_DBPS = 96;
        config.RATE = bin2dec('01001');
        config.data_rate_mbps = 24;
        
    case bin2dec('1101') % 36 Mbps - 16-QAM 3/4
        config.N_BPSC = 4;
        config.N_DBPS = 144;
        config.RATE = bin2dec('01101');
        config.data_rate_mbps = 36;
        
    case bin2dec('1000') % 48 Mbps - 64-QAM 2/3
        config.N_BPSC = 6;
        config.N_DBPS = 192;
        config.RATE = bin2dec('01000');
        config.data_rate_mbps = 48;
        
    case bin2dec('1100') % 54 Mbps - 64-QAM 3/4
        config.N_BPSC = 6;
        config.N_DBPS = 216;
        config.RATE = bin2dec('01100');
        config.data_rate_mbps = 54;
        
    otherwise % Default to 6 Mbps
        config.N_BPSC = 1;
        config.N_DBPS = 24;
        config.RATE = bin2dec('01011');
        config.data_rate_mbps = 6;
end

% Extract LENGTH field from bits [16:5] and convert to bits
length_octets = bitshift(bitand(bram_addr0, hex2dec('1FFE0')), -5);
config.PSDU_BIT_LEN = length_octets * 8;

% Extract packet type from bit [24]
config.PKT_TYPE = bitand(bitshift(bram_addr0, -24), 1);

%% Parse HT PLCP Header (BRAM Address 1) if HT packet
if config.PKT_TYPE == 1 && config.RATE == bin2dec('01011')
    % This is an HT packet
    
    % Extract MCS from bits [2:0]
    mcs_field = bitand(bram_addr1, 7);
    config.MCS = mcs_field;
    
    % Decode MCS and set N_BPSC, N_DBPS for HT
    switch mcs_field
        case 0 %  6.5 Mbps - BPSK 1/2
            config.N_BPSC = 1;
            config.N_DBPS = 26;
            config.RATE = bin2dec('10000');
            config.data_rate_mbps = 6.5;
            
        case 1 % 13.0 Mbps - QPSK 1/2
            config.N_BPSC = 2;
            config.N_DBPS = 52;
            config.RATE = bin2dec('10001');
            config.data_rate_mbps = 13.0;
            
        case 2 % 19.5 Mbps - QPSK 3/4
            config.N_BPSC = 2;
            config.N_DBPS = 78;
            config.RATE = bin2dec('10010');
            config.data_rate_mbps = 19.5;
            
        case 3 % 26.0 Mbps - 16-QAM 1/2
            config.N_BPSC = 4;
            config.N_DBPS = 104;
            config.RATE = bin2dec('10011');
            config.data_rate_mbps = 26.0;
            
        case 4 % 39.0 Mbps - 16-QAM 3/4
            config.N_BPSC = 4;
            config.N_DBPS = 156;
            config.RATE = bin2dec('10100');
            config.data_rate_mbps = 39.0;
            
        case 5 % 52.0 Mbps - 64-QAM 2/3
            config.N_BPSC = 6;
            config.N_DBPS = 208;
            config.RATE = bin2dec('10101');
            config.data_rate_mbps = 52.0;
            
        case 6 % 58.5 Mbps - 64-QAM 3/4
            config.N_BPSC = 6;
            config.N_DBPS = 234;
            config.RATE = bin2dec('10110');
            config.data_rate_mbps = 58.5;
            
        case 7 % 65.0 Mbps - 64-QAM 5/6
            config.N_BPSC = 6;
            config.N_DBPS = 260;
            config.RATE = bin2dec('10111');
            config.data_rate_mbps = 65.0;
            
        otherwise % Default to MCS0
            config.N_BPSC = 1;
            config.N_DBPS = 26;
            config.RATE = bin2dec('10000');
            config.data_rate_mbps = 6.5;
    end
    
    % Extract HT LENGTH field from bits [23:8] and convert to bits
    ht_length_octets = bitshift(bitand(bram_addr1, hex2dec('FFFF00')), -8);
    config.PSDU_BIT_LEN = ht_length_octets * 8;
    
    % Extract HT_AGGR from bit [27]
    config.HT_AGGR = bitand(bitshift(bram_addr1, -27), 1);
    
    % Extract Short GI from bit [31]
    config.S_GI = bitand(bitshift(bram_addr1, -31), 1);
    
    % Adjust data rate for short GI
    if config.S_GI == 1
        config.data_rate_mbps = config.data_rate_mbps * (80/72);
    end
else
    % Legacy packet - set HT-specific fields to default
    config.MCS = 0;
    config.HT_AGGR = 0;
    config.S_GI = 0;
end

% Calculate number of OFDM symbols needed
if config.PKT_TYPE == 0 % Legacy
    % N_SYM = ceil((16 + 8*LENGTH + 6) / N_DBPS)
    service_bits = 16;
    tail_bits = 6;
    config.N_OFDM_SYM = ceil((service_bits + config.PSDU_BIT_LEN + tail_bits) / config.N_DBPS);
else % HT
    % For HT without aggregation: same calculation
    % For HT with aggregation: N_SYM = ceil((8*LENGTH) / N_DBPS)
    if config.HT_AGGR == 0
        service_bits = 16;
        tail_bits = 6;
        config.N_OFDM_SYM = ceil((service_bits + config.PSDU_BIT_LEN + tail_bits) / config.N_DBPS);
    else
        config.N_OFDM_SYM = ceil(config.PSDU_BIT_LEN / config.N_DBPS);
    end
end

% Display configuration summary
fprintf('=== PLCP Configuration ===\n');
fprintf('Packet Type: %s\n', iif(config.PKT_TYPE == 0, 'LEGACY', 'HT'));
fprintf('Data Rate: %.1f Mbps\n', config.data_rate_mbps);
fprintf('N_BPSC: %d bits/subcarrier\n', config.N_BPSC);
fprintf('N_DBPS: %d bits/symbol\n', config.N_DBPS);
fprintf('PSDU Length: %d bits (%d bytes)\n', config.PSDU_BIT_LEN, config.PSDU_BIT_LEN/8);
fprintf('OFDM Symbols: %d\n', config.N_OFDM_SYM);
if config.PKT_TYPE == 1
    fprintf('MCS: %d\n', config.MCS);
    fprintf('Aggregation: %d\n', config.HT_AGGR);
    fprintf('Short GI: %d\n', config.S_GI);
end
fprintf('========================\n');

end

% Helper function for inline if-else
function result = iif(condition, true_val, false_val)
    if condition
        result = true_val;
    else
        result = false_val;
    end
end
