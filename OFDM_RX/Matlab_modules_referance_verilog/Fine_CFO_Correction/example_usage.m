%% EXAMPLE_USAGE - Fine CFO Estimator Örnek Kullanım Script'i
%
% Bu script, fine_cfo_correction fonksiyonunun nasıl kullanılacağını
% gösterir ve gerçekçi bir OFDM sinyali üzerinde CFO düzeltmesi yapar.
%
% YAZAR: GitHub Copilot
% TARİH: 2026-01-31

clear; clc; close all;

fprintf('==============================================\n');
fprintf('Fine CFO Estimator - Örnek Kullanım\n');
fprintf('==============================================\n\n');

%% MATLAB YOLU AYARLAMA
script_dir = fileparts(mfilename('fullpath'));
addpath(script_dir);

%% SABİTLER
SAMPLE_RATE = 20e6;        % 20 MHz (WiFi)
FFT_SIZE = 64;             % OFDM FFT boyutu
NUM_OFDM_SYMBOLS = 4;      % İşlenecek sembol sayısı
CFO_HZ = 5000;             % Simüle edilecek CFO (5 kHz)

fprintf('Simülasyon Parametreleri:\n');
fprintf('  - Örnekleme hızı: %.1f MHz\n', SAMPLE_RATE/1e6);
fprintf('  - FFT boyutu: %d\n', FFT_SIZE);
fprintf('  - OFDM sembol sayısı: %d\n', NUM_OFDM_SYMBOLS);
fprintf('  - Simüle edilen CFO: %.1f kHz\n', CFO_HZ/1e3);
fprintf('\n');

%% SINYAL OLUŞTURMA
% Gerçekçi bir OFDM sinyali oluştur
num_samples = FFT_SIZE * NUM_OFDM_SYMBOLS;
t = (0:num_samples-1)' / SAMPLE_RATE;

% QPSK modülasyonlu rastgele veri
qpsk_symbols = (2*randi([0,1], num_samples, 1) - 1) + ...
               1i*(2*randi([0,1], num_samples, 1) - 1);

% CFO ekle (frekans kayması simülasyonu)
cfo_phase = 2*pi*CFO_HZ*t;
signal_with_cfo = qpsk_symbols .* exp(1i*cfo_phase);

% Fixed-point'e dönüştür (16-bit signed)
signal_fixed = complex(int16(real(signal_with_cfo)*1000), ...
                        int16(imag(signal_with_cfo)*1000));

fprintf('Sinyal Oluşturuldu:\n');
fprintf('  - Toplam örnek sayısı: %d\n', num_samples);
fprintf('  - Örnek formatı: 16-bit signed I/Q\n');
fprintf('  - Sinyal gücü: %.2f dB\n', 10*log10(mean(abs(signal_fixed(:)).^2)));
fprintf('\n');

%% PHASE OFFSET HESAPLAMA
% Gerçek bir sistemde bu değer sync_short modülünden gelir
% Burada CFO'dan tahmin ediyoruz
PI_SCALE = 1608;  % PI değeri (ATAN_LUT_SCALE_SHIFT = 9)
phase_offset_per_sample = 2*pi*CFO_HZ/SAMPLE_RATE;
phase_offset_scaled = round(phase_offset_per_sample * (PI_SCALE/pi));
phase_offset = int16(phase_offset_scaled);

fprintf('Phase Offset Parametreleri:\n');
fprintf('  - Gerçek CFO: %.1f kHz\n', CFO_HZ/1e3);
fprintf('  - Phase offset (radyan/örnek): %.6f\n', phase_offset_per_sample);
fprintf('  - Phase offset (ölçeklenmiş): %d\n', phase_offset);
fprintf('\n');

%% FINE CFO DÜZELTMESİ UYGULA
fprintf('Fine CFO Düzeltmesi Uygulanıyor...\n');

% Parametreler
short_gi = false;               % Long GI kullan
num_ofdm_symbol_in = uint16(0);
phase_correction_in = int32(0);

% Düzeltmeyi uygula
tic;
[signal_corrected, phase_correction_out, num_ofdm_symbol_out] = ...
    fine_cfo_correction(signal_fixed, phase_offset, short_gi, ...
                        num_ofdm_symbol_in, phase_correction_in);
elapsed_time = toc;

fprintf('  ✓ Düzeltme tamamlandı\n');
fprintf('  - İşlem süresi: %.3f ms\n', elapsed_time*1000);
fprintf('  - İşlenen sembol sayısı: %d\n', num_ofdm_symbol_out);
fprintf('  - Final faz düzeltmesi: %d\n', phase_correction_out);
fprintf('\n');

