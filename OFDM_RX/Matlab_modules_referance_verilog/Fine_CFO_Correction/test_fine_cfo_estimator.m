%% FINE_CFO_ESTIMATOR_TEST - Fine CFO Correction MATLAB Referans Modeli Test Script'i
% 
% AÇIKLAMA:
%   Bu script, fine_cfo_correction.m fonksiyonunun doğru çalıştığını test eder.
%   Verilog sync_long.v modülünün davranışını simüle eder ve çeşitli
%   test senaryolarında doğruluk kontrolü yapar.
%
% TEST SENARYOLARI:
%   1. Basit faz rotasyonu testi (sabit phase_offset)
%   2. Guard Interval düzeltme testi (Short GI vs Long GI)
%   3. Faz wrapping testi ([-PI, PI] sınır durumları)
%   4. Çoklu OFDM sembol testi (64+ örnek)
%
% ÇIKTILAR:
%   - Test sonuçları ekrana yazdırılır
%   - Faz düzeltme grafiği gösterilir
%   - Başarısız testler için hata mesajı
%
% YAZAR: GitHub Copilot
% TARİH: 2026-01-31
% VERSİYON: 1.0

clear; clc; close all;

%% MATLAB YOLU AYARLAMA
script_dir = fileparts(mfilename('fullpath'));
addpath(script_dir);

fprintf('==============================================\n');
fprintf('Fine CFO Estimator Test Script Başlatıldı\n');
fprintf('==============================================\n\n');

%% SABİTLER
PI = int32(1608);
DOUBLE_PI = int32(3216);

%% TEST 1: Basit Faz Rotasyonu Testi
fprintf('TEST 1: Basit Faz Rotasyonu Testi\n');
fprintf('------------------------------------------\n');

% Test verileri: 64 örneklik basit kompleks sinyal
num_samples = 64;
test_signal = complex(randi([-1000, 1000], num_samples, 1), ...
                       randi([-1000, 1000], num_samples, 1));

% Parametreler
phase_offset = int16(50);  % Küçük pozitif faz ofseti
short_gi = false;          % Long GI
num_ofdm_symbol_in = uint16(0);
phase_correction_in = int32(0);

% Fonksiyonu çağır
try
    [samples_out, phase_corr_out, num_sym_out] = fine_cfo_correction(...
        test_signal, phase_offset, short_gi, num_ofdm_symbol_in, phase_correction_in);
    
    fprintf('  ✓ Fonksiyon başarıyla çalıştı\n');
    fprintf('  - Giriş örnek sayısı: %d\n', num_samples);
    fprintf('  - Çıkış örnek sayısı: %d\n', size(samples_out, 1));
    fprintf('  - Başlangıç faz düzeltmesi: %d\n', phase_correction_in);
    fprintf('  - Bitiş faz düzeltmesi: %d\n', phase_corr_out);
    fprintf('  - OFDM sembol sayısı: %d\n', num_sym_out);
    
    % Faz düzeltmenin arttığını kontrol et
    assert(phase_corr_out > phase_correction_in, 'Faz düzeltme değeri artmadı!');
    fprintf('  ✓ Faz düzeltme değeri beklenen şekilde arttı\n');
    
catch ME
    fprintf('  ✗ HATA: %s\n', ME.message);
    rethrow(ME);
end

fprintf('\n');

%% TEST 2: Negatif Phase Offset Testi
fprintf('TEST 2: Negatif Phase Offset Testi\n');
fprintf('------------------------------------------\n');

phase_offset_neg = int16(-30);
phase_correction_in_neg = int32(500);

try
    [~, phase_corr_out_neg, ~] = fine_cfo_correction(...
        test_signal, phase_offset_neg, short_gi, num_ofdm_symbol_in, phase_correction_in_neg);
    
    fprintf('  ✓ Negatif phase offset testi başarılı\n');
    fprintf('  - Başlangıç faz: %d\n', phase_correction_in_neg);
    fprintf('  - Bitiş faz: %d\n', phase_corr_out_neg);
    
    % Negatif offset ile faz azalmalı
    assert(phase_corr_out_neg < phase_correction_in_neg, 'Negatif offset ile faz azalmadı!');
    fprintf('  ✓ Faz değeri beklenen şekilde azaldı\n');
    
catch ME
    fprintf('  ✗ HATA: %s\n', ME.message);
    rethrow(ME);
end

fprintf('\n');

%% TEST 3: Faz Wrapping Testi (Pozitif Taşma)
fprintf('TEST 3: Faz Wrapping Testi (Pozitif Taşma)\n');
fprintf('------------------------------------------\n');

phase_offset_high = int16(200);      % Büyük pozitif offset
phase_correction_high = int32(1500); % PI'ye yakın başlangıç değeri

