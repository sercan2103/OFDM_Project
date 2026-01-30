% VERIFY_AGAINST_VERILOG - Verilog simulation sonuçları ile karşılaştırma
%
% Bu script, MATLAB modelinin Verilog implementasyonu ile birebir aynı
% sonuçlar ürettiğini doğrulamak için kullanılır.
%
% KULLANIM:
%   1. Verilog simülasyonundan test verileri export et
%   2. Bu script'i çalıştır
%   3. Sonuçları karşılaştır
%
% Yazar: MATLAB Referans Model Generator
% Tarih: 2026-01-29

clear; close all; clc;

fprintf('========================================\n');
fprintf('VERILOG VERIFICATION SCRIPT\n');
fprintf('========================================\n\n');

%% 1. Test Verilerini Hazırla veya Yükle

% SEÇENEK A: Verilog testbench'inden export edilen veriler
% (Bu bölümü kendi Verilog simulation outputlarınızla doldurun)
use_verilog_data = false;  % true yapın Verilog data varsa

if use_verilog_data
    fprintf('1. Verilog test verileri yükleniyor...\n');
    % Örnek: CSV veya MAT file'dan yükleme
    % verilog_samples = load('verilog_input_samples.mat');
    % verilog_timing_offset = load('verilog_timing_offset.mat');
    error('Verilog test verileri henüz yüklenmedi. use_verilog_data = false yapın.');
else
    fprintf('1. Sentetik test verileri oluşturuluyor...\n');
    % SEÇENEK B: Bilinen sonuçlu sentetik veri üret
    
    % LTS sequence üret
    lts_ideal = generate_lts_sequence();
    
    % Normalize ve scale
    lts_scaled = lts_ideal * 0.8;  % -1 ile +1 arası
    
    % Fixed-point'e çevir
    test_samples = convert_to_fixed_point(lts_scaled, 16);
    
    % Beklenen sonuç
    expected_detected = true;
    expected_timing_offset = 0;  % LTS baştan başlıyor
    
    fprintf('   Test sample sayısı: %d\n', length(test_samples));
end

%% 2. MATLAB Modelini Çalıştır

fprintf('\n2. MATLAB symbol timing estimator çalıştırılıyor...\n');
fft_win_shift = 0;

tic;
[matlab_detected, matlab_timing_offset, matlab_metric] = ...
    symbol_timing_estimator(test_samples, fft_win_shift);
matlab_time = toc;

fprintf('   İşlem süresi: %.3f ms\n', matlab_time * 1000);
fprintf('   Detected: %d\n', matlab_detected);
fprintf('   Timing offset: %d\n', matlab_timing_offset);

%% 3. Verilog ile Karşılaştır

fprintf('\n========================================\n');
fprintf('KARŞILAŞTIRMA SONUÇLARI\n');
fprintf('========================================\n\n');

if use_verilog_data
    % Verilog sonuçları ile karşılaştır
    fprintf('MATLAB vs VERILOG:\n');
    fprintf('------------------\n');
    fprintf('Detection:\n');
    fprintf('  MATLAB:   %d\n', matlab_detected);
    fprintf('  Verilog:  %d\n', verilog_detected);
    fprintf('  Match:    %s\n', iif(matlab_detected == verilog_detected, 'YES', 'NO'));
    
    fprintf('\nTiming Offset:\n');
    fprintf('  MATLAB:   %d samples\n', matlab_timing_offset);
    fprintf('  Verilog:  %d samples\n', verilog_timing_offset);
    fprintf('  Error:    %d samples\n', abs(matlab_timing_offset - verilog_timing_offset));
    fprintf('  Match:    %s\n', iif(abs(matlab_timing_offset - verilog_timing_offset) <= 1, 'YES', 'NO'));
    
else
    % Beklenen sonuçlar ile karşılaştır
    fprintf('MATLAB vs EXPECTED:\n');
    fprintf('-------------------\n');
    fprintf('Detection:\n');
    fprintf('  MATLAB:    %d\n', matlab_detected);
    fprintf('  Expected:  %d\n', expected_detected);
    fprintf('  Match:     %s\n', iif(matlab_detected == expected_detected, 'YES ✓', 'NO ✗'));
    
    fprintf('\nTiming Offset:\n');
    fprintf('  MATLAB:    %d samples\n', matlab_timing_offset);
    fprintf('  Expected:  %d samples\n', expected_timing_offset);
    fprintf('  Error:     %d samples\n', abs(matlab_timing_offset - expected_timing_offset));
    fprintf('  Match:     %s\n', iif(abs(matlab_timing_offset - expected_timing_offset) <= 2, 'YES ✓', 'NO ✗'));
end

%% 4. Metric Analizi

fprintf('\n========================================\n');
fprintf('METRIC ANALİZİ\n');
fprintf('========================================\n');
fprintf('Peak Metric Value:     %.2e\n', max(matlab_metric));
fprintf('Mean Metric Value:     %.2e\n', mean(matlab_metric));
fprintf('Std Metric Value:      %.2e\n', std(matlab_metric));
fprintf('Peak-to-Average Ratio: %.2f dB\n', ...
    10*log10(max(matlab_metric) / mean(matlab_metric)));
