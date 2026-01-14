function [ht_sig_valid, ht_fields, crc_ok] = ht_sig_decode(ht_sig1, ht_sig2)
% ht_sig_decode - Decode and validate HT-SIG field (802.11n)
%
% Decodes the 48-bit HT-SIG field (two 24-bit symbols)
% Corresponds to HT-SIG decoding logic in dot11.v 
% (S_CHECK_HT_SIG_CRC and S_CHECK_HT_SIG states)
%
% INPUTS:
%   ht_sig1 - First 24 bits of HT-SIG (HT-SIG1)
%   ht_sig2 - Second 24 bits of HT-SIG (HT-SIG2)
%
% OUTPUTS:
%   ht_sig_valid - 1 if HT-SIG passes all checks, 0 otherwise
%   ht_fields    - Structure containing decoded fields
%   crc_ok       - CRC-8 validation result
%
% HT-SIG1 Structure (24 bits):
%   [6:0]   MCS - Modulation and Coding Scheme (0-76)
%   [7]     CBW - Channel Bandwidth (0=20MHz, 1=40MHz)
%   [23:8]  HT_LENGTH - Packet length in bytes
%
% HT-SIG2 Structure (24 bits):
%   [0]     Smoothing - Channel smoothing recommendation
%   [1]     Not Sounding - Not a sounding packet
%   [2]     RESERVED - Must be 1 for HT
%   [3]     Aggregation - A-MPDU indicator
%   [5:4]   STBC - Space-Time Block Coding
%   [6]     FEC Coding - 0=BCC, 1=LDPC
%   [7]     Short GI - Short Guard Interval
%   [9:8]   Num Ext SS - Number of extension spatial streams
%   [17:10] CRC - 8-bit CRC over bits [0:33]
%   [23:18] TAIL - Must be all zeros
%
% USAGE:
%   [valid, fields, crc_check] = ht_sig_decode(ht_sig1_val, ht_sig2_val);

% Extract HT-SIG1 fields
mcs = bitand(ht_sig1, 127); % bits [6:0]
cbw = bitand(bitshift(ht_sig1, -7), 1); % bit [7]
ht_length = bitand(bitshift(ht_sig1, -8), 65535); % bits [23:8]

% Extract HT-SIG2 fields
smoothing = bitand(ht_sig2, 1); % bit [0]
not_sounding = bitand(bitshift(ht_sig2, -1), 1); % bit [1]
ht_rsvd = bitand(bitshift(ht_sig2, -2), 1); % bit [2]
aggregation = bitand(bitshift(ht_sig2, -3), 1); % bit [3]
stbc = bitand(bitshift(ht_sig2, -4), 3); % bits [5:4]
fec_coding = bitand(bitshift(ht_sig2, -6), 1); % bit [6]
sgi = bitand(bitshift(ht_sig2, -7), 1); % bit [7]
num_ext = bitand(bitshift(ht_sig2, -8), 3); % bits [9:8]
crc_rx = bitand(bitshift(ht_sig2, -10), 255); % bits [17:10]
tail = bitand(bitshift(ht_sig2, -18), 63); % bits [23:18]

% Calculate CRC-8 over 34 bits (HT-SIG1[23:0] + HT-SIG2[9:0])
crc_state = ht_sig_crc_init();
% Process HT-SIG1 (24 bits)
for i = 0:23
    bit = bitand(bitshift(ht_sig1, -i), 1);
    [~, crc_state] = ht_sig_crc(bit, crc_state);
end
% Process HT-SIG2[9:0] (10 bits)
for i = 0:9
    bit = bitand(bitshift(ht_sig2, -i), 1);
    [crc_calc, crc_state] = ht_sig_crc(bit, crc_state);
end

% Check CRC
crc_ok = (bitxor(crc_calc, crc_rx) == 0);

% Validation checks
ht_sig_valid = 1;

if ~crc_ok
    ht_sig_valid = 0;
    fprintf('HT-SIG Error: CRC check failed (calc=0x%02X, rx=0x%02X)\n', crc_calc, crc_rx);
end

if mcs > 7
    ht_sig_valid = 0;
    fprintf('HT-SIG Error: Unsupported MCS %d (only 0-7 supported)\n', mcs);
end

if cbw ~= 0
    ht_sig_valid = 0;
    fprintf('HT-SIG Error: Unsupported bandwidth (40MHz not supported)\n');
end

if ht_rsvd == 0
    ht_sig_valid = 0;
    fprintf('HT-SIG Error: Reserved bit must be 1 for HT format\n');
end

if stbc ~= 0
    ht_sig_valid = 0;
    fprintf('HT-SIG Error: STBC not supported\n');
end

if fec_coding ~= 0
    ht_sig_valid = 0;
    fprintf('HT-SIG Error: LDPC not supported (only BCC)\n');
end

if sgi ~= 0
    ht_sig_valid = 0;
    fprintf('HT-SIG Error: Short GI not supported\n');
end

if num_ext ~= 0
    ht_sig_valid = 0;
    fprintf('HT-SIG Error: Extension spatial streams not supported\n');
end

if tail ~= 0
    ht_sig_valid = 0;
    fprintf('HT-SIG Error: Tail bits must be all zeros\n');
end

% Return fields
ht_fields = struct();
ht_fields.mcs = mcs;
ht_fields.cbw = cbw;
ht_fields.ht_length = ht_length;
ht_fields.smoothing = smoothing;
ht_fields.not_sounding = not_sounding;
ht_fields.ht_rsvd = ht_rsvd;
ht_fields.aggregation = aggregation;
ht_fields.stbc = stbc;
ht_fields.fec_coding = fec_coding;
ht_fields.sgi = sgi;
ht_fields.num_ext = num_ext;
ht_fields.crc_rx = crc_rx;
ht_fields.crc_calc = crc_calc;
ht_fields.tail = tail;

end

function state = ht_sig_crc_init()
% Initialize HT-SIG CRC state
    state = struct();
    state.C = ones(1, 8);
end

function [crc, state] = ht_sig_crc(bit, state)
% HT-SIG CRC-8 computation
    C = state.C;
    C_new = zeros(1, 8);
    fb = bitxor(bit, C(8));
    C_new(1) = fb;
    C_new(2) = bitxor(fb, C(1));
    C_new(3) = bitxor(fb, C(2));
    C_new(4) = C(3);
    C_new(5) = C(4);
    C_new(6) = C(5);
    C_new(7) = C(6);
    C_new(8) = C(7);
    state.C = C_new;
    
    crc_bits = zeros(1, 8);
    for i = 1:8
        crc_bits(i) = bitcmp(C_new(9-i), 1);
    end
    crc = sum(crc_bits .* 2.^(0:7));
end
