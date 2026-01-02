function iq_samples = hex_to_ofdm_ht(hex_data, rate, mcs, n_bpsc, n_dbps, psdu_length_bytes)
% HEX_TO_OFDM_HT - Converts hexadecimal data to IEEE 802.11n HT-mixed format OFDM symbols
%
% This function processes hex data through the complete 802.11n transmit chain
% using ONLY existing functions from the repository.
%
% Inputs:
%   hex_data           - Hexadecimal string (e.g., 'DEADBEEF...')
%   rate               - Rate field (5-bit value, typically 11 for HT = 6Mbps L-SIG)
%   mcs                - Modulation and Coding Scheme (0-7 for single stream)
%   n_bpsc             - Number of Bits Per SubCarrier (1, 2, 4, or 6)
%   n_dbps             - Number of Data Bits Per Symbol
%   psdu_length_bytes  - PSDU length in bytes for L-SIG field
%
% Output:
%   iq_samples - Complex IQ samples representing complete 802.11n frame
%                (L-STF + L-LTF + L-SIG + HT-SIG + HT-STF + HT-LTF + DATA)
%
% Example:
%   hex_data = 'DEADBEEFCAFEBABE1234567890ABCDEF';
%   rate = 11;  % 6 Mbps for L-SIG
%   mcs = 3;    % 16-QAM 1/2
%   n_bpsc = 4;
%   n_dbps = 104;
%   psdu_length = 16;
%   iq = hex_to_ofdm_ht(hex_data, rate, mcs, n_bpsc, n_dbps, psdu_length);

%% Constants
LEGACY = 0;
HT = 1;
SERVICE_BITS = 16;
TAIL_BITS = 6;
CP_LENGTH = 16;  % Normal GI
N_SD = 52;       % Number of data subcarriers for HT

fprintf('=== Starting 802.11n HT-Mixed Format OFDM Generation ===\n');

%% Step 1: Hexadecimal to Binary Conversion
fprintf('Step 1: Converting hex to binary...\n');
% Remove spaces and convert to upper case
hex_data = upper(strrep(hex_data, ' ', ''));

% Convert hex string to binary array
binary_data = hex2bin(hex_data);
data_length_bits = length(binary_data);

fprintf('  Hex data length: %d characters (%d bits)\n', length(hex_data), data_length_bits);

%% Step 2: Prepare DATA field (Service + PSDU + Tail)
fprintf('Step 2: Preparing DATA field...\n');

% Service field (16 bits of zeros)
service_field = zeros(1, SERVICE_BITS);

% Limit data to first 128 bits as specified
if data_length_bits > 128
    fprintf('  Warning: Truncating data to first 128 bits\n');
    binary_data = binary_data(1:128);
    data_length_bits = 128;
end

% Tail bits (6 bits of zeros for convolutional encoder termination)
tail_field = zeros(1, TAIL_BITS);

% Complete data field
complete_data = [service_field, binary_data, tail_field];
total_bits = length(complete_data);

fprintf('  Total bits (Service + Data + Tail): %d\n', total_bits);

%% Step 3: Scrambling
fprintf('Step 3: Scrambling data...\n');
% Initialize scrambler with all-ones seed (standard for DATA field)
scrambler_seed = ones(1, 7);

% Scramble the complete data
[~, ~, scrambled_data] = Scrambler(scrambler_seed, complete_data, false);

fprintf('  Scrambled %d bits\n', length(scrambled_data));

%% Step 4: Convolutional Encoding
fprintf('Step 4: Convolutional encoding...\n');
% Encode with rate 1/2 (outputs 2x input length)
encoded_data = conv_encoder_80211(scrambled_data, true);  % true = reset encoder

encoded_length = length(encoded_data);
fprintf('  Encoded length: %d bits (rate 1/2)\n', encoded_length);

%% Step 5: Calculate number of OFDM symbols needed
n_cbps = 2 * n_dbps;  % For rate 1/2 (will be adjusted by puncturing)
bits_per_symbol = n_dbps;

% Calculate number of symbols (round up)
n_sym = ceil(encoded_length / n_cbps);

% Pad encoded data if necessary
if encoded_length < n_sym * n_cbps
    pad_length = n_sym * n_cbps - encoded_length;
    encoded_data = [encoded_data; zeros(pad_length, 1)];
    fprintf('  Padded %d bits to fit %d OFDM symbols\n', pad_length, n_sym);
end

fprintf('  Number of DATA OFDM symbols: %d\n', n_sym);

%% Step 6: Process each OFDM symbol (Puncture, Interleave, Modulate, IFFT)
fprintf('Step 5-7: Processing OFDM symbols (Puncture, Modulate, IFFT)...\n');

data_symbols_iq = [];

