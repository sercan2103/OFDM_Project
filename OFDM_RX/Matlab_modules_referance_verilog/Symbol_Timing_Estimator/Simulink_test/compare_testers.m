%% COMPARE FINE PACKET OFFSET TESTER vs SYMBOL TIMING ESTIMATOR
% Her iki tester'ın sonuçlarını ve performansını karşılaştırır
%
% Bu script:
%   1. Her iki tester'ı çalıştırır (varsa)
%   2. Sonuçları yan yana gösterir
%   3. Performans metrikleri karşılaştırır
%   4. Offset tahminlerini analiz eder

% Add parent directory to path FIRST - before anything else
current_file = mfilename('fullpath');
[script_dir, ~, ~] = fileparts(current_file);
parent_dir = fileparts(script_dir);
addpath(parent_dir);

clear; close all; clc;

fprintf('========================================\n');
fprintf('FINE PACKET OFFSET vs SYMBOL TIMING EST.\n');
fprintf('========================================\n\n');

%% 1. SYMBOL TIMING ESTIMATOR TEST'İ ÇALIŞTIR
fprintf('1. Symbol Timing Estimator test çalıştırılıyor...\n');

% Symbol timing estimator parametreleri
SNR_dB = 20;
timing_offset_samples = 50;
fft_win_shift = 0;
num_pre_samples = 50;

% LTS sequence üret
lts_float = generate_lts_sequence();

% Test sinyali oluştur
pre_samples = 0.01 * (randn(1, num_pre_samples) + 1i*randn(1, num_pre_samples));
test_signal = [pre_samples, lts_float];

% Gürültü ekle
signal_power = mean(abs(test_signal).^2);
noise_power = signal_power / (10^(SNR_dB/10));
noise = sqrt(noise_power/2) * (randn(size(test_signal)) + 1i*randn(size(test_signal)));
test_signal_noisy = test_signal + noise;

% Fixed-point dönüşümü
test_signal_fp = convert_to_fixed_point(test_signal_noisy, 16);

% Symbol timing estimator çalıştır
tic;
[detected_ste, estimated_offset_ste, metric_values_ste] = symbol_timing_estimator(test_signal_fp, fft_win_shift);
time_ste = toc;

fprintf('   ✓ Symbol Timing Estimator tamamlandı (%.3f ms)\n', time_ste*1000);

%% 2. FINE PACKET OFFSET TESTER'İ ÇALIŞTIR (MATLAB Reference)
fprintf('\n2. Fine Packet Offset tester çalıştırılıyor...\n');
fprintf('   (Using MATLAB wlanSymbolTimingEstimate reference)\n');

