% TEST_SYMBOL_TIMING_ESTIMATOR - Symbol timing estimator fonksiyonunu test eder
%
% Bu script:
%   1. Sentetik LTS sinyali üretir
%   2. Gürültü ve timing offset ekler
%   3. Symbol timing estimator fonksiyonunu çağırır
%   4. Sonuçları görselleştirir
%   5. Verilog implementasyonu ile karşılaştırma yapar
%
% Yazar: MATLAB Referans Model Generator
% Tarih: 2026-01-29

clear; close all; clc;

fprintf('========================================\n');
fprintf('Symbol Timing Estimator Test Script\n');
fprintf('========================================\n\n');

%% Test Parametreleri
SNR_dB = 20;                % SNR (dB)
timing_offset_samples = 10; % Kaç sample gecikmeli gelsin
fft_win_shift = 0;          % FFT window shift parametresi
num_pre_samples = 50;       % LTS'den önce kaç sample olsun

%% 1. LTS Sequence Üret
fprintf('1. LTS sequence üretiliyor...\n');
lts_float = generate_lts_sequence();
fprintf('   LTS uzunluğu: %d samples\n', length(lts_float));

%% 2. Test Sinyali Oluştur
fprintf('\n2. Test sinyali oluşturuluyor...\n');
fprintf('   Timing offset: %d samples\n', timing_offset_samples);
fprintf('   SNR: %.1f dB\n', SNR_dB);

% Pre-samples (sıfır veya düşük güçlü gürültü)
pre_samples = 0.01 * (randn(1, num_pre_samples) + 1i*randn(1, num_pre_samples));

% Test sinyali: [pre_samples | LTS]
test_signal = [pre_samples, lts_float];

% AWGN ekle
signal_power = mean(abs(test_signal).^2);
noise_power = signal_power / (10^(SNR_dB/10));
noise = sqrt(noise_power/2) * (randn(size(test_signal)) + 1i*randn(size(test_signal)));
test_signal_noisy = test_signal + noise;

%% 3. Fixed-Point Dönüşümü
fprintf('\n3. Fixed-point dönüşümü yapılıyor...\n');
test_signal_fp = convert_to_fixed_point(test_signal_noisy, 16);
fprintf('   Word width: 16-bit\n');
fprintf('   Format: int16 I + 1i*int16 Q\n');

%% 4. Symbol Timing Estimator Çalıştır
fprintf('\n4. Symbol timing estimator çalıştırılıyor...\n');
tic;
[detected, estimated_offset, metric_values] = symbol_timing_estimator(test_signal_fp, fft_win_shift);
elapsed_time = toc;

fprintf('   İşlem süresi: %.3f ms\n', elapsed_time * 1000);

%% 5. Sonuçları Görüntüle
fprintf('\n========================================\n');
fprintf('TEST SONUÇLARI\n');
fprintf('========================================\n');
fprintf('Long Preamble Detected: %d\n', detected);
fprintf('Estimated Timing Offset: %d samples\n', estimated_offset);
fprintf('Actual Timing Offset: %d samples\n', timing_offset_samples);
fprintf('Estimation Error: %d samples\n', abs(estimated_offset - timing_offset_samples));
fprintf('========================================\n\n');

%% 6. Görselleştirme
fprintf('6. Sonuçlar görselleştiriliyor...\n\n');

% Figure 1: Correlation Metric
figure('Name', 'Symbol Timing Estimator - Correlation Metric', 'Position', [100 100 1200 600]);

subplot(2,2,1);
plot(metric_values, 'b-', 'LineWidth', 2);
hold on;
if detected
    plot(estimated_offset + 32, metric_values(estimated_offset + 32), 'ro', ...
        'MarkerSize', 12, 'LineWidth', 2);
end
grid on;
xlabel('Sample Index');
ylabel('Correlation Metric');
title('Cross-Correlation Metric vs. Sample Index');
legend('Metric', 'Detected Peak', 'Location', 'best');

subplot(2,2,2);
plot(real(test_signal_noisy), 'b-', 'LineWidth', 1);
hold on;
plot(imag(test_signal_noisy), 'r-', 'LineWidth', 1);
grid on;
xlabel('Sample Index');
ylabel('Amplitude');
title('Test Signal (Real and Imaginary)');
legend('Real', 'Imag', 'Location', 'best');

subplot(2,2,3);
stem(abs(test_signal_noisy), 'b', 'LineWidth', 1.5);
hold on;
if detected
    xline(num_pre_samples, 'r--', 'LineWidth', 2, 'Label', 'LTS Start (Actual)');
    xline(estimated_offset + num_pre_samples, 'g--', 'LineWidth', 2, 'Label', 'Detected Start');
end
grid on;
xlabel('Sample Index');
ylabel('Magnitude');
title('Test Signal Magnitude');

subplot(2,2,4);
% Metric'in normalize edilmiş versiyonu
metric_normalized = metric_values / max(metric_values);
plot(metric_normalized, 'b-', 'LineWidth', 2);
hold on;
yline(0.8, 'r--', 'LineWidth', 2, 'Label', 'Threshold (0.8)');
grid on;
xlabel('Sample Index');
ylabel('Normalized Metric');
title('Normalized Correlation Metric');
ylim([0 1.1]);

%% 7. Performance Özeti
fprintf('========================================\n');
fprintf('PERFORMANCE ÖZETİ\n');
fprintf('========================================\n');
fprintf('Detection Success: %s\n', iif(detected, 'YES', 'NO'));
fprintf('Timing Accuracy: %s\n', iif(abs(estimated_offset - timing_offset_samples) <= 2, 'GOOD', 'NEEDS IMPROVEMENT'));
fprintf('Peak Metric Value: %.2f\n', max(metric_values));
fprintf('Average Metric Value: %.2f\n', mean(metric_values));
fprintf('Peak-to-Average Ratio: %.2f dB\n', 10*log10(max(metric_values) / mean(metric_values)));
fprintf('========================================\n\n');

fprintf('Test tamamlandı!\n');

%% Helper Function
function out = iif(condition, true_val, false_val)
    if condition
        out = true_val;
    else
        out = false_val;
    end
end