for sym_idx = 0:(n_sym-1)
    % Extract bits for this symbol
    start_bit = sym_idx * n_cbps + 1;
    end_bit = (sym_idx + 1) * n_cbps;
    symbol_bits = encoded_data(start_bit:end_bit);
    
    % Step 5: Puncturing and Interleaving
    % Use symbol index offset by preamble length (L-SIG=0, HT-SIG1=1, HT-SIG2=2)
    % DATA starts at index 3
    interleaved_bits = dot11_punc_interlv(symbol_bits, rate, sym_idx + 3, HT);
    
    % Step 6: Modulation
    modulated_symbols = modulate_data(interleaved_bits, n_bpsc);
    
    % Step 7: IFFT with HT carrier mapping
    ifft_output = perform_ht_ifft(modulated_symbols, N_SD);
    
    % Step 8: Add Cyclic Prefix (16 samples)
    symbol_with_cp = add_cyclic_prefix(ifft_output, CP_LENGTH);
    
    % Concatenate
    data_symbols_iq = [data_symbols_iq; symbol_with_cp];
end

fprintf('  Generated %d DATA symbols (%d IQ samples)\n', n_sym, length(data_symbols_iq));

%% Step 9: Generate Preamble Symbols
fprintf('Step 8: Generating preamble symbols...\n');

% Create configuration for signal field generation
config = create_config_struct(rate, mcs, psdu_length_bytes);

% Generate L-SIG and HT-SIG using existing function
[l_sig_iq, ht_sig_iq] = generate_signal_iq(config);

% Load preamble data (L-STF, L-LTF, HT-STF, HT-LTF)
[l_stf_iq, l_ltf_iq, ht_stf_iq, ht_ltf_iq] = load_preambles();

fprintf('  L-STF: %d samples\n', length(l_stf_iq));
fprintf('  L-LTF: %d samples\n', length(l_ltf_iq));
fprintf('  L-SIG: %d samples\n', length(l_sig_iq));
fprintf('  HT-SIG: %d samples\n', length(ht_sig_iq));
fprintf('  HT-STF: %d samples\n', length(ht_stf_iq));
fprintf('  HT-LTF: %d samples\n', length(ht_ltf_iq));

%% Step 10: Concatenate all symbols in correct order
fprintf('Step 9: Concatenating all symbols...\n');

iq_samples = [
    l_stf_iq;      % Legacy Short Training Field
    l_ltf_iq;      % Legacy Long Training Field
    l_sig_iq;      % Legacy Signal Field
    ht_sig_iq;     % HT Signal Field (2 symbols)
    ht_stf_iq;     % HT Short Training Field
    ht_ltf_iq;     % HT Long Training Field
    data_symbols_iq % DATA symbols
];

total_samples = length(iq_samples);
duration_us = total_samples * 0.05;  % 20 MHz sampling rate (50 ns per sample)

fprintf('\n=== Generation Complete ===\n');
fprintf('Total IQ samples: %d\n', total_samples);
fprintf('Estimated duration: %.2f µs\n', duration_us);
fprintf('Preamble samples: %d\n', total_samples - length(data_symbols_iq));
fprintf('DATA samples: %d\n', length(data_symbols_iq));

end

%% Helper Functions

function binary_array = hex2bin(hex_string)
    % Convert hex string to binary array
    num_hex_chars = length(hex_string);
    binary_array = zeros(1, num_hex_chars * 4);
    
    for i = 1:num_hex_chars
        hex_char = hex_string(i);
        dec_val = hex2dec(hex_char);
        
        % Convert to 4-bit binary
        for bit = 0:3
            binary_array((i-1)*4 + (4-bit)) = bitget(dec_val, bit+1);
        end
    end
end

function modulated = modulate_data(bits, n_bpsc)
    % Modulate bits using existing modulation_model function
    % Groups bits according to N_BPSC and calls modulation_model
    
    num_symbols = length(bits) / n_bpsc;
    modulated = zeros(num_symbols, 1);
    
    for k = 1:num_symbols
        start_idx = (k-1) * n_bpsc + 1;
        end_idx = k * n_bpsc;
        symbol_bits = bits(start_idx:end_idx);
        
        % Convert bits to integer
        bits_int = 0;
        for b = 1:n_bpsc
            bits_int = bits_int + symbol_bits(b) * 2^(b-1);
        end
        
        % Call existing modulation function
        [I, Q] = modulation_model(n_bpsc, bits_int);
        
        % Convert to complex number and normalize
        modulated(k) = double(I) + 1j * double(Q);
    end
end