% Fine packet offset parametreleri (symbol timing estimator'a benzer)
simParams = struct();
simParams.channelBandwidth = 'CBW20';
simParams.numPackets = 1;
simParams.SNR_dB = SNR_dB;
simParams.samplingRate = 20e6;
simParams.timing_offset_samples = num_pre_samples;
simParams.enableChannel = false;

cfgHT = wlanHTConfig('ChannelBandwidth', simParams.channelBandwidth);
ind = wlanFieldIndices(cfgHT);

% Test case oluştur (symbol timing estimator'a benzer)
testCases = cell(1, 1);
testCases{1}.rx = test_signal_noisy;  % Aynı sinyal
testCases{1}.coarsePktOffset = num_pre_samples;
testCases{1}.simParams = simParams;
testCases{1}.cfgHT = cfgHT;
testCases{1}.trueFinePktOffset = 0;

% Fine packet offset fonksiyonunu çalıştır
tic;
offset_fpo = fine_packet_offset_fcn(testCases{1}.rx, testCases{1}.coarsePktOffset, testCases{1}.simParams);
time_fpo = toc;

fprintf('   ✓ Fine Packet Offset tamamlandı (%.3f ms)\n', time_fpo*1000);

% Metrik ve fine offset al (wlanSymbolTimingEstimate kullanarak)
try
    % Extract from coarse offset (which is num_pre_samples)
    idx_start = testCases{1}.coarsePktOffset + 1;
    idx_end = testCases{1}.coarsePktOffset + double(ind.LSIG(2));
    idx_start = max(1, idx_start);
    idx_end = min(length(testCases{1}.rx), idx_end);
    
    if idx_end >= idx_start && idx_end - idx_start >= 64  % Need at least 64 samples
        nonhtfields = testCases{1}.rx(idx_start:idx_end, :);
        [fine_est_fpo, metric_fpo] = wlanSymbolTimingEstimate(nonhtfields, simParams.channelBandwidth);
        metric_values_fpo = metric_fpo;
        % Detection: valid offset returned (not empty, not NaN)
        detected_fpo = ~isnan(fine_est_fpo(1));
    else
        metric_values_fpo = [];
        detected_fpo = false;
        fine_est_fpo = NaN;
    end
catch
    metric_values_fpo = [];
    detected_fpo = false;
    fine_est_fpo = NaN;
end

%% 3. SONUÇLARI KARŞILAŞTIR
fprintf('\n========================================\n');
fprintf('KARŞILAŞTIRMA ÖZETİ\n');
fprintf('========================================\n\n');

fprintf('TEST PARAMETRELERİ:\n');
fprintf('  SNR: %.1f dB\n', SNR_dB);
fprintf('  Timing Offset (pre-samples): %d\n', num_pre_samples);
fprintf('  Signal Length: %d samples\n', length(test_signal_noisy));
fprintf('  Channel: AWGN (No multipath)\n\n');

fprintf('DETECTION RESULTS:\n');
fprintf('┌────────────────────────────────┬───────────────┬───────────────┐\n');
fprintf('│ Metric                         │ Symbol Timing │ Fine Packet   │\n');
fprintf('├────────────────────────────────┼───────────────┼───────────────┤\n');

% Detected
fprintf('│ Detected                       │ %13s │ %13s │\n', ...
    iif(detected_ste, 'YES', 'NO'), iif(detected_fpo, 'YES', 'NO'));

% Estimated offset
fprintf('│ Estimated Offset (samples)     │ %13.2f │ %13.2f │\n', ...
    estimated_offset_ste + num_pre_samples, offset_fpo);

% Reference offset
fprintf('│ Reference Offset (samples)     │ %13d │ %13d │\n', ...
    num_pre_samples, num_pre_samples);

% Error
error_ste = abs((estimated_offset_ste + num_pre_samples) - num_pre_samples);
error_fpo = abs(offset_fpo - num_pre_samples);
fprintf('│ Estimation Error (samples)     │ %13.2f │ %13.2f │\n', error_ste, error_fpo);

% Execution time
fprintf('│ Execution Time (ms)            │ %13.3f │ %13.3f │\n', ...
    time_ste*1000, time_fpo*1000);

% Peak metric
if ~isempty(metric_values_ste)
    peak_ste = max(metric_values_ste);
    avg_ste = mean(metric_values_ste);
    par_ste = 10*log10(peak_ste / avg_ste);
else
    peak_ste = NaN;
    avg_ste = NaN;
    par_ste = NaN;
end

if ~isempty(metric_values_fpo)
    peak_fpo = max(metric_values_fpo);
    avg_fpo = mean(metric_values_fpo);
    par_fpo = 10*log10(peak_fpo / avg_fpo);
else
    peak_fpo = NaN;
    avg_fpo = NaN;
    par_fpo = NaN;
end

fprintf('│ Peak Metric Value              │ %13.2f │ %13.2f │\n', peak_ste, peak_fpo);
fprintf('│ Average Metric Value           │ %13.2f │ %13.2f │\n', avg_ste, avg_fpo);
fprintf('│ Peak-to-Avg Ratio (dB)         │ %13.2f │ %13.2f │\n', par_ste, par_fpo);

fprintf('└────────────────────────────────┴───────────────┴───────────────┘\n\n');

%% 4. GRAFIKLER - KARŞILAŞTIRMA
fprintf('4. Karşılaştırma grafikleri oluşturuluyor...\n\n');

figure('Name', 'Comparison: Fine Packet Offset vs Symbol Timing Estimator', ...
       'NumberTitle', 'off', 'Position', [100, 100, 1600, 900]);

% ===== ROW 1: CORRELATION METRIC =====
% Symbol Timing Estimator
subplot(3, 2, 1);
plot(metric_values_ste, 'b-', 'LineWidth', 2);
hold on;
if detected_ste && ~isnan(estimated_offset_ste)
    peak_idx_ste = estimated_offset_ste + 32;
    if peak_idx_ste > 0 && peak_idx_ste <= length(metric_values_ste)
        plot(peak_idx_ste, metric_values_ste(peak_idx_ste), 'ro', ...
            'MarkerSize', 10, 'LineWidth', 2);
    end
end
grid on;
xlabel('Sample Index');
ylabel('Correlation Metric');
title('Symbol Timing Estimator - Metric');
legend('Metric', 'Detected Peak', 'Location', 'best');

% Fine Packet Offset
subplot(3, 2, 2);
plot(metric_values_fpo, 'b-', 'LineWidth', 2);
hold on;
if detected_fpo && ~isempty(metric_values_fpo)
    [~, peak_idx_fpo] = max(metric_values_fpo);
    plot(peak_idx_fpo, metric_values_fpo(peak_idx_fpo), 'ro', ...
        'MarkerSize', 10, 'LineWidth', 2);
end
grid on;
xlabel('Sample Index');
ylabel('Correlation Metric');
title('Fine Packet Offset - Metric');
legend('Metric', 'Detected Peak', 'Location', 'best');

% ===== ROW 2: REAL/IMAG SIGNAL =====
% Symbol Timing Estimator
subplot(3, 2, 3);
plot(real(test_signal_noisy), 'b-', 'LineWidth', 1);
hold on;
plot(imag(test_signal_noisy), 'r-', 'LineWidth', 1);
grid on;
xlabel('Sample Index');
ylabel('Amplitude');
title('Symbol Timing Estimator - IQ Signal');
legend('Real', 'Imag', 'Location', 'best');

% Fine Packet Offset (same signal)
subplot(3, 2, 4);
plot(real(testCases{1}.rx), 'b-', 'LineWidth', 1);
hold on;
plot(imag(testCases{1}.rx), 'r-', 'LineWidth', 1);
grid on;
xlabel('Sample Index');
ylabel('Amplitude');
title('Fine Packet Offset - IQ Signal');
legend('Real', 'Imag', 'Location', 'best');

% ===== ROW 3: MAGNITUDE & OFFSETS =====
% Symbol Timing Estimator
subplot(3, 2, 5);
stem(abs(test_signal_noisy), 'b', 'LineWidth', 1.5);
hold on;
xline(num_pre_samples, 'r--', 'LineWidth', 2, 'Label', 'LTS Start (Actual)');
xline(estimated_offset_ste + num_pre_samples, 'g--', 'LineWidth', 2, 'Label', 'Detected Start');
grid on;
xlabel('Sample Index');
ylabel('Magnitude');
title('Symbol Timing Estimator - Magnitude & Offsets');

% Fine Packet Offset
subplot(3, 2, 6);
stem(abs(testCases{1}.rx), 'b', 'LineWidth', 1.5);
hold on;
xline(num_pre_samples, 'r--', 'LineWidth', 2, 'Label', 'Coarse Offset');
xline(offset_fpo, 'g--', 'LineWidth', 2, 'Label', 'Fine Packet Offset');
grid on;
xlabel('Sample Index');
ylabel('Magnitude');
title('Fine Packet Offset - Magnitude & Offsets');

%% 5. NORMALIZED METRIC COMPARISON
fprintf('5. Normalized metric grafikleri oluşturuluyor...\n\n');

figure('Name', 'Normalized Metric Comparison', 'NumberTitle', 'off', 'Position', [200, 200, 1400, 600]);

% Symbol Timing Estimator
subplot(1, 2, 1);
if ~isempty(metric_values_ste)
    metric_norm_ste = metric_values_ste / max(metric_values_ste);
    plot(metric_norm_ste, 'b-', 'LineWidth', 2);
    hold on;
    yline(0.8, 'r--', 'LineWidth', 2, 'Label', 'Threshold (0.8)');
    grid on;
    xlabel('Sample Index');
    ylabel('Normalized Metric');
    title('Symbol Timing Estimator - Normalized Metric');
    ylim([0 1.1]);
    legend('Metric', 'Threshold', 'Location', 'best');
end

% Fine Packet Offset
subplot(1, 2, 2);
if ~isempty(metric_values_fpo)
    metric_norm_fpo = metric_values_fpo / max(metric_values_fpo);
    plot(metric_norm_fpo, 'b-', 'LineWidth', 2);
    hold on;
    yline(0.8, 'r--', 'LineWidth', 2, 'Label', 'Threshold (0.8)');
    grid on;
    xlabel('Sample Index');
    ylabel('Normalized Metric');
    title('Fine Packet Offset - Normalized Metric');
    ylim([0 1.1]);
    legend('Metric', 'Threshold', 'Location', 'best');
end

%% 6. PERFORMANS TABLOSU
fprintf('========================================\n');
fprintf('PERFORMANCE ÖZET\n');
fprintf('========================================\n\n');

fprintf('SYMBOL TIMING ESTIMATOR:\n');
fprintf('  Detection: %s\n', iif(detected_ste, 'YES', 'NO'));
fprintf('  Timing Accuracy: %s (Error: %.2f samples)\n', ...
    iif(error_ste <= 2, 'GOOD', 'NEEDS IMPROVEMENT'), error_ste);
fprintf('  Peak Metric: %.2f\n', peak_ste);
fprintf('  Avg Metric: %.2f\n', avg_ste);
fprintf('  Peak-to-Avg Ratio: %.2f dB\n', par_ste);
fprintf('  Execution Time: %.3f ms\n\n', time_ste*1000);

fprintf('FINE PACKET OFFSET:\n');
fprintf('  Detection: %s\n', iif(detected_fpo, 'YES', 'NO'));
fprintf('  Timing Accuracy: %s (Error: %.2f samples)\n', ...
    iif(error_fpo <= 2, 'GOOD', 'NEEDS IMPROVEMENT'), error_fpo);
fprintf('  Peak Metric: %.2f\n', peak_fpo);
fprintf('  Avg Metric: %.2f\n', avg_fpo);
fprintf('  Peak-to-Avg Ratio: %.2f dB\n', par_fpo);
fprintf('  Execution Time: %.3f ms\n\n', time_fpo*1000);

fprintf('KARŞILAŞTIRMA:\n');
fprintf('  Offset Farkı: %.2f samples\n', abs((estimated_offset_ste + num_pre_samples) - offset_fpo));
fprintf('  Metric Farkı (Peak): %.2f\n', abs(peak_ste - peak_fpo));
fprintf('  Hız Farkı: %.3f ms (Fine Packet: %s)\n', ...
    abs(time_ste - time_fpo)*1000, ...
    iif(time_fpo < time_ste, 'Faster', 'Slower'));

if abs((estimated_offset_ste + num_pre_samples) - offset_fpo) <= 2
    fprintf('  ✓ İKİ TESİ BENZERDİR (Offset farkı <= 2 samples)\n');
else
    fprintf('  ⚠ TESİ ARASI FARKI VAR (Offset farkı > 2 samples)\n');
end

fprintf('========================================\n');

%% 7. WORKSPACE'E KAYDET
assignin('base', 'comparison_results', struct(...
    'symbol_timing_estimator', struct(...
        'detected', detected_ste, ...
        'offset', estimated_offset_ste + num_pre_samples, ...
        'error', error_ste, ...
        'metric_peak', peak_ste, ...
        'metric_avg', avg_ste, ...
        'metric_ratio_db', par_ste, ...
        'execution_time_ms', time_ste*1000), ...
    'fine_packet_offset', struct(...
        'detected', detected_fpo, ...
        'offset', offset_fpo, ...
        'error', error_fpo, ...
        'metric_peak', peak_fpo, ...
        'metric_avg', avg_fpo, ...
        'metric_ratio_db', par_fpo, ...
        'execution_time_ms', time_fpo*1000)));

fprintf('\nComparison results saved to workspace: comparison_results\n');

%% YARDIMCI FONKSİYON
function result = iif(condition, true_val, false_val)
    if condition
        result = true_val;
    else
        result = false_val;
    end
end