fprintf('SNR Estimate:          %.2f dB (approximate)\n', ...
    10*log10(max(matlab_metric) / median(matlab_metric)));

%% 5. Görselleştirme

fprintf('\n5. Sonuçlar görselleştiriliyor...\n');

figure('Name', 'MATLAB vs Verilog Comparison', 'Position', [100 100 1200 800]);

% Subplot 1: Correlation Metric
subplot(3,2,1);
plot(matlab_metric, 'b-', 'LineWidth', 2);
hold on;
if matlab_detected
    plot(matlab_timing_offset + 32, matlab_metric(matlab_timing_offset + 32), ...
        'ro', 'MarkerSize', 12, 'LineWidth', 2);
end
grid on;
xlabel('Sample Index');
ylabel('Correlation Metric');
title('MATLAB: Correlation Metric');
legend('Metric', 'Detected Peak');

% Subplot 2: Input Signal (Real)
subplot(3,2,2);
samples_double = double(real(test_samples));
plot(samples_double, 'b-', 'LineWidth', 1);
grid on;
xlabel('Sample Index');
ylabel('Amplitude (int16)');
title('Input Signal - Real Part');

% Subplot 3: Input Signal (Imag)
subplot(3,2,3);
samples_double = double(imag(test_samples));
plot(samples_double, 'r-', 'LineWidth', 1);
grid on;
xlabel('Sample Index');
ylabel('Amplitude (int16)');
title('Input Signal - Imaginary Part');

% Subplot 4: Magnitude
subplot(3,2,4);
stem(abs(double(test_samples)), 'b', 'LineWidth', 1);
grid on;
xlabel('Sample Index');
ylabel('Magnitude');
title('Input Signal - Magnitude');

% Subplot 5: Normalized Metric
subplot(3,2,5);
metric_norm = matlab_metric / max(matlab_metric);
plot(metric_norm, 'b-', 'LineWidth', 2);
hold on;
yline(0.5, 'r--', 'Threshold', 'LineWidth', 2);
grid on;
xlabel('Sample Index');
ylabel('Normalized Metric');
title('Normalized Correlation Metric');
ylim([0 1.1]);

% Subplot 6: Summary Text
subplot(3,2,6);
axis off;
summary_text = {
    'VERIFICATION SUMMARY',
    '====================',
    '',
    sprintf('Detection: %s', iif(matlab_detected, 'YES', 'NO')),
    sprintf('Timing Offset: %d samples', matlab_timing_offset),
    sprintf('Peak Metric: %.2e', max(matlab_metric)),
    sprintf('PAR: %.2f dB', 10*log10(max(matlab_metric) / mean(matlab_metric))),
    '',
    'STATUS:',
    iif(matlab_detected && abs(matlab_timing_offset - expected_timing_offset) <= 2, ...
        '✓ PASS', '✗ FAIL')
};
text(0.1, 0.5, summary_text, 'FontSize', 12, 'FontName', 'Courier', ...
    'VerticalAlignment', 'middle');

%% 6. Test Sonucu

fprintf('\n========================================\n');
fprintf('FINAL TEST RESULT\n');
fprintf('========================================\n');

if matlab_detected && abs(matlab_timing_offset - expected_timing_offset) <= 2
    fprintf('✓ TEST PASSED\n');
    fprintf('MATLAB model produces correct results!\n');
else
    fprintf('✗ TEST FAILED\n');
    fprintf('MATLAB model needs debugging.\n');
end

fprintf('========================================\n\n');

%% Helper Function
function out = iif(condition, true_val, false_val)
    if condition
        out = true_val;
    else
        out = false_val;
    end
end

%% VERILOG TESTBENCH INTEGRATION NOTES
%
% Verilog testbench'inizi şu şekilde düzenleyin:
%
% 1. INPUT EXPORT:
%    - sync_long modülüne giden sample_in sinyalini dosyaya yazın
%    - Format: CSV veya binary
%    - Örnek Verilog kod:
%      integer file_in;
%      file_in = $fopen("input_samples.csv", "w");
%      always @(posedge clock) begin
%        if (sample_in_strobe)
%          $fwrite(file_in, "%d,%d\n", sample_in[31:16], sample_in[15:0]);
%      end
%
% 2. OUTPUT EXPORT:
%    - long_preamble_detected ve timing_offset'i kaydedin
%    - Örnek:
%      integer file_out;
%      file_out = $fopen("output_results.txt", "w");
%      always @(posedge clock) begin
%        if (long_preamble_detected)
%          $fwrite(file_out, "Detected at offset: %d\n", timing_offset);
%      end
%
% 3. MATLAB'E IMPORT:
%    - CSV'yi readmatrix() ile okuyun
%    - Complex samples'a çevirin:
%      data = readmatrix('input_samples.csv');
%      samples_i = int16(data(:,1));
%      samples_q = int16(data(:,2));
%      samples = samples_i + 1i*samples_q;