function ifft_out = perform_ht_ifft(modulated, n_sd)
    % Perform IFFT using HT-SIG carrier notation
    % HT format uses 52 data subcarriers + 4 pilots
    
    % Pilot subcarriers indices (in 802.11n): -21, -7, +7, +21
    pilot_indices = [-21, -7, 7, 21];
    pilot_values = [1, 1, 1, -1];  % Standard pilot polarities
    
    % Data subcarrier indices (excluding pilots and DC)
    data_indices = [-26:-22, -20:-8, -6:-1, 1:6, 8:20, 22:26];
    
    % Initialize 64-point frequency domain array
    freq_domain = zeros(64, 1);
    
    % Map modulated symbols to data subcarriers
    if length(modulated) ~= length(data_indices)
        error('Mismatch: Expected %d data symbols, got %d', length(data_indices), length(modulated));
    end
    
    % Place data symbols
    for k = 1:length(data_indices)
        idx = data_indices(k);
        fft_idx = mod(idx, 64) + 1;  % Convert to MATLAB 1-based index
        freq_domain(fft_idx) = modulated(k);
    end
    
    % Place pilot symbols
    for k = 1:length(pilot_indices)
        idx = pilot_indices(k);
        fft_idx = mod(idx, 64) + 1;
        freq_domain(fft_idx) = pilot_values(k) * 16384;  % Scale pilots
    end
    
    % DC (index 0) remains zero (guard subcarrier)
    % Indices ±27 to ±31 remain zero (guard bands)
    
    % Perform IFFT using existing model
    ifft_out = ifft64_model.run(freq_domain);
end

function iq_with_cp = add_cyclic_prefix(ifft_output, cp_length)
    % Add cyclic prefix by copying last cp_length samples to beginning
    cp = ifft_output(end-cp_length+1:end);
    iq_with_cp = [cp; ifft_output];
end

function config = create_config_struct(rate, mcs, psdu_length_bytes)
    % Create configuration structure for generate_signal_iq
    config = struct();
    config.PKT_TYPE = 1;  % HT packet
    config.RATE = rate;
    config.MCS = mcs;
    config.PSDU_BIT_LEN = psdu_length_bytes * 8;
    config.HT_AGGR = 0;  % No aggregation
    config.S_GI = 0;     % Normal GI
end

