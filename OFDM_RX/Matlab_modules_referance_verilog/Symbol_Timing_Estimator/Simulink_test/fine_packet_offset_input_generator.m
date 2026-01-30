%% FINE PACKET OFFSET ESTIMATOR - INPUT GENERATOR SCRIPT
% Fonksiyon için test input'ları üretir
% Fonksiyon: offset = fcn(rx, coarsePktOffset, simParams)

if ~exist('RUN_FROM_TESTER', 'var') || ~RUN_FROM_TESTER
    clear; close all; clc;
end

fprintf('========================================\n');
fprintf('Fine Packet Offset - Input Generator\n');
fprintf('========================================\n\n');

%% 1. SIMÜLASYON PARAMETRELERİ
fprintf('1. Simülasyon parametreleri tanımlanıyor...\n');

% Temel parametreler
simParams = struct();
simParams.channelBandwidth = 'CBW20';      % Channel Bandwidth: CBW20, CBW40, CBW80, CBW160
simParams.numPackets = 1;                  % Tek paket (symbol_timing_estimator testine benzer)
simParams.SNR_dB = 20;                     % Signal-to-Noise Ratio (dB)
simParams.samplingRate = 20e6;             % Sampling rate (20 MHz)
simParams.centerFrequency = 2.4e9;         % Center frequency (2.4 GHz)
simParams.timing_offset_samples = 50;      % Paket başlangıcı için pre-samples
simParams.enableChannel = false;           % Kanal modeli (false = sadece AWGN)

fprintf('   Channel Bandwidth: %s\n', simParams.channelBandwidth);
fprintf('   SNR: %.1f dB\n', simParams.SNR_dB);
fprintf('   Sampling Rate: %.2f MHz\n', simParams.samplingRate/1e6);
fprintf('   Timing Offset (pre-samples): %d samples\n', simParams.timing_offset_samples);

%% 2. WLAN KONFIGÜRASYONU
fprintf('\n2. WLAN konfigürasyonu ayarlanıyor...\n');

cfgHT = wlanHTConfig('ChannelBandwidth', simParams.channelBandwidth);
fprintf('   HT Config oluşturuldu\n');

% Field indices
ind = wlanFieldIndices(cfgHT);
fprintf('   Field Indices:\n');
fprintf('      LSTF: %d - %d\n', ind.LSTF(1), ind.LSTF(2));
fprintf('      LLTF: %d - %d\n', ind.LLTF(1), ind.LLTF(2));
fprintf('      LSIG: %d - %d\n', ind.LSIG(1), ind.LSIG(2));

%% 3. TEST SİNYALLERİ OLUŞTUR
fprintf('\n3. Test sinyalleri oluşturuluyor...\n');

% Test case'leri saklamak için cell array
testCases = cell(simParams.numPackets, 1);

for packet_idx = 1:simParams.numPackets
    fprintf('\n   Test Paket %d:\n', packet_idx);
    
    % ===== 802.11n HT Paket Oluştur =====
    % Payload
    numBits = 256;  % İlk test için kısa payload
    txBits = randi([0 1], numBits, 1);
    
    % OFDM Modülasyonu
    cfgHT.NumTransmitAntennas = 1;
    cfgHT.NumSpaceTimeStreams = 1;
    cfgHT.MCS = packet_idx - 1;  % MCS 0-2 arası
    
    % Signal üret
    txWaveform = wlanWaveformGenerator(txBits, cfgHT);
    
    % ===== KANAL SİMÜLASYONU (Opsiyonel) =====
    if simParams.enableChannel
        delayProfile = 'Model-A';  % ITU Indoor Propagation Model
        chCfg = wlanTGacChannel('DelayProfile', delayProfile, ...
                                'ChannelBandwidth', simParams.channelBandwidth, ...
                                'NumReceiveAntennas', 1, ...
                                'NumTransmitAntennas', 1, ...
                                'SampleRate', simParams.samplingRate);
        reset(chCfg);
        rxWaveform = chCfg(txWaveform);
    else
        rxWaveform = txWaveform;
    end
    
    % ===== GÜRÜLTÜ EKLE =====
    signalPower = mean(abs(rxWaveform).^2);
    noisePower = signalPower / (10^(simParams.SNR_dB/10));
    noise = sqrt(noisePower/2) * (randn(size(rxWaveform)) + 1j*randn(size(rxWaveform)));
    rxWaveform = rxWaveform + noise;
    
    % ===== TIMING OFFSET EKLE =====
    % Symbol timing estimator testine benzer: pre-samples ekle
    pre_samples = 0.01 * (randn(simParams.timing_offset_samples, 1) + 1i*randn(simParams.timing_offset_samples, 1));
    rxWaveform = [pre_samples; rxWaveform];

    % Kaba offset = pre-samples uzunluğu
    coarseOffset = simParams.timing_offset_samples;
    
    % Fine offset (referans)
    trueFinePktOffset = 0;
    
    % ===== TESTİ HAZIRLA =====
    testCases{packet_idx}.rx = rxWaveform;
    testCases{packet_idx}.coarsePktOffset = coarseOffset;
    testCases{packet_idx}.simParams = simParams;
    testCases{packet_idx}.cfgHT = cfgHT;
    testCases{packet_idx}.trueFinePktOffset = trueFinePktOffset;
    testCases{packet_idx}.txBits = txBits;
    testCases{packet_idx}.txWaveform = txWaveform;
    
    fprintf('      RX sinyal uzunluğu: %d samples\n', length(rxWaveform));
    fprintf('      Kaba offset: %d samples\n', coarseOffset);
    fprintf('      Gerçek fine offset: %.2f samples\n', trueFinePktOffset);
    fprintf('      MCS: %d\n', cfgHT.MCS);
