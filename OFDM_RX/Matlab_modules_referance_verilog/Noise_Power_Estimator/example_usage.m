%% EXAMPLE_USAGE - Noise Power Estimator kullanım örneği
%
% Bu script, noise_power_estimator.m fonksiyonunun nasıl kullanılacağını
% gösterir ve tipik OFDM alıcı senaryosunda entegrasyonu demonstre eder.
%
% YAZAN: MATLAB Referans Model Generator
% TARİH: 31 Ocak 2026
% VERSİYON: 1.0

clear; clc; close all;

fprintf('===============================================\n');
fprintf('NOISE POWER ESTIMATOR - KULLANIM ÖRNEĞİ\n');
fprintf('===============================================\n\n');

%% SENARYO: IEEE 802.11a/g/n OFDM Alıcısı

% Parametreler
N = 64;                 % LTS uzunluğu (64 subcarrier)
SNR_dB = 15;           % Sinyal-Gürültü Oranı (dB)
signal_power = 10000;  % Sinyal gücü (keyfi birim)

fprintf('Senaryo Parametreleri:\n');
fprintf('  - LTS uzunluğu: %d örnek\n', N);
fprintf('  - SNR: %d dB\n', SNR_dB);
fprintf('  - Sinyal gücü: %d\n', signal_power);
fprintf('\n');

%% Adım 1: IEEE 802.11 LTS Referans Sekansı Oluştur

fprintf('Adım 1: LTS Referans Sekansı Oluşturuluyor...\n');

% IEEE 802.11a/g/n Long Training Sequence (frekans domain)
% 802.11-2012, Section 20.3.9.4.3, Table 20-11
lts_freq = [0, 0, 0, 0, 0, 0, ...
            1, 1, -1, -1, 1, 1, -1, 1, -1, 1, ...
            1, 1, 1, 1, 1, -1, -1, 1, 1, -1, 1, -1, 1, 1, 1, 1, ...
            0, ...
            1, -1, -1, 1, 1, -1, 1, -1, 1, -1, -1, -1, -1, -1, ...
            1, 1, -1, -1, 1, -1, 1, -1, 1, 1, 1, 1, 0, 0, 0, 0, 0];

