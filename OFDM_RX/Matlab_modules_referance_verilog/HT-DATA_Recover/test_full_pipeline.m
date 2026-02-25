%% Test Script for Full HT-DATA Recovery Pipeline
% wlanHTDataRecover equivalent test - Time-domain samples to PSDU bytes

clear; clc; close all;

fprintf('=== Full HT-DATA Recovery Pipeline Test ===\n');
fprintf('(Time-domain samples → FFT → Equalization → Decoding → PSDU)\n\n');

%% Test Case 1: Generate synthetic HT packet
fprintf('Test 1: Synthetic HT-MCS 1 packet\n');
fprintf('----------------------------------\n');

% Configuration
cfg = struct();
cfg.mcs = 1;                % HT-MCS 1 (QPSK 1/2)
cfg.psduLength = 100;       % 100 bytes PSDU
cfg.channelBandwidth = 'CBW20';
cfg.numTx = 1;
cfg.numSTS = 1;
cfg.Nsd = 52;

% Calculate number of symbols needed
n_dbps = 52 * 2;  % 52 subcarriers * 2 bits/symbol (QPSK)
n_cbps = n_dbps * 2;  % Code rate 1/2
bits_needed = (16 + cfg.psduLength*8 + 6);  % Service + data + tail
cfg.numSym = ceil(bits_needed / n_dbps);

fprintf('PSDU Length: %d bytes\n', cfg.psduLength);
fprintf('Required OFDM symbols: %d\n', cfg.numSym);

% Generate test PSDU
txPSDU = randi([0, 255], cfg.psduLength, 1, 'uint8');

% Generate simplified HT packet (mock waveform)
% In real scenario, this would use wlanHTData or similar
Nfft = 64;
Ncp = 16;
samplesPerSym = Nfft + Ncp;
pktOffset = 0;  % Start from beginning

% Create mock equalized frequency-domain symbols
% (Normally these would come from properly generated waveform)
mock_fft_data = (randn(Nfft, cfg.numSym) + 1i*randn(Nfft, cfg.numSym)) / sqrt(2);

% Create time-domain samples (IFFT + add CP)
txWaveform = [];
for symIdx = 1:cfg.numSym
    % IFFT
    timeSym = ifft(mock_fft_data(:, symIdx), Nfft);
    % Add cyclic prefix
    cpSym = [timeSym(end-Ncp+1:end); timeSym];
    txWaveform = [txWaveform; cpSym];
end

fprintf('Generated waveform: %d samples\n', length(txWaveform));

% Test the recovery function
try
    tic;
    [rxPSDU, eqSym, chanEst] = ht_data_recover_full_fixed(txWaveform, ...
        pktOffset, cfg);
    elapsed = toc;
    
    fprintf('Recovery completed in %.3f ms\n', elapsed*1000);
    fprintf('Equalized symbols size: [%d x %d]\n', size(eqSym, 1), size(eqSym, 2));
    fprintf('Channel estimate size: [%d x %d x %d]\n', ...
        size(chanEst, 1), size(chanEst, 2), size(chanEst, 3));
    fprintf('Received PSDU length: %d bytes\n', length(rxPSDU));
    
    if length(rxPSDU) == cfg.psduLength
        fprintf('✓ PSDU length correct\n');
    else
        fprintf('✗ PSDU length mismatch\n');
    end
    
    fprintf('First 10 bytes (hex): ');
    for i = 1:min(10, length(rxPSDU))
        fprintf('%02X ', rxPSDU(i));
    end
    fprintf('\n');
    
catch ME
    fprintf('✗ Test failed: %s\n', ME.message);
    fprintf('   at %s:%d\n', ME.stack(1).name, ME.stack(1).line);
end

fprintf('\n');

%% Test Case 2: Different MCS rates
fprintf('Test 2: Multiple MCS rates\n');
fprintf('----------------------------------\n');

mcs_list = [0, 1, 3, 5, 7];
mcs_names = {'BPSK 1/2', 'QPSK 1/2', 'QAM16 1/2', 'QAM64 2/3', 'QAM64 5/6'};

for idx = 1:length(mcs_list)
    fprintf('Testing MCS %d (%s)... ', mcs_list(idx), mcs_names{idx});
    
    cfg_test = cfg;
    cfg_test.mcs = mcs_list(idx);
    cfg_test.psduLength = 50;
    
    % Recalculate symbols needed
    switch mcs_list(idx)
        case 0, n_dbps = 52 * 1; code_rate = 1/2;
        case 1, n_dbps = 52 * 2; code_rate = 1/2;
        case 3, n_dbps = 52 * 4; code_rate = 1/2;
        case 5, n_dbps = 52 * 6; code_rate = 2/3;
        case 7, n_dbps = 52 * 6; code_rate = 5/6;
    end
    bits_needed = (16 + cfg_test.psduLength*8 + 6);
    cfg_test.numSym = ceil(bits_needed / n_dbps);
    
    % Generate mock waveform
    mock_data = (randn(Nfft, cfg_test.numSym) + 1i*randn(Nfft, cfg_test.numSym));
    txWave = [];
    for s = 1:cfg_test.numSym
        t = ifft(mock_data(:, s), Nfft);
        txWave = [txWave; [t(end-Ncp+1:end); t]];
    end
    
    try
        [rxPSDU_test, ~, ~] = ht_data_recover_full_fixed(txWave, 0, cfg_test);
        if length(rxPSDU_test) == cfg_test.psduLength
            fprintf('✓ PASS (%d bytes)\n', length(rxPSDU_test));
        else
            fprintf('✗ FAIL (expected %d, got %d bytes)\n', ...
                cfg_test.psduLength, length(rxPSDU_test));
        end
    catch ME
        fprintf('✗ ERROR: %s\n', ME.message);
    end
