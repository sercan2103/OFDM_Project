%% Test: ht_data_recover_full_fixed (wlanHTDataRecover equivalent)
% Signature: [rxPSDU, eqSym] = fcn(rx, chanEst, nVarEst, pktOffset, simParams)

clear; clc;

fprintf('=== HT-DATA Recover Full Pipeline Test ===\n');
fprintf('(wlanHTDataRecover equivalent)\n\n');

%% Test 1: Basit mock test
fprintf('Test 1: Mock HT-MCS 1 packet\n');
fprintf('--------------------------------\n');

% Parametreler
simParams = struct();
simParams.mcs = 1;  % QPSK
simParams.psduLength = 100;  % 100 bytes
simParams.channelBandwidth = 'CBW20';
simParams.numTx = 1;
simParams.numSTS = 1;
simParams.numSS = 1;
simParams.Nsd = 52;
simParams.numSym = 20;  % 20 OFDM symbols

% Mock inputs
Nfft = 64;
Ncp = 16;
numSym = simParams.numSym;
samplesPerSym = Nfft + Ncp;

% Generate mock time-domain waveform
rx = (randn(numSym * samplesPerSym, 1) + 1i*randn(numSym * samplesPerSym, 1)) / sqrt(2);

% Mock channel estimate (ideal channel)
chanEst = ones(Nfft, simParams.numSTS);

% Noise variance
nVarEst = 0.01;

% Packet offset
pktOffset = 0;

% Test function
try
    tic;
    [rxPSDU, eqSym] = ht_data_recover_full_fixed(rx, chanEst, nVarEst, pktOffset, simParams);
    elapsed = toc;
    
    fprintf('✓ Function executed successfully\n');
    fprintf('  Time: %.2f ms\n', elapsed*1000);
    fprintf('  rxPSDU size: [%d x 1] (expected: %d bits)\n', length(rxPSDU), simParams.psduLength*8);
    fprintf('  eqSym size: [%d x %d x %d]\n', size(eqSym,1), size(eqSym,2), size(eqSym,3));

    % Plot equalized symbols (first spatial stream)
    eqSymPlot = eqSym(:,:,1);
    figure('Name','Equalized Symbols','NumberTitle','off');
    plot(real(eqSymPlot(:)), imag(eqSymPlot(:)), 'o');
    grid on;
    axis equal;
    xlabel('In-Phase');
    ylabel('Quadrature');
    title('Equalized Symbols (eqSym)');
    
    if length(rxPSDU) == simParams.psduLength*8
        fprintf('  ✓ Output size correct\n');
    else
        fprintf('  ✗ Output size mismatch\n');
    end
    
catch ME
    fprintf('✗ Error: %s\n', ME.message);
    fprintf('  at %s:%d\n', ME.stack(1).name, ME.stack(1).line);
end

fprintf('\n');

%% Test 2: WLAN Toolbox comparison (if available)
fprintf('Test 2: WLAN Toolbox comparison\n');
fprintf('--------------------------------\n');

if exist('wlanHTConfig', 'file') && exist('wlanWaveformGenerator', 'file')
    fprintf('WLAN Toolbox available\n');
    
    % Create HT packet
    cfgHT = wlanHTConfig;
    cfgHT.ChannelBandwidth = 'CBW20';
    cfgHT.MCS = 1;
    cfgHT.PSDULength = 100;
    
    % Generate PSDU
    txPSDU = randi([0 1], cfgHT.PSDULength*8, 1, 'int8');
    
    % Generate waveform
    txWave = wlanWaveformGenerator(txPSDU, cfgHT);
    
    % Add noise
    rxWave = awgn(txWave, 20, 'measured');
    
    % Get HT-DATA indices
    ind = wlanFieldIndices(cfgHT);
    htDataStart = double(ind.HTData(1));
    htDataEnd = double(ind.HTData(2));
    htData = rxWave(htDataStart:htDataEnd);
    
    % Get OFDM info
    ofdmInfo = wlanHTOFDMInfo('HT-Data', cfgHT);
    
    % Setup simParams
    simParams2 = struct();
    simParams2.mcs = cfgHT.MCS;
    simParams2.psduLength = cfgHT.PSDULength;
    simParams2.channelBandwidth = cfgHT.ChannelBandwidth;
    simParams2.numTx = 1;
    simParams2.numSTS = 1;
    simParams2.numSS = 1;
    simParams2.Nsd = 52;
    simParams2.numSym = ofdmInfo.NumDataSymbols;
    
    % Mock channel estimate (ideal)
    chanEst2 = ones(64, 1);
    nVarEst2 = 0.01;
    
    fprintf('Testing with WLAN-generated packet...\n');
    
    try
        % Our implementation
        [rxPSDU_ours, eqSym_ours] = ht_data_recover_full_fixed(...
            htData, chanEst2, nVarEst2, 0, simParams2);
        
        fprintf('  Our decoder: %d bits recovered\n', length(rxPSDU_ours));
        
        % Compare with input (ideal channel)
        if length(rxPSDU_ours) == length(txPSDU)
            errors = sum(rxPSDU_ours ~= txPSDU);
            ber = errors / length(txPSDU);
            fprintf('  BER: %.2e (%d errors)\n', ber, errors);
            
            if ber < 0.1
                fprintf('  ✓ Reasonable BER\n');
            else
                fprintf('  ⚠ High BER - check implementation\n');
            end
        end
        
        % Try MATLAB reference
        try
            [rxPSDU_matlab, ~] = wlanHTDataRecover(htData, chanEst2, nVarEst2, cfgHT);
            fprintf('  MATLAB wlanHTDataRecover: %d bits\n', length(rxPSDU_matlab));
            
            if length(rxPSDU_matlab) == length(rxPSDU_ours)
                diff = sum(rxPSDU_matlab ~= rxPSDU_ours);
                fprintf('  Difference from MATLAB: %d bits\n', diff);
            end
        catch
            fprintf('  MATLAB wlanHTDataRecover failed (normal for mock chanEst)\n');
        end
        
    catch ME
        fprintf('✗ Error: %s\n', ME.message);
    end
    
else
    fprintf('WLAN Toolbox not available - skipping\n');
end

fprintf('\n');

%% Test 3: Different MCS
fprintf('Test 3: Different MCS rates\n');
fprintf('--------------------------------\n');

mcs_list = [0, 1, 3, 5, 7];
names = {'BPSK', 'QPSK', 'QAM16', 'QAM64-2/3', 'QAM64-5/6'};

for i = 1:length(mcs_list)
    sp = struct();
    sp.mcs = mcs_list(i);
    sp.psduLength = 50;
    sp.channelBandwidth = 'CBW20';
    sp.numTx = 1;
    sp.numSTS = 1;
    sp.numSS = 1;
    sp.Nsd = 52;
    sp.numSym = 15;
    
    % Mock data
    rx_test = (randn(15*80, 1) + 1i*randn(15*80, 1)) / sqrt(2);
    ch_test = ones(64, 1);
    
    fprintf('  MCS %d (%s)... ', mcs_list(i), names{i});
    
    try
        [psdu_test, eq_test] = ht_data_recover_full_fixed(...
            rx_test, ch_test, 0.01, 0, sp);
        fprintf('✓ (%d bits)\n', length(psdu_test));
    catch ME
        fprintf('✗ Error\n');
    end
end

fprintf('\n');
fprintf('=== Test Complete ===\n');
fprintf('Signature matches: [rxPSDU,eqSym] = fcn(rx,chanEst,nVarEst,pktOffset,simParams)\n');