% Sign vektörü (Verilog equalizer.v'de kullanılan)
sign_vec = double(lts_freq == -1)';

fprintf('  ✓ LTS referans sekansı hazır (%d subcarrier)\n', length(lts_freq));
fprintf('  ✓ Negatif subcarrier sayısı: %d\n', sum(sign_vec));
fprintf('\n');

%% Adım 2: İdeal LTS Sinyali Oluştur (Time Domain)

fprintf('Adım 2: İdeal LTS Sinyali Oluşturuluyor...\n');

% Basit IFFT simülasyonu (gerçek implementasyon için IFFT kullanın)
% Burada örnek amaçlı Gaussian sinyaller kullanıyoruz
rng(100); % Reproducibility
lts_ideal_i = randn(N, 1) * sqrt(signal_power/2);
lts_ideal_q = randn(N, 1) * sqrt(signal_power/2);

% Fixed-point formatına dönüştür (Q15)
% Normalize et ve [-32768, 32767] aralığına ölçekle
scale_factor = 32767 / (3 * sqrt(signal_power/2)); % 3-sigma scaling
lts_ideal_i_fp = int16(round(lts_ideal_i * scale_factor));
lts_ideal_q_fp = int16(round(lts_ideal_q * scale_factor));

fprintf('  ✓ İdeal LTS oluşturuldu\n');
fprintf('  ✓ Ölçekleme faktörü: %.4f\n', scale_factor);
fprintf('  ✓ Örnek değerler (I,Q): (%d, %d), (%d, %d), (%d, %d)\n', ...
    lts_ideal_i_fp(1), lts_ideal_q_fp(1), ...
    lts_ideal_i_fp(2), lts_ideal_q_fp(2), ...
    lts_ideal_i_fp(3), lts_ideal_q_fp(3));
fprintf('\n');

%% Adım 3: Gürültü Ekle

fprintf('Adım 3: Gürültü Ekleniyor (SNR = %d dB)...\n', SNR_dB);

% Gürültü gücünü hesapla
noise_power_theoretical = signal_power / (10^(SNR_dB/10));
noise_std = sqrt(noise_power_theoretical / 2);

% İki bağımsız gürültü realization
noise1_i = randn(N, 1) * noise_std;
noise1_q = randn(N, 1) * noise_std;
noise2_i = randn(N, 1) * noise_std;
noise2_q = randn(N, 1) * noise_std;

% Fixed-point formatına dönüştür
noise1_i_fp = int16(round(noise1_i * scale_factor));
noise1_q_fp = int16(round(noise1_q * scale_factor));
noise2_i_fp = int16(round(noise2_i * scale_factor));
noise2_q_fp = int16(round(noise2_q * scale_factor));

% Gürültülü LTS sinyalleri
lts1_i = lts_ideal_i_fp + noise1_i_fp;
lts1_q = lts_ideal_q_fp + noise1_q_fp;
lts2_i = lts_ideal_i_fp + noise2_i_fp;
lts2_q = lts_ideal_q_fp + noise2_q_fp;

fprintf('  ✓ Teorik gürültü gücü: %.2f\n', noise_power_theoretical);
fprintf('  ✓ Gürültü std: %.2f\n', noise_std);
fprintf('  ✓ Gürültü (scaled) örnek: (%d, %d)\n', noise1_i_fp(1), noise1_q_fp(1));
fprintf('\n');

%% Adım 4: Noise Power Estimator Çalıştır

fprintf('Adım 4: Noise Power Estimator Çalıştırılıyor...\n');

clk_enable = 1; % Clock enable

% Fonksiyonu çağır
tic;
[noise_power, np_valid, mean_i, mean_q, m_valid] = ...
    noise_power_estimator(lts1_i, lts1_q, lts2_i, lts2_q, sign_vec, clk_enable);
elapsed = toc;

fprintf('  ✓ İşlem tamamlandı (%.4f saniye)\n', elapsed);
fprintf('  ✓ Geçerli çıkış sayısı: %d/%d\n', sum(np_valid), N);
fprintf('\n');

%% Adım 5: Sonuçları Analiz Et

fprintf('Adım 5: Sonuçlar Analiz Ediliyor...\n');
fprintf('-------------------------------------\n');

% Ortalama gürültü gücü (fixed-point domain)
avg_noise_power_fp = mean(double(noise_power(np_valid)));

% Geri ölçekle (floating-point domain)
avg_noise_power = avg_noise_power_fp / (scale_factor^2);

% SNR tahmini
estimated_snr_dB = 10*log10(signal_power / avg_noise_power);

% Hata hesapla
noise_power_error = abs(avg_noise_power - noise_power_theoretical);
snr_error_dB = abs(estimated_snr_dB - SNR_dB);

fprintf('\nTeorik Değerler:\n');
fprintf('  - Gürültü gücü: %.2f\n', noise_power_theoretical);
fprintf('  - SNR: %.2f dB\n', SNR_dB);

fprintf('\nTahmin Edilen Değerler:\n');
fprintf('  - Gürültü gücü: %.2f\n', avg_noise_power);
fprintf('  - SNR: %.2f dB\n', estimated_snr_dB);

fprintf('\nHata Analizi:\n');
fprintf('  - Gürültü gücü hatası: %.2f (%.1f%%)\n', ...
    noise_power_error, noise_power_error/noise_power_theoretical*100);
fprintf('  - SNR hatası: %.2f dB\n', snr_error_dB);

fprintf('\nOrtalama Sinyal Değerleri:\n');
fprintf('  - Mean I: %.2f\n', mean(double(mean_i(m_valid))));
fprintf('  - Mean Q: %.2f\n', mean(double(mean_q(m_valid))));

fprintf('\n');

%% Adım 6: Görselleştirme

fprintf('Adım 6: Görselleştirme Oluşturuluyor...\n');

figure('Position', [100, 100, 1400, 900]);
sgtitle(sprintf('Noise Power Estimator - SNR = %d dB', SNR_dB), ...
    'FontSize', 14, 'FontWeight', 'bold');

% Subplot 1: Giriş Sinyalleri (I component)
subplot(3,3,1);
plot(1:N, double(lts_ideal_i_fp), 'b-', 'LineWidth', 1.5);
hold on;
plot(1:N, double(lts1_i), 'r--', 'LineWidth', 1);
plot(1:N, double(lts2_i), 'g--', 'LineWidth', 1);
grid on;
xlabel('Örnek Index');
ylabel('Amplitude (int16)');
title('Giriş Sinyalleri (I component)');
legend('İdeal LTS', 'LTS1 (gürültülü)', 'LTS2 (gürültülü)', 'Location', 'best');

% Subplot 2: Giriş Sinyalleri (Q component)
subplot(3,3,2);
plot(1:N, double(lts_ideal_q_fp), 'b-', 'LineWidth', 1.5);
hold on;
plot(1:N, double(lts1_q), 'r--', 'LineWidth', 1);
plot(1:N, double(lts2_q), 'g--', 'LineWidth', 1);
grid on;
xlabel('Örnek Index');
ylabel('Amplitude (int16)');
title('Giriş Sinyalleri (Q component)');
legend('İdeal LTS', 'LTS1 (gürültülü)', 'LTS2 (gürültülü)', 'Location', 'best');

% Subplot 3: Constellation (LTS1 vs LTS2)
subplot(3,3,3);
plot(double(lts1_i), double(lts1_q), 'ro', 'MarkerSize', 4);
hold on;
plot(double(lts2_i), double(lts2_q), 'bx', 'MarkerSize', 4);
grid on;
xlabel('I');
ylabel('Q');
title('Constellation Diagram');
legend('LTS1', 'LTS2', 'Location', 'best');
axis equal;

% Subplot 4: Ortalama Çıkışı (I component)
subplot(3,3,4);
plot(find(m_valid), double(mean_i(m_valid)), 'k-', 'LineWidth', 1.5);
hold on;
plot(1:N, double(lts_ideal_i_fp), 'b--', 'LineWidth', 1);
grid on;
xlabel('Örnek Index');
ylabel('Amplitude (int16)');
title('Mean Output (I) vs İdeal');
legend('Mean (LTS1+LTS2)/2', 'İdeal LTS', 'Location', 'best');

% Subplot 5: Ortalama Çıkışı (Q component)
subplot(3,3,5);
plot(find(m_valid), double(mean_q(m_valid)), 'k-', 'LineWidth', 1.5);
hold on;
plot(1:N, double(lts_ideal_q_fp), 'b--', 'LineWidth', 1);
grid on;
xlabel('Örnek Index');
ylabel('Amplitude (int16)');
title('Mean Output (Q) vs İdeal');
legend('Mean (LTS1+LTS2)/2', 'İdeal LTS', 'Location', 'best');

% Subplot 6: Noise Power Çıkışı
subplot(3,3,6);
stem(find(np_valid), double(noise_power(np_valid)), 'filled');
hold on;
yline(avg_noise_power_fp, 'r--', 'LineWidth', 2);
yline(noise_power_theoretical * scale_factor^2, 'g--', 'LineWidth', 2);
grid on;
xlabel('Örnek Index');
ylabel('Noise Power (uint32)');
title('Noise Power Tahminleri');
legend('Tahmin', 'Ortalama', 'Teorik', 'Location', 'best');

% Subplot 7: Histogram - Noise Power
subplot(3,3,7);
histogram(double(noise_power(np_valid)), 20, 'FaceColor', 'b', 'EdgeColor', 'k');
xline(avg_noise_power_fp, 'r--', 'LineWidth', 2);
xline(noise_power_theoretical * scale_factor^2, 'g--', 'LineWidth', 2);
grid on;
xlabel('Noise Power (uint32)');
ylabel('Frequency');
title('Noise Power Dağılımı');
legend('Histogram', 'Ortalama', 'Teorik', 'Location', 'best');

% Subplot 8: SNR Tahmini
subplot(3,3,8);
snr_per_sample = 10*log10(signal_power ./ (double(noise_power(np_valid))/scale_factor^2));
plot(find(np_valid), snr_per_sample, 'b-', 'LineWidth', 1.5);
hold on;
yline(SNR_dB, 'r--', 'LineWidth', 2);
yline(estimated_snr_dB, 'g--', 'LineWidth', 2);
grid on;
xlabel('Örnek Index');
ylabel('SNR (dB)');
title('SNR Tahmini');
legend('Örnek bazında', 'Gerçek SNR', 'Ortalama SNR', 'Location', 'best');

% Subplot 9: Özet Tablo
subplot(3,3,9);
axis off;
text_str = {
    '\bf{\fontsize{12}SONUÇ ÖZETİ}';
    '';
    sprintf('Teorik SNR: %.2f dB', SNR_dB);
    sprintf('Tahmin SNR: %.2f dB', estimated_snr_dB);
    sprintf('SNR Hatası: %.2f dB', snr_error_dB);
    '';
    sprintf('Teorik NP: %.2f', noise_power_theoretical);
    sprintf('Tahmin NP: %.2f', avg_noise_power);
    sprintf('NP Hatası: %.1f%%', noise_power_error/noise_power_theoretical*100);
    '';
    sprintf('İşlem Süresi: %.4f s', elapsed);
    sprintf('Geçerli Örnek: %d/%d', sum(np_valid), N);
};
text(0.1, 0.9, text_str, 'VerticalAlignment', 'top', 'FontSize', 10);

fprintf('  ✓ Görselleştirme tamamlandı\n');
fprintf('\n');

%% Sonuç

fprintf('===============================================\n');
fprintf('✓ Örnek kullanım başarıyla tamamlandı!\n');
fprintf('===============================================\n\n');

fprintf('Bir sonraki adım:\n');
fprintf('  1. Bu modülü kendi OFDM alıcı zincirinize entegre edin\n');
fprintf('  2. Verilog implementasyon ile karşılaştırın\n');
fprintf('  3. Farklı kanal koşullarında test edin\n\n');