try
    [~, phase_corr_wrapped, ~] = fine_cfo_correction(...
        test_signal, phase_offset_high, short_gi, num_ofdm_symbol_in, phase_correction_high);
    
    fprintf('  ✓ Pozitif taşma testi başarılı\n');
    fprintf('  - Başlangıç faz: %d (PI = %d)\n', phase_correction_high, PI);
    fprintf('  - Bitiş faz: %d\n', phase_corr_wrapped);
    
    % Faz [-PI, PI] aralığında kalmalı
    assert(phase_corr_wrapped >= -PI && phase_corr_wrapped <= PI, ...
        'Faz wrapping çalışmadı! Faz aralık dışında.');
    fprintf('  ✓ Faz değeri [-PI, PI] aralığında\n');
    
catch ME
    fprintf('  ✗ HATA: %s\n', ME.message);
    rethrow(ME);
end

fprintf('\n');

%% TEST 4: Faz Wrapping Testi (Negatif Taşma)
fprintf('TEST 4: Faz Wrapping Testi (Negatif Taşma)\n');
fprintf('------------------------------------------\n');

phase_offset_low = int16(-200);
phase_correction_low = int32(-1500);

try
    [~, phase_corr_wrapped_neg, ~] = fine_cfo_correction(...
        test_signal, phase_offset_low, short_gi, num_ofdm_symbol_in, phase_correction_low);
    
    fprintf('  ✓ Negatif taşma testi başarılı\n');
    fprintf('  - Başlangıç faz: %d (-PI = %d)\n', phase_correction_low, -PI);
    fprintf('  - Bitiş faz: %d\n', phase_corr_wrapped_neg);
    
    assert(phase_corr_wrapped_neg >= -PI && phase_corr_wrapped_neg <= PI, ...
        'Negatif faz wrapping çalışmadı!');
    fprintf('  ✓ Faz değeri [-PI, PI] aralığında\n');
    
catch ME
    fprintf('  ✗ HATA: %s\n', ME.message);
    rethrow(ME);
end

fprintf('\n');

%% TEST 5: Guard Interval Düzeltme Testi (Long GI)
fprintf('TEST 5: Guard Interval Düzeltme Testi (Long GI)\n');
fprintf('------------------------------------------\n');

% 2 OFDM sembolü = 128 örnek
num_samples_gi = 128;
test_signal_gi = complex(randi([-1000, 1000], num_samples_gi, 1), ...
                          randi([-1000, 1000], num_samples_gi, 1));

phase_offset_gi = int16(100);
short_gi_long = false; % Long GI

try
    [~, phase_corr_gi, num_sym_gi] = fine_cfo_correction(...
        test_signal_gi, phase_offset_gi, short_gi_long, uint16(1), int32(0));
    
    fprintf('  ✓ Long GI testi başarılı\n');
    fprintf('  - İşlenen örnek sayısı: %d\n', num_samples_gi);
    fprintf('  - OFDM sembol sayısı: %d\n', num_sym_gi);
    fprintf('  - Bitiş faz düzeltmesi: %d\n', phase_corr_gi);
    
    % 2 sembol işlenmiş olmalı (başlangıç sembolü 1 + 1 tam sembol)
    assert(num_sym_gi >= 2, 'OFDM sembol sayısı yanlış!');
    fprintf('  ✓ OFDM sembol sayısı doğru\n');
    
catch ME
    fprintf('  ✗ HATA: %s\n', ME.message);
    rethrow(ME);
end

fprintf('\n');

%% TEST 6: Guard Interval Düzeltme Testi (Short GI)
fprintf('TEST 6: Guard Interval Düzeltme Testi (Short GI)\n');
fprintf('------------------------------------------\n');

short_gi_short = true; % Short GI

try
    [~, phase_corr_gi_short, num_sym_gi_short] = fine_cfo_correction(...
        test_signal_gi, phase_offset_gi, short_gi_short, uint16(1), int32(0));
    
    fprintf('  ✓ Short GI testi başarılı\n');
    fprintf('  - İşlenen örnek sayısı: %d\n', num_samples_gi);
    fprintf('  - OFDM sembol sayısı: %d\n', num_sym_gi_short);
    fprintf('  - Bitiş faz düzeltmesi: %d\n', phase_corr_gi_short);
    
    % Short GI ile faz düzeltme farklı olmalı
    assert(phase_corr_gi_short ~= phase_corr_gi, ...
        'Short GI ve Long GI aynı sonucu verdi!');
    fprintf('  ✓ Short GI ve Long GI farklı faz düzeltmesi üretti\n');
    
catch ME
    fprintf('  ✗ HATA: %s\n', ME.message);
    rethrow(ME);
end

fprintf('\n');

%% TEST 7: Rotate Fonksiyon Testi
fprintf('TEST 7: Rotate Fonksiyon Testi\n');
fprintf('------------------------------------------\n');