end

%% 4. İNPUT'LAR WORKSPACE'E KAYDET
fprintf('\n4. Input''lar workspace''e kaydediliyor...\n');

% Test case'leri workspace'e ekle
assignin('base', 'testCases', testCases);
assignin('base', 'simParams', simParams);
assignin('base', 'cfgHT', cfgHT);
assignin('base', 'ind', ind);

fprintf('   ✓ testCases\n');
fprintf('   ✓ simParams\n');
fprintf('   ✓ cfgHT\n');
fprintf('   ✓ ind\n');

%% 5. İLK TEST CASE'İ DETAYLI GÖSTER
fprintf('\n5. İlk test case detayları:\n');
test1 = testCases{1};
fprintf('   RX sinyal:\n');
fprintf('      Min: %.6f\n', min(abs(test1.rx)));
fprintf('      Max: %.6f\n', max(abs(test1.rx)));
fprintf('      Mean: %.6f\n', mean(abs(test1.rx)));
fprintf('   Coarse offset: %d\n', test1.coarsePktOffset);
fprintf('   Channel Bandwidth: %s\n', test1.simParams.channelBandwidth);

%% 6. GÖRSELLEŞTİRME
fprintf('\n6. Test sinyalleri görselleştiriliyot...\n');

figure('Name', 'Test Input Signals', 'NumberTitle', 'off', 'Position', [100, 100, 1200, 800]);

for packet_idx = 1:simParams.numPackets
    % RX sinyali
    subplot(simParams.numPackets, 2, (packet_idx-1)*2 + 1);
    rx_signal = testCases{packet_idx}.rx;
    time_axis = (0:length(rx_signal)-1) / simParams.samplingRate * 1e6;  % microseconds
    
    plot(time_axis, real(rx_signal), 'b', 'DisplayName', 'Real');
    hold on;
    plot(time_axis, imag(rx_signal), 'r', 'DisplayName', 'Imag');
    
    % Coarse offset'i işaretle
    coarse_offset = testCases{packet_idx}.coarsePktOffset;
    xline(coarse_offset / simParams.samplingRate * 1e6, 'g--', 'LineWidth', 2, 'DisplayName', 'Coarse Offset');
    
    grid on;
    legend;
    xlabel('Time (μs)');
    ylabel('Amplitude');
    title(sprintf('Paket %d - RX Sinyal (Coarse Offset: %d)', packet_idx, coarse_offset));
    
    % Spektrum
    subplot(simParams.numPackets, 2, (packet_idx-1)*2 + 2);
    freq_spectrum = abs(fft(rx_signal));
    freq_axis = linspace(-simParams.samplingRate/2, simParams.samplingRate/2, length(freq_spectrum))/1e6;
    
    plot(freq_axis, 20*log10(freq_spectrum+1e-10));
    grid on;
    xlabel('Frequency (MHz)');
    ylabel('Magnitude (dB)');
    title(sprintf('Paket %d - Frekans Spektrumu', packet_idx));
end

%% 7. SUMMARY
fprintf('\n========================================\n');
fprintf('INPUT HAZIRLANMASI TAMAMLANDI\n');
fprintf('========================================\n');
fprintf('\nWorkspace değişkenleri:\n');
fprintf('  - testCases: %d paket için cell array\n', simParams.numPackets);
fprintf('  - simParams: Simülasyon parametreleri\n');
fprintf('  - cfgHT: WLAN HT konfigürasyonu\n');
fprintf('  - ind: Field indeksleri\n');
fprintf('\nSonraki adım: fine_packet_offset_tester.m çalıştır\n');

