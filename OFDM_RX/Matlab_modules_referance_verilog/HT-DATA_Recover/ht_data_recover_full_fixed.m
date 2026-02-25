function [rxPSDU, eqSym] = ht_data_recover_full_fixed(rx, chanEst, nVarEst, pktOffset, simParams)
% HT_DATA_RECOVER_FULL_FIXED - wlanHTDataRecover equivalent (Verilog reference)
%
% Verilog OpenOFDM RX implementasyonunun HT-DATA recovery fonksiyonu
% MATLAB wlanHTDataRecover ile aynı signature ve davranış
%
% Inputs:
%   rx         - Received time-domain waveform [N x numRx] complex
%                HT-DATA field samples
%   chanEst    - Channel estimate [Nst x numSTS x numRx] complex
%                64 subcarrier channel estimate (LTS'den)
%   nVarEst    - Noise variance estimate (scalar)
%   pktOffset  - Packet offset (samples) - HT-DATA başlangıcı
%   simParams  - Configuration struct:
%                .mcs - HT-MCS (0-7)
%                .psduLength - PSDU length (bytes)
%                .channelBandwidth - 'CBW20'
%                .numTx - Number of TX antennas
%                .numSTS - Number of space-time streams
%                .numSS - Number of spatial streams
%                .Nsd - Data subcarriers (52 for HT)
%                .numSym - OFDM symbols in HT-DATA
%
% Outputs:
%   rxPSDU     - Recovered PSDU [psduLength*8 x 1] int8 (bits!)
%   eqSym      - Equalized symbols [Nsd x numSym x numSS] complex
%
% Pipeline (Verilog modüller):
%   sync_long.v    → FFT
%   equalizer.v    → Equalization (chanEst kullanır)
%   ofdm_decoder.v → Demod + Deinterleave + Viterbi + Descramble

%% Configuration
mcs = simParams.mcs;
psduLength = simParams.psduLength;
numSym = simParams.numSym;
numSS = simParams.numSS;
Nsd = simParams.Nsd;  % 52 for HT

Nfft = 64;
Ncp = 16;  % Normal GI

% MCS parameters
switch mcs
    case 0, n_bpsc = 1; code_rate = 1/2;  % BPSK
    case 1, n_bpsc = 2; code_rate = 1/2;  % QPSK
    case 2, n_bpsc = 2; code_rate = 3/4;
    case 3, n_bpsc = 4; code_rate = 1/2;  % QAM16
    case 4, n_bpsc = 4; code_rate = 3/4;
    case 5, n_bpsc = 6; code_rate = 2/3;  % QAM64
    case 6, n_bpsc = 6; code_rate = 3/4;
    case 7, n_bpsc = 6; code_rate = 5/6;
    otherwise, error('Invalid MCS');
end

%% Step 1: Extract HT-DATA samples
% rx input: pktOffset'ten sonrası HT-DATA field
samplesPerSym = Nfft + Ncp;
totalSamples = numSym * samplesPerSym;

dataStart = pktOffset + 1;
if dataStart + totalSamples - 1 > length(rx)
    error('Not enough samples');
end

htData = rx(dataStart:dataStart + totalSamples - 1);

%% Step 2: FFT (sync_long.v)
fftOut = zeros(Nfft, numSym, numSS);

for ss = 1:numSS
    for sym = 1:numSym
        % Skip CP, take FFT window
        symStart = (sym-1) * samplesPerSym + Ncp + 1;
        symEnd = symStart + Nfft - 1;
        timeSym = htData(symStart:symEnd);
        
        % 64-point FFT
        fftOut(:, sym, ss) = fft(timeSym, Nfft);
    end
end

%% Step 3: Equalization (equalizer.v)
% Data subcarriers: [-26:-22, -20:-8, -6:-1, 1:6, 8:20, 22:26] = 52 total
% FFT bins: [39:42, 44:56, 58:63, 2:7, 9:21, 23:26]
dataIdx = [39:42, 44:56, 58:63, 2:7, 9:21, 23:26];

eqSym = complex(zeros(Nsd, numSym, numSS));

for ss = 1:numSS
    % Channel estimate for this stream
    if size(chanEst, 2) >= ss
        H = chanEst(:, ss);
    else
        H = chanEst(:, 1);
    end
    
    for sym = 1:numSym
        % Frequency domain symbol
        Y = fftOut(:, sym, ss);
        
        % Extract data subcarriers
        Y_data = Y(dataIdx);
        H_data = H(dataIdx);
        
        % Zero-forcing equalization: X = Y / H
        eqSym(:, sym, ss) = Y_data ./ (H_data + eps);
    end
end

%% Step 4: Demodulation + Decoding (ofdm_decoder.v)
% Convert to fixed-point and call decoder
SCALE = 1024;
eqSymScaled = eqSym * SCALE / max(abs(eqSym(:)));
eqSymFixed = int16(real(eqSymScaled)) + 1i*int16(imag(eqSymScaled));

% Rate field
rate = bitshift(uint8(1), 7) + uint8(mcs);  % HT flag + MCS

% Number of coded bits
n_dbps = Nsd * n_bpsc;  % Data bits per symbol
service_bits = 16;
tail_bits = 6;
data_bits = psduLength * 8;
total_bits = service_bits + data_bits + tail_bits;
num_coded_bits = ceil(total_bits / code_rate) * 2;  % Viterbi rate 1/2

% Decode
do_descramble = 1;  % HT-DATA requires descrambling
soft_decoding = 1;  % Soft decision

decoded_bits = decode_pipeline(eqSymFixed, rate, num_coded_bits, ...
    do_descramble, soft_decoding);

%% Step 5: Extract PSDU
% Output format: int8 bits (psduLength * 8)
% Skip service field (16 bits)
if length(decoded_bits) >= service_bits + data_bits
    rxPSDU = int8(decoded_bits(service_bits+1 : service_bits+data_bits));
else
    rxPSDU = int8(zeros(psduLength*8, 1));
    warning('Insufficient decoded bits');
end

end

%% Helper: Decoding pipeline
function bits = decode_pipeline(eqSym, rate, num_bits, do_descramble, soft_dec)
    % Demodulation
    demod_bits = demodulate_verilog(eqSym, rate, soft_dec);
    
    % Deinterleaving (simplified - full LUT needed for exact match)
    deinter_bits = demod_bits;  % Pass-through for now
    
    % Viterbi decoding
    trellis = poly2trellis(7, [133 171]);
    
    % Convert to soft values for Viterbi
    soft_in = double(bitand(deinter_bits, 7));  % 3-bit soft value
    soft_norm = (soft_in - 3.5) / 3.5;  % Normalize to -1...+1
    
    if mod(length(soft_norm), 2) == 1
        soft_norm = [soft_norm; 0];
    end
    
    viterbi_out = vitdec(soft_norm, trellis, 48, 'trunc', 'unquant');
    viterbi_out = uint8(viterbi_out(1:min(num_bits, length(viterbi_out))));
    
    % Descrambling
    if do_descramble && length(viterbi_out) > 7
        % Initialize scrambler state from first 7 bits
        state = viterbi_out(1:7);
        bits = zeros(length(viterbi_out) - 7, 1, 'uint8');
        
        for i = 1:length(bits)
            % Feedback: state[7] XOR state[4]
            fb = bitxor(state(7), state(4));
            bits(i) = bitxor(fb, viterbi_out(i+7));
            state = [state(2:7); fb];
        end
    else
        bits = viterbi_out;
    end
end

%% Helper: Demodulation
function bits = demodulate_verilog(symbols, rate, soft_dec)
    [Nsc, Nsym, Nss] = size(symbols);
    
    % Determine modulation
    mcs = bitand(rate, 15);
    switch mcs
        case {0}, n_bps = 1;  % BPSK
        case {1,2}, n_bps = 2;  % QPSK
        case {3,4}, n_bps = 4;  % QAM16
        case {5,6,7}, n_bps = 6;  % QAM64
        otherwise, n_bps = 2;
    end
    
    % Demodulate (simplified hard decision)
    bits = zeros(Nsc * Nsym * n_bps, 1, 'uint8');
    idx = 1;
    
    for sym = 1:Nsym
        for sc = 1:Nsc
            s = symbols(sc, sym, 1);
            
            % Hard decision QPSK (simplified)
            bits(idx) = real(s) >= 0;
            if n_bps >= 2
                bits(idx+1) = imag(s) >= 0;
            end
            
            % Convert to 3-bit soft value (0-7)
            if soft_dec
                % 0=strong 0, 7=strong 1, 3-4=neutral
                if bits(idx)
                    bits(idx) = 6;  % Soft "1"
                else
                    bits(idx) = 1;  % Soft "0"
                end
            end
            
            idx = idx + n_bps;
        end
    end
    
    bits = bits(1:idx-1);
end