function [l_stf, l_ltf, ht_stf, ht_ltf] = load_preambles()
    % Load preamble IQ data from hex values
    % These values are from the repository's plot_preambles.m
    
    % L-STF (16 samples, repeated 10 times = 160 total)
    l_stf_hex = [
        "05E305E3"; "EF0C004D"; "FE47F5F3"; "1246FE61"; 
        "0BC70000"; "1246FE61"; "FE47F5F3"; "EF0C004D"; 
        "05E305E3"; "004DEF0C"; "F5F3FE47"; "FE611246"; 
        "00000BC7"; "FE611246"; "F5F3FE47"; "004DEF0C"
    ];
    
    % L-LTF (160 samples)
    l_ltf_hex = [
        "EC000000"; "0193F382"; "0BBDF273"; "F43DF143"; "FFA4F91E"; "099C097A"; "EFB402A0"; "F066021F";
        "FB841350"; "F8C602CA"; "F848F598"; "08E7FE31"; "0A86F42E"; "EF33F7A7"; "F8ADFAF8"; "04BAF369";
        "08000800"; "0F430086"; "FD1FEB70"; "078201EA"; "0322077E"; "EE7D0611"; "00200EB8"; "06D4FF7A";
        "0C7C0350"; "FB180D97"; "F1430710"; "07A80B3A"; "02B4FC6E"; "0C65F567"; "05170E3A"; "FF580F67";
        "14000000"; "FF58F099"; "0517F1C6"; "0C650A99"; "02B40392"; "07A8F4C6"; "F143F8F0"; "FB18F269";
        "0C7CFCB0"; "06D40086"; "0020F148"; "EE7DF9EF"; "0322F882"; "0782FE16"; "FD1F1490"; "0F43FF7A";
        "0800F800"; "04BA0C97"; "F8AD0508"; "EF330859"; "0A860BD2"; "08E701CF"; "F8480A68"; "F8C6FD36";
        "FB84ECB0"; "F066FDE1"; "EFB4FD60"; "099CF686"; "FFA406E2"; "F43D0EBD"; "0BBD0D8D"; "01930C7E";
        "EC000000"; "0193F382"; "0BBDF273"; "F43DF143"; "FFA4F91E"; "099C097A"; "EFB402A0"; "F066021F";
        "FB841350"; "F8C602CA"; "F848F598"; "08E7FE31"; "0A86F42E"; "EF33F7A7"; "F8ADFAF8"; "04BAF369";
        "08000800"; "0F430086"; "FD1FEB70"; "078201EA"; "0322077E"; "EE7D0611"; "00200EB8"; "06D4FF7A";
        "0C7C0350"; "FB180D97"; "F1430710"; "07A80B3A"; "02B4FC6E"; "0C65F567"; "05170E3A"; "FF580F67";
        "14000000"; "FF58F099"; "0517F1C6"; "0C650A99"; "02B40392"; "07A8F4C6"; "F143F8F0"; "FB18F269";
        "0C7CFCB0"; "06D40086"; "0020F148"; "EE7DF9EF"; "0322F882"; "0782FE16"; "FD1F1490"; "0F43FF7A";
        "0800F800"; "04BA0C97"; "F8AD0508"; "EF330859"; "0A860BD2"; "08E701CF"; "F8480A68"; "F8C6FD36";
        "FB84ECB0"; "F066FDE1"; "EFB4FD60"; "099CF686"; "FFA406E2"; "F43D0EBD"; "0BBD0D8D"; "01930C7E";
        "EC000000"; "0193F382"; "0BBDF273"; "F43DF143"; "FFA4F91E"; "099C097A"; "EFB402A0"; "F066021F";
        "FB841350"; "F8C602CA"; "F848F598"; "08E7FE31"; "0A86F42E"; "EF33F7A7"; "F8ADFAF8"; "04BAF369";
        "08000800"; "0F430086"; "FD1FEB70"; "078201EA"; "0322077E"; "EE7D0611"; "00200EB8"; "06D4FF7A";
        "0C7C0350"; "FB180D97"; "F1430710"; "07A80B3A"; "02B4FC6E"; "0C65F567"; "05170E3A"; "FF580F67"
    ];
    
    % HT-STF (16 samples, repeated 5 times = 80 total)
    ht_stf_hex = [
        "061C061C"; "EE680050"; "FE36F592"; "12F6FE52"; 
        "0C380000"; "12F6FE52"; "FE36F592"; "EE680050"; 
        "061C061C"; "0050EE68"; "F592FE36"; "FE5212F6"; 
        "00000C38"; "FE5212F6"; "F592FE36"; "0050EE68"
    ];
    
    % HT-LTF (80 samples)
    ht_ltf_hex = [
        "08000400"; "0F430285"; "FD1FEC0B"; "0782FE9C"; "03220D06"; "EE7DFF47"; "00201579"; "06D4FA1F";
        "0C7C0624"; "FB180DF6"; "F1430374"; "07A81176"; "02B4F4BC"; "0C65FD14"; "05170813"; "FF5812D1";
        "14000000"; "FF58ED2F"; "0517F7ED"; "0C6502EC"; "02B40B44"; "07A8EE8A"; "F143FC8C"; "FB18F20A";
        "0C7CF9DC"; "06D405E1"; "0020EA87"; "EE7D00B9"; "0322F2FA"; "0782016C"; "FD1F13F5"; "0F43FA86";
        "0800FC00"; "04BA0369"; "F8ADFAF8"; "EF33F7A7"; "0A86F42E"; "08E7FE31"; "F848F598"; "F8C602CA";
        "FB841350"; "F066021F"; "EFB402A0"; "099C097A"; "FFA4F91E"; "F43DF143"; "0BBDF273"; "0193F382";
        "EC000000"; "0193F382"; "0BBDF273"; "F43DF143"; "FFA4F91E"; "099C097A"; "EFB402A0"; "F066021F";
        "FB841350"; "F8C602CA"; "F848F598"; "08E7FE31"; "0A86F42E"; "EF33F7A7"; "F8ADFAF8"; "04BAF369";
        "08000800"; "0F430086"; "FD1FEB70"; "078201EA"; "0322077E"; "EE7D0611"; "00200EB8"; "06D4FF7A";
        "0C7C0350"; "FB180D97"; "F1430710"; "07A80B3A"; "02B4FC6E"; "0C65F567"; "05170E3A"; "FF580F67"
    ];
    
    % Convert hex to complex IQ
    l_stf = repmat(hex2iq(l_stf_hex), 10, 1);
    l_ltf = hex2iq(l_ltf_hex);
    ht_stf = repmat(hex2iq(ht_stf_hex), 5, 1);
    ht_ltf = hex2iq(ht_ltf_hex);
end

function complex_data = hex2iq(hex_array)
    % Convert hex strings to complex IQ samples
    n = length(hex_array);
    complex_data = zeros(n, 1);
    
    for i = 1:n
        hex_str = char(hex_array(i));
        
        % Split into I (high 16 bits) and Q (low 16 bits)
        i_hex = hex_str(1:4);
        q_hex = hex_str(5:8);
        
        % Convert to signed 16-bit integers
        i_val = typecast(uint16(hex2dec(i_hex)), 'int16');
        q_val = typecast(uint16(hex2dec(q_hex)), 'int16');
        
        % Create complex number
        complex_data(i) = double(i_val) + 1j * double(q_val);
    end
end
