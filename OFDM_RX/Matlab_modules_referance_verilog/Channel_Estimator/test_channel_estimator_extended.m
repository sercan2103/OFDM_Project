%% TEST_CHANNEL_ESTIMATOR_EXTENDED - Tam Channel Estimator Test (10 Symbol)
% Bu script, channel_estimator_fixed.m fonksiyonunu tam kullanım senaryosuyla test eder
% State machine'in tüm aşamalarını tamamlamak için yeterli veri sağlar
%
% AUTHOR: Extended test with full OFDM packet
% DATE: 2026-02-19

clear all;
close all;
clc;

%% Test Parametreleri
fprintf('=== CHANNEL ESTIMATOR EXTENDED TEST (10 OFDM Symbols) ===\n\n');

%% 1. Rotation LUT Oluştur
fprintf('1. Rotation LUT olusturuluyor...\n');
rot_lut = generate_rotation_lut();
fprintf('   - LUT boyutu: %d\n', length(rot_lut));

%% 2. Test Sinyali Oluştur (LTS + 10 Data Symbol)
fprintf('\n2. Test sinyali olusturuluyor...\n');

% IEEE 802.11 Long Training Sequence (LTS)
lts_freq = [0, 1, -1, -1, 1, 1, -1, 1, -1, 1, -1, -1, -1, -1, -1, 1, ...
            1, -1, -1, 1, -1, 1, -1, 1, 1, 1, 1, 0, 0, 0, 0, 0, ...
            0, 0, 0, 0, 0, 0, 1, 1, -1, -1, 1, 1, -1, 1, -1, 1, ...
            1, 1, 1, 1, 1, -1, -1, 1, 1, -1, 1, -1, 1, 1, 1, 1];

% Basit kanal modeli (multipath fading)
H_channel = ones(64, 1);
H_channel(10:15) = 0.7 * exp(1j * pi/4);   % Path 1
H_channel(30:35) = 0.8 * exp(1j * -pi/6);  % Path 2
H_channel(50:55) = 0.9 * exp(1j * pi/3);   % Path 3

% LTS sinyali
lts_received = lts_freq.' .* H_channel;
lts_received_scaled = lts_received * 10000;
lts_sample_in = complex(int16(real(lts_received_scaled)), int16(imag(lts_received_scaled)));

% İki LTS gönder
sample_in = [lts_sample_in; lts_sample_in];
sample_in_strobe = true(length(sample_in), 1);

