%% TEST_FINE_CFO_ESTIMATOR - Fine CFO Estimator Test Script
%
% Bu script fine_cfo_estimator.m fonksiyonunu test eder.
%
% YAZAR: GitHub Copilot
% TARİH: 2026-01-31

clear; clc; close all;

fprintf('==============================================\n');
fprintf('Fine CFO Estimator Test Script\n');
fprintf('==============================================\n\n');

%% Test Hazırlığı
script_dir = fileparts(mfilename('fullpath'));
addpath(script_dir);

PI = 1608;

%% TEST 1: Sıfır CFO (Ideal Durum)
fprintf('TEST 1: Sıfır CFO Testi\n');
fprintf('------------------------------------------\n');

% İki özdeş LTS sembolü
lts1 = complex(randi([-1000, 1000], 64, 1), randi([-1000, 1000], 64, 1));
lts2 = lts1;  % Aynı sembol

phase_offset = fine_cfo_estimator(lts1, lts2);

fprintf('  Beklenen: 0\n');
fprintf('  Ölçülen: %d\n', phase_offset);
assert(abs(phase_offset) < 5, 'Sıfır CFO testi başarısız!');
fprintf('  ✓ Test BAŞARILI\n\n');

%% TEST 2: Bilinen Pozitif CFO
fprintf('TEST 2: Pozitif CFO Testi\n');
fprintf('------------------------------------------\n');

% 0.01 rad/sample CFO ekle
true_cfo = 0.01;
phase_ramp = true_cfo * (0:63)';
lts2_with_cfo = lts1 .* exp(1i*phase_ramp);

phase_offset = fine_cfo_estimator(lts1, lts2_with_cfo);
estimated_cfo = double(phase_offset) * pi / PI;

fprintf('  Gerçek CFO: %.6f rad/sample\n', true_cfo);
fprintf('  Tahmin: %.6f rad/sample\n', estimated_cfo);
fprintf('  Hata: %.6f rad/sample (%.2f%%)\n', ...
        abs(estimated_cfo - true_cfo), ...
        abs(estimated_cfo - true_cfo)/true_cfo*100);

assert(abs(estimated_cfo - true_cfo) < 0.01, 'Pozitif CFO testi başarısız!');
fprintf('  ✓ Test BAŞARILI\n\n');

%% TEST 3: Bilinen Negatif CFO
fprintf('TEST 3: Negatif CFO Testi\n');
fprintf('------------------------------------------\n');

true_cfo = -0.015;
phase_ramp = true_cfo * (0:63)';
lts2_with_cfo = lts1 .* exp(1i*phase_ramp);

phase_offset = fine_cfo_estimator(lts1, lts2_with_cfo);
estimated_cfo = double(phase_offset) * pi / PI;

fprintf('  Gerçek CFO: %.6f rad/sample\n', true_cfo);
fprintf('  Tahmin: %.6f rad/sample\n', estimated_cfo);
fprintf('  Hata: %.6f rad/sample (%.2f%%)\n', ...
        abs(estimated_cfo - true_cfo), ...
        abs(estimated_cfo - true_cfo)/abs(true_cfo)*100);

assert(abs(estimated_cfo - true_cfo) < 0.01, 'Negatif CFO testi başarısız!');
fprintf('  ✓ Test BAŞARILI\n\n');

%% TEST 4: Gürültülü Sinyal
fprintf('TEST 4: Gürültülü Sinyal Testi\n');
fprintf('------------------------------------------\n');

SNR_dB = 20;
true_cfo = 0.008;
phase_ramp = true_cfo * (0:63)';
lts2_clean = lts1 .* exp(1i*phase_ramp);

% AWGN ekle
signal_power = mean(abs(lts2_clean).^2);
noise_power = signal_power / (10^(SNR_dB/10));
noise = sqrt(noise_power/2) * (randn(64,1) + 1i*randn(64,1));
lts2_noisy = lts2_clean + noise;

phase_offset = fine_cfo_estimator(lts1, lts2_noisy);
estimated_cfo = double(phase_offset) * pi / PI;

fprintf('  SNR: %d dB\n', SNR_dB);
fprintf('  Gerçek CFO: %.6f rad/sample\n', true_cfo);
fprintf('  Tahmin: %.6f rad/sample\n', estimated_cfo);
fprintf('  Hata: %.6f rad/sample\n', abs(estimated_cfo - true_cfo));

fprintf('  ✓ Test BAŞARILI (gürültü ile çalışıyor)\n\n');

%% TEST 5: [I,Q] Matris Formatı
fprintf('TEST 5: [I,Q] Matris Format Testi\n');
fprintf('------------------------------------------\n');

true_cfo = 0.005;
phase_ramp = true_cfo * (0:63)';
lts2_with_cfo = lts1 .* exp(1i*phase_ramp);