end

fprintf('\n');

%% Test Case 3: Compare with WLAN Toolbox (if available)
fprintf('Test 3: WLAN Toolbox comparison\n');
fprintf('----------------------------------\n');

if exist('wlanHTConfig', 'file')
    fprintf('WLAN Toolbox detected\n');
    
    % Create HT configuration
    cfgHT = wlanHTConfig;
    cfgHT.ChannelBandwidth = 'CBW20';
    cfgHT.MCS = 1;
    cfgHT.PSDULength = 100;
    cfgHT.NumTransmitAntennas = 1;
    cfgHT.NumSpaceTimeStreams = 1;
    
    % Generate HT waveform
    txPSDU_wlan = randi([0, 255], cfgHT.PSDULength, 1, 'uint8');
    txWaveform_wlan = wlanWaveformGenerator(txPSDU_wlan, cfgHT);
    
    % Add some noise
    snr = 20;  % dB
    rxWaveform = awgn(txWaveform_wlan, snr, 'measured');
    
    % Get indices
    ind = wlanFieldIndices(cfgHT);
    
    % Extract HT-DATA field
    htDataStart = double(ind.HTData(1));
    htDataEnd = double(ind.HTData(2));
    htDataSamples = rxWaveform(htDataStart:htDataEnd);
    
    % Calculate number of symbols
    ofdmInfo = wlanHTOFDMInfo('HT-Data', cfgHT);
    numSym_wlan = ofdmInfo.NumSymbols;
    
    % Setup config for our function
    cfg_wlan = struct();
    cfg_wlan.mcs = cfgHT.MCS;
    cfg_wlan.psduLength = cfgHT.PSDULength;
    cfg_wlan.channelBandwidth = cfgHT.ChannelBandwidth;
    cfg_wlan.numTx = cfgHT.NumTransmitAntennas;
    cfg_wlan.numSTS = cfgHT.NumSpaceTimeStreams;
    cfg_wlan.Nsd = 52;
    cfg_wlan.numSym = numSym_wlan;
    
    fprintf('Testing with real WLAN packet (SNR=%d dB)...\n', snr);
    
    try
        % Our implementation
        tic;
        [rxPSDU_ours, eqSym_ours, chanEst_ours] = ...
            ht_data_recover_full_fixed(htDataSamples, 0, cfg_wlan);
        time_ours = toc;
        
        fprintf('Our implementation: %.3f ms\n', time_ours*1000);
        fprintf('Decoded %d bytes\n', length(rxPSDU_ours));
        
        % MATLAB reference (for comparison)
        % We need channel estimate and noise variance for wlanHTDataRecover
        % This is simplified - in real scenario we'd estimate these
        chanEst_ideal = ones(64, 1, cfgHT.NumSpaceTimeStreams);
        noiseVarEst = 10^(-snr/10);
        
        try
            [rxPSDU_matlab, ~] = wlanHTDataRecover(htDataSamples, ...
                chanEst_ideal, noiseVarEst, cfgHT);
            
            % Compare results
            if length(rxPSDU_matlab) == length(rxPSDU_ours)
                bit_errors = sum(rxPSDU_matlab ~= int8(rxPSDU_ours));
                ber = bit_errors / (length(rxPSDU_matlab) * 8);
                fprintf('BER compared to MATLAB: %.2e (%d bit errors)\n', ...
                    ber, bit_errors);
                
                if bit_errors == 0
                    fprintf('✓ Perfect match with MATLAB reference!\n');
                elseif ber < 0.01
                    fprintf('✓ Good match (BER < 1%%)\n');
                else
                    fprintf('⚠ Some differences detected\n');
                end
            else
                fprintf('⚠ Length mismatch with MATLAB\n');
            end
        catch ME_matlab
            fprintf('MATLAB wlanHTDataRecover error: %s\n', ME_matlab.message);
        end
        
    catch ME
        fprintf('✗ Our implementation failed: %s\n', ME.message);
    end
    
else
    fprintf('WLAN Toolbox not available - skipping comparison\n');
end

fprintf('\n');

%% Performance summary
fprintf('=== Test Summary ===\n');
fprintf('Full pipeline implementation tested\n');
fprintf('Key features:\n');
fprintf('  - Time-domain samples input\n');
fprintf('  - FFT processing\n');
fprintf('  - Channel equalization\n');
fprintf('  - Complete decoding chain\n');
fprintf('  - PSDU byte output\n');
fprintf('\n');
fprintf('This is a Verilog-equivalent golden reference model\n');
fprintf('For production use, validate against Verilog simulation\n');

%% Visualization (if data available)
if exist('eqSym', 'var') && ~isempty(eqSym)
    figure('Name', 'Equalized Constellation');
    plot(real(eqSym(:)), imag(eqSym(:)), '.');
    grid on;
    xlabel('In-phase');
    ylabel('Quadrature');
    title('Equalized Symbol Constellation');
    axis equal;
end