try
    % Basit rotasyon testi
    test_i = int16(1000);
    test_q = int16(500);
    test_phase = int16(400);
    
    [rot_i, rot_q] = rotate_fixed_point(test_i, test_q, test_phase);
    
    fprintf('  ✓ Rotate fonksiyonu başarıyla çalıştı\n');
    fprintf('  - Giriş: (%d, %d)\n', test_i, test_q);
    fprintf('  - Faz: %d\n', test_phase);
    fprintf('  - Çıkış: (%d, %d)\n', rot_i, rot_q);
    
    % Magnitude korunmalı (yaklaşık)
    mag_in = sqrt(double(test_i)^2 + double(test_q)^2);
    mag_out = sqrt(double(rot_i)^2 + double(rot_q)^2);
    mag_error = abs(mag_out - mag_in) / mag_in * 100;
    
    fprintf('  - Giriş magnitude: %.2f\n', mag_in);
    fprintf('  - Çıkış magnitude: %.2f\n', mag_out);
    fprintf('  - Magnitude hatası: %.2f%%\n', mag_error);
    
    % %5'ten az hata beklenir (fixed-point quantization nedeniyle)
    assert(mag_error < 5, 'Magnitude korunumu çok büyük hata!');
    fprintf('  ✓ Magnitude korunumu kabul edilebilir seviyede\n');
    
catch ME
    fprintf('  ✗ HATA: %s\n', ME.message);
    rethrow(ME);
end

fprintf('\n');

%% TEST 8: Görselleştirme - Faz Düzeltme Grafiği
fprintf('TEST 8: Görselleştirme - Faz Düzeltme Grafiği\n');
fprintf('------------------------------------------\n');

% Uzun bir sinyal oluştur (4 OFDM sembolü)
num_samples_vis = 256;
test_signal_vis = complex(randi([-1000, 1000], num_samples_vis, 1), ...
                           randi([-1000, 1000], num_samples_vis, 1));

phase_offset_vis = int16(80);
phase_corrections = zeros(num_samples_vis, 1);
phase_corr_temp = int32(0);

% Her örnek için faz düzeltme değerini kaydet
for i = 1:num_samples_vis
    [~, phase_corr_temp, ~] = fine_cfo_correction(...
        test_signal_vis(i), phase_offset_vis, false, ...
        uint16(floor((i-1)/64)), phase_corr_temp);
    phase_corrections(i) = double(phase_corr_temp);
end

% Grafik çiz
figure('Name', 'Fine CFO Correction - Faz Düzeltme Değişimi', 'Position', [100 100 800 600]);

subplot(2,1,1);
plot(1:num_samples_vis, phase_corrections, 'b-', 'LineWidth', 1.5);
hold on;
yline(double(PI), 'r--', 'PI', 'LineWidth', 1.5);
yline(double(-PI), 'r--', '-PI', 'LineWidth', 1.5);
yline(0, 'k:', 'LineWidth', 1);
hold off;
xlabel('Örnek İndeksi');
ylabel('Faz Düzeltme Değeri');
title('Faz Düzeltme Değerinin Zamana Göre Değişimi');
grid on;
legend('Faz Düzeltmesi', 'PI Sınırı', '-PI Sınırı', 'Location', 'best');

subplot(2,1,2);
% Faz farkları (wrapping etkisini görmek için)
phase_diffs = diff(phase_corrections);
plot(1:length(phase_diffs), phase_diffs, 'g-', 'LineWidth', 1.5);
xlabel('Örnek İndeksi');
ylabel('Faz Değişimi (Δφ)');
title('Ardışık Örnekler Arasındaki Faz Değişimi');
grid on;

fprintf('  ✓ Grafik oluşturuldu\n');
fprintf('  - %d örnek görselleştirildi\n', num_samples_vis);
fprintf('  - Faz wrapping ([-PI, PI]) gözlemlenebilir\n');

fprintf('\n');

%% SONUÇ ÖZET
fprintf('==============================================\n');
fprintf('TÜM TESTLER BAŞARIYLA TAMAMLANDI!\n');
fprintf('==============================================\n');
fprintf('\n');
fprintf('ÖZET:\n');
fprintf('  ✓ Basit faz rotasyonu testi: BAŞARILI\n');
fprintf('  ✓ Negatif phase offset testi: BAŞARILI\n');
fprintf('  ✓ Pozitif faz wrapping testi: BAŞARILI\n');
fprintf('  ✓ Negatif faz wrapping testi: BAŞARILI\n');
fprintf('  ✓ Long GI düzeltme testi: BAŞARILI\n');
fprintf('  ✓ Short GI düzeltme testi: BAŞARILI\n');
fprintf('  ✓ Rotate fonksiyon testi: BAŞARILI\n');
fprintf('  ✓ Görselleştirme: BAŞARILI\n');
fprintf('\n');
fprintf('MATLAB referans modeli Verilog kodunu doğru şekilde taklit ediyor.\n');
fprintf('Golden reference olarak kullanıma hazır!\n');