%% SONUÇLARI ANALİZ ET
% Orijinal ve düzeltilmiş sinyalleri karşılaştır
signal_corrected_complex = complex(double(signal_corrected(:,1)), ...
                                    double(signal_corrected(:,2)));

% Faz hatası (CFO etkisi)
phase_error_before = angle(signal_with_cfo .* conj(qpsk_symbols));
phase_error_after = angle(signal_corrected_complex .* conj(qpsk_symbols*1000));

fprintf('Performans Analizi:\n');
fprintf('  - Ortalama faz hatası (düzeltme öncesi): %.2f derece\n', ...
        rad2deg(mean(abs(phase_error_before))));
fprintf('  - Ortalama faz hatası (düzeltme sonrası): %.2f derece\n', ...
        rad2deg(mean(abs(phase_error_after))));
fprintf('  - İyileştirme oranı: %.1fx\n', ...
        mean(abs(phase_error_before))/mean(abs(phase_error_after)));
fprintf('\n');

%% GÖRSELLEŞTİRME
figure('Name', 'Fine CFO Correction Results', 'Position', [100 100 1200 800]);

% Subplot 1: Zaman domeni karşılaştırma (ilk 100 örnek)
subplot(3,2,1);
plot_samples = 100;
plot(1:plot_samples, real(signal_with_cfo(1:plot_samples)), 'r-', ...
     1:plot_samples, real(signal_corrected_complex(1:plot_samples))/1000, 'b-');
xlabel('Örnek İndeksi');
ylabel('Gerçel Değer');
title('Zaman Domeni: I Bileşeni');
legend('CFO ile', 'Düzeltilmiş', 'Location', 'best');
grid on;

subplot(3,2,2);
plot(1:plot_samples, imag(signal_with_cfo(1:plot_samples)), 'r-', ...
     1:plot_samples, imag(signal_corrected_complex(1:plot_samples))/1000, 'b-');
xlabel('Örnek İndeksi');
ylabel('Sanal Değer');
title('Zaman Domeni: Q Bileşeni');
legend('CFO ile', 'Düzeltilmiş', 'Location', 'best');
grid on;

% Subplot 2: Faz hatası karşılaştırma
subplot(3,2,3);
plot(1:num_samples, rad2deg(unwrap(phase_error_before)), 'r-', 'LineWidth', 1.5);
hold on;
plot(1:num_samples, rad2deg(unwrap(phase_error_after)), 'b-', 'LineWidth', 1.5);
hold off;
xlabel('Örnek İndeksi');
ylabel('Faz Hatası (derece)');
title('Faz Hatası Karşılaştırması');
legend('Düzeltme Öncesi', 'Düzeltme Sonrası', 'Location', 'best');
grid on;

% Subplot 3: Konstelasyon diyagramı (düzeltme öncesi)
subplot(3,2,4);
scatter(real(signal_with_cfo), imag(signal_with_cfo), 10, 'r', 'filled', 'MarkerFaceAlpha', 0.3);
xlabel('I');
ylabel('Q');
title('Konstelasyon (CFO ile)');
grid on;
axis equal;
xlim([-2 2]);
ylim([-2 2]);

% Subplot 4: Konstelasyon diyagramı (düzeltme sonrası)
subplot(3,2,5);
scatter(real(signal_corrected_complex)/1000, imag(signal_corrected_complex)/1000, ...
        10, 'b', 'filled', 'MarkerFaceAlpha', 0.3);
xlabel('I');
ylabel('Q');
title('Konstelasyon (Düzeltilmiş)');
grid on;
axis equal;
xlim([-2 2]);
ylim([-2 2]);

% Subplot 5: Faz hatası histogramı
subplot(3,2,6);
histogram(rad2deg(phase_error_before), 50, 'FaceColor', 'r', 'FaceAlpha', 0.5, ...
          'EdgeColor', 'none');
hold on;
histogram(rad2deg(phase_error_after), 50, 'FaceColor', 'b', 'FaceAlpha', 0.5, ...
          'EdgeColor', 'none');
hold off;
xlabel('Faz Hatası (derece)');
ylabel('Örnekler');
title('Faz Hatası Dağılımı');
legend('Düzeltme Öncesi', 'Düzeltme Sonrası', 'Location', 'best');
grid on;

fprintf('✓ Grafik oluşturuldu\n');
fprintf('\n');

%% BİTİŞ
fprintf('==============================================\n');
fprintf('Örnek Kullanım Tamamlandı!\n');
fprintf('==============================================\n');
fprintf('\n');
fprintf('NOT: Bu örnek, fine_cfo_correction fonksiyonunun temel\n');
fprintf('     kullanımını göstermektedir. Gerçek bir OFDM alıcısında,\n');
fprintf('     bu fonksiyon sync_short ve sync_long modülleri ile\n');
fprintf('     birlikte çalışır.\n');