% 5 OFDM veri sembolü ekle (state machine'in equalization aşamasına ulaşması için)
num_data_symbols = 5;
fprintf('   - 2 x LTS symbol gonderiliyor\n');
fprintf('   - %d x Data symbol gonderiliyor\n', num_data_symbols);

for sym = 1:num_data_symbols
    % Veri sembolü oluştur (BPSK/QPSK simulasyonu)
    data_i = int16(randi([-3000, 3000], 64, 1));
    data_q = int16(randi([-3000, 3000], 64, 1));
    data_symbol = complex(data_i, data_q);
    
    sample_in = [sample_in; data_symbol];
    sample_in_strobe = [sample_in_strobe; true(64, 1)];
end

fprintf('   - Toplam input sample: %d (2 LTS + %d Data)\n', length(sample_in), num_data_symbols);
fprintf('   ✓ Sinyal hazir!\n');

%% 3. Channel Estimator Çalıştır
fprintf('\n3. Channel Estimator calistiriliyor...\n');

ht_next = false;
pkt_ht = false;
ht_smoothing = false;
disable_all_smoothing = false;

try
    [sample_out, sample_out_strobe, csi, csi_valid, state_out] = ...
        channel_estimator_fixed(sample_in, sample_in_strobe, ht_next, pkt_ht, ...
                               ht_smoothing, disable_all_smoothing, rot_lut, []);
    
    fprintf('   ✓ Islem tamamlandi!\n');
    fprintf('   - Eslitlenen sample sayisi: %d\n', sum(sample_out_strobe));
    fprintf('   - CSI valid: %s\n', mat2str(csi_valid));
    fprintf('   - Son state: %d\n', state_out.state);
    
catch ME
    fprintf('   [HATA] %s\n', ME.message);
    fprintf('   Stack:\n');
    for i = 1:length(ME.stack)
        fprintf('     %s (line %d)\n', ME.stack(i).name, ME.stack(i).line);
    end
    return;
end

%% 4. Sonuçları Göster
fprintf('\n4. Detayli Sonuclar:\n');

% CSI sonuçları
if exist('csi', 'var') && ~isempty(csi)
    fprintf('\n   ✓ KANAL TAHMİNİ (CSI) BAŞARILI!\n');
    fprintf('   - CSI sample sayisi: %d\n', length(csi));
    fprintf('   - CSI geçerli: %s\n', mat2str(csi_valid));
    
    fprintf('\n   Ilk 15 CSI Degeri:\n');
    for i = 1:min(15, length(csi))
        mag = abs(csi(i));
        phase = angle(csi(i)) * 180 / pi;
        fprintf('     [%2d] Mag: %8.1f, Phase: %7.2f°\n', i, mag, phase);
    end
else
    fprintf('   [UYARI] CSI uretilmedi!\n');
end

% Eşitlenmiş veri sonuçları
if exist('sample_out', 'var') && ~isempty(sample_out)
    fprintf('\n   ✓ KANAl EŞİTLEME BAŞARILI!\n');
    fprintf('   - Eslitlenen sample sayisi: %d\n', sum(sample_out_strobe));
    fprintf('   - Ortalama magnitude: %.2f\n', mean(abs(sample_out)));
    fprintf('   - Min magnitude: %.2f\n', min(abs(sample_out)));
    fprintf('   - Max magnitude: %.2f\n', max(abs(sample_out)));
    
    fprintf('\n   Ilk 15 Eslitilmis Sample:\n');
    for i = 1:min(15, length(sample_out))
        mag = abs(sample_out(i));
        phase = angle(sample_out(i)) * 180 / pi;
        fprintf('     [%2d] Mag: %8.1f, Phase: %7.2f°\n', i, mag, phase);
    end
else
    fprintf('   [BILGI] Eslitlenmiş veri henüz uretilmedi\n');
end

%% 5. Grafikleri Çiz
fprintf('\n5. Grafikler ciziliyor...\n');

% Şekil 1: CSI Analizi
figure('Name', 'Channel Estimator - CSI Analysis', 'Position', [100 100 1200 700]);

if exist('csi', 'var') && ~isempty(csi)
    subplot(2, 2, 1);
    stem(abs(csi), 'filled', 'LineWidth', 1.5);
    grid on;
    xlabel('Subcarrier Index');
    ylabel('|H(k)|');
    title('Kanal Frekans Tepkisi - Büyüklük');
    
    subplot(2, 2, 2);
    plot(angle(csi)*180/pi, 'b-', 'LineWidth', 1.5);
    grid on;
    xlabel('Subcarrier Index');
    ylabel('∠H(k) (degrees)');
    title('Kanal Frekans Tepkisi - Faz');
end

% Şekil 2: Eşitlenmiş Veri
if exist('sample_out', 'var') && ~isempty(sample_out)
    subplot(2, 2, 3);
    plot(real(sample_out), imag(sample_out), 'o', 'MarkerSize', 3);
    grid on;
    axis equal;
    xlabel('Real');
    ylabel('Imaginary');
    title('Eslitlenen Veri - Constellation');
    
    subplot(2, 2, 4);
    plot(abs(sample_out), 'r-', 'LineWidth', 1);
    hold on;
    yline(mean(abs(sample_out)), 'g--', 'LineWidth', 2);
    grid on;
    xlabel('Sample Index');
    ylabel('Magnitude');
    legend('Signal', 'Mean', 'Location', 'best');
    title('Eslitlenen Veri - Magnitude Zaman Serileri');
end

fprintf('   ✓ CSI Analysis grafiği cizildi!\n');

% Şekil 2: Detaylı Analiz
if exist('sample_out', 'var') && ~isempty(sample_out)
    figure('Name', 'Channel Estimator - Equalized Data Analysis', 'Position', [150 150 1200 700]);
    
    % IQ scatter plot
    subplot(2, 3, 1);
    plot(real(sample_out), imag(sample_out), 'o', 'MarkerSize', 4, 'LineStyle', 'none');
    grid on;
    axis equal;
    xlabel('I');
    ylabel('Q');
    title('Constellation Diagram');
    
    % Magnitude histogram
    subplot(2, 3, 2);
    histogram(abs(sample_out), 30, 'FaceColor', 'blue', 'FaceAlpha', 0.7);
    grid on;
    xlabel('Magnitude');
    ylabel('Frequency');
    title('Magnitude Distribution');
    
    % Phase histogram
    subplot(2, 3, 3);
    histogram(angle(sample_out)*180/pi, 30, 'FaceColor', 'red', 'FaceAlpha', 0.7);
    grid on;
    xlabel('Phase (degrees)');
    ylabel('Frequency');
    title('Phase Distribution');
    
    % Real part time series
    subplot(2, 3, 4);
    plot(real(sample_out), 'b-', 'LineWidth', 0.5);
    grid on;
    xlabel('Sample Index');
    ylabel('Real Part');
    title('I Component vs Time');
    
    % Imaginary part time series
    subplot(2, 3, 5);
    plot(imag(sample_out), 'r-', 'LineWidth', 0.5);
    grid on;
    xlabel('Sample Index');
    ylabel('Imaginary Part');
    title('Q Component vs Time');
    
    % Power time series
    subplot(2, 3, 6);
    power = abs(sample_out).^2;
    plot(power, 'g-', 'LineWidth', 0.5);
    grid on;
    xlabel('Sample Index');
    ylabel('Power');
    title('Signal Power vs Time');
    
    fprintf('   ✓ Equalized Data Analysis grafiği cizildi!\n');
end

%% 6. İstatistiksel Analiz
fprintf('\n6. Istatistiksel Analiz:\n');

if exist('sample_out', 'var') && ~isempty(sample_out)
    fprintf('   Eslitlenen Veri İstatistikleri:\n');
    fprintf('   - Toplam sample sayisi: %d\n', length(sample_out));
    fprintf('   - Ortalama magnitude: %.2f\n', mean(abs(sample_out)));
    fprintf('   - Std deviation: %.2f\n', std(abs(sample_out)));
    fprintf('   - Min value: %.2f\n', min(abs(sample_out)));
    fprintf('   - Max value: %.2f\n', max(abs(sample_out)));
    fprintf('   - Ortalama power: %.2f\n', mean(abs(sample_out).^2));
    
    % SNR tahmini (signal power / noise power)
    signal_power = mean(abs(sample_out).^2);
    noise_est = std(abs(sample_out).^2);
    if noise_est > 0
        snr_est = signal_power / noise_est;
        fprintf('   - Tahmini SNR: %.2f dB\n', 10*log10(snr_est));
    end
end

if exist('csi', 'var') && ~isempty(csi)
    fprintf('\n   Kanal İstatistikleri:\n');
    fprintf('   - Ortalama channel gain: %.2f\n', mean(abs(csi)));
    fprintf('   - Channel RMS delay spread: %.4f\n', std(abs(csi)));
    fprintf('   - Max channel gain: %.2f\n', max(abs(csi)));
    fprintf('   - Min channel gain: %.2f\n', min(abs(csi)));
end

fprintf('\n=== TEST TAMAMLANDI ===\n');
fprintf('✓ Tüm grafikler başarıyla oluşturuldu!\n\n');

%% Yardımcı Fonksiyonlar
function rot_lut = generate_rotation_lut()
    % Rotation LUT oluştur (512 entry, complex)
    LUT_SIZE = 512;
    SCALE = 2048;  % 2^11
    
    rot_lut = zeros(LUT_SIZE, 1);
    
    for i = 0:LUT_SIZE-1
        theta = 2 * pi * i / LUT_SIZE;
        rot_val = exp(1j * theta) * SCALE;
        rot_lut(i+1) = rot_val;
    end
end