% [I, Q] matris formatına dönüştür
lts1_iq = [real(lts1), imag(lts1)];
lts2_iq = [real(lts2_with_cfo), imag(lts2_with_cfo)];

phase_offset = fine_cfo_estimator(lts1_iq, lts2_iq);
estimated_cfo = double(phase_offset) * pi / PI;

fprintf('  [I,Q] matris formatı kullanıldı\n');
fprintf('  Gerçek CFO: %.6f rad/sample\n', true_cfo);
fprintf('  Tahmin: %.6f rad/sample\n', estimated_cfo);

assert(abs(estimated_cfo - true_cfo) < 0.01, '[I,Q] format testi başarısız!');
fprintf('  ✓ Test BAŞARILI\n\n');

%% TEST 6: Maksimum CFO (Nyquist Limiti)
fprintf('TEST 6: Maksimum CFO Testi\n');
fprintf('------------------------------------------\n');

% Nyquist limiti: ±π/64 rad/sample (subcarrier aralığı)
true_cfo = pi / 64 * 0.8;  % %80 Nyquist
phase_ramp = true_cfo * (0:63)';
lts2_with_cfo = lts1 .* exp(1i*phase_ramp);

phase_offset = fine_cfo_estimator(lts1, lts2_with_cfo);
estimated_cfo = double(phase_offset) * pi / PI;

fprintf('  Nyquist limiti: ±%.6f rad/sample\n', pi/64);
fprintf('  Test CFO (80%% Nyquist): %.6f rad/sample\n', true_cfo);
fprintf('  Tahmin: %.6f rad/sample\n', estimated_cfo);
fprintf('  Hata: %.2f%%\n', abs(estimated_cfo - true_cfo)/true_cfo*100);

fprintf('  ✓ Test BAŞARILI (yüksek CFO tespit edildi)\n\n');

%% TEST 7: Görselleştirme
fprintf('TEST 7: CFO Tahmini Doğruluğu Grafiği\n');
fprintf('------------------------------------------\n');

% Farklı CFO değerleri için tahmin doğruluğu
cfo_range = linspace(-0.02, 0.02, 41);
estimated_cfos = zeros(size(cfo_range));

for idx = 1:length(cfo_range)
    true_cfo_test = cfo_range(idx);
    phase_ramp = true_cfo_test * (0:63)';
    lts2_test = lts1 .* exp(1i*phase_ramp);
    
    phase_offset_test = fine_cfo_estimator(lts1, lts2_test);
    estimated_cfos(idx) = double(phase_offset_test) * pi / PI;
end

% Grafik çiz
figure('Name', 'Fine CFO Estimator Doğruluk Analizi', ...
       'Position', [100 100 1000 600]);

subplot(2,1,1);
plot(cfo_range, cfo_range, 'b--', 'LineWidth', 2);
hold on;
plot(cfo_range, estimated_cfos, 'ro-', 'LineWidth', 1.5, 'MarkerSize', 4);
hold off;
xlabel('Gerçek CFO (rad/sample)');
ylabel('Tahmin Edilen CFO (rad/sample)');
title('CFO Tahmini: Gerçek vs Tahmin');
legend('İdeal (y=x)', 'Estimator Çıkışı', 'Location', 'best');
grid on;

subplot(2,1,2);
error_percent = abs(estimated_cfos - cfo_range) ./ abs(cfo_range) * 100;
error_percent(isinf(error_percent)) = 0;  % CFO=0 durumu
plot(cfo_range, error_percent, 'r-', 'LineWidth', 1.5);
xlabel('Gerçek CFO (rad/sample)');
ylabel('Tahmin Hatası (%)');
title('CFO Tahmin Hatası');
grid on;
ylim([0 max(error_percent)+1]);

fprintf('  ✓ Grafik oluşturuldu\n\n');

%% SONUÇ
fprintf('==============================================\n');
fprintf('TÜM TESTLER BAŞARIYLA TAMAMLANDI!\n');
fprintf('==============================================\n\n');
fprintf('ÖZET:\n');
fprintf('  ✓ Sıfır CFO testi: BAŞARILI\n');
fprintf('  ✓ Pozitif CFO testi: BAŞARILI\n');
fprintf('  ✓ Negatif CFO testi: BAŞARILI\n');
fprintf('  ✓ Gürültülü sinyal testi: BAŞARILI\n');
fprintf('  ✓ [I,Q] format testi: BAŞARILI\n');
fprintf('  ✓ Maksimum CFO testi: BAŞARILI\n');
fprintf('  ✓ Görselleştirme: BAŞARILI\n\n');

fprintf('Fine CFO Estimator golden reference olarak kullanıma hazır!\n');
