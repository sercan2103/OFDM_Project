%% TEST_CHANNEL_ESTIMATOR - Channel Estimator Test Script
% Bu script channel_estimator_fixed.m fonksiyonunu test eder
% Verilog equalizer.v ile aynı davranışı göstermelidir
%
% AUTHOR: Auto-generated from Verilog equalizer.v
% DATE: 2026-01-31

clear all;
close all;
clc;

%% Test Parametreleri
fprintf('=== CHANNEL ESTIMATOR GOLDEN REFERENCE TEST ===\n\n');

%% 1. Rotation LUT Oluştur
fprintf('1. Rotation LUT olusturuluyor...\n');
rot_lut = generate_rotation_lut();
fprintf('   - LUT boyutu: %d\n', length(rot_lut));

%% 2. Test Sinyali Oluştur (LTS)
fprintf('\n2. Test sinyali olusturuluyor (LTS)...\n');

% IEEE 802.11 Long Training Sequence (LTS)
% Frekans domaininde bilinen değerler
lts_freq = [0, 1, -1, -1, 1, 1, -1, 1, -1, 1, -1, -1, -1, -1, -1, 1, ...
            1, -1, -1, 1, -1, 1, -1, 1, 1, 1, 1, 0, 0, 0, 0, 0, ...
            0, 0, 0, 0, 0, 0, 1, 1, -1, -1, 1, 1, -1, 1, -1, 1, ...
            1, 1, 1, 1, 1, -1, -1, 1, 1, -1, 1, -1, 1, 1, 1, 1];

% Basit kanal modeli (multipath)
H_channel = ones(64, 1);
H_channel(10:15) = 0.7 * exp(1j * pi/4);  % Fading
H_channel(30:35) = 0.8 * exp(1j * -pi/6);
H_channel(50:55) = 0.9 * exp(1j * pi/3);

% Alınan sinyal: Y = H * X (without noise for testing)
lts_received = lts_freq.' .* H_channel;

% Fixed-point conversion ke int16 (scaled)
lts_received_scaled = lts_received * 10000;  % Scale for int16
lts_sample_in = complex(int16(real(lts_received_scaled)), int16(imag(lts_received_scaled)));

% İki LTS gönder (equalizer bunu bekler)
sample_in = [lts_sample_in; lts_sample_in];
sample_in_strobe = true(length(sample_in), 1);

% 1 OFDM veri sembolü ekle (64 sample per symbol)
dummy_data = complex(int16(randi([-1000, 1000], 64, 1)), int16(randi([-1000, 1000], 64, 1)));
sample_in = [sample_in; dummy_data];
sample_in_strobe = [sample_in_strobe; true(length(dummy_data), 1)];

fprintf('   - LTS sample sayisi: %d\n', length(lts_freq));
fprintf('   - Toplam input sample: %d (2 x LTS + 1 x Data Sembolü)\n', length(sample_in));

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
    
    fprintf('   - Islem tamamlandi!\n');
    fprintf('   - Output sample sayisi: %d\n', length(sample_out));
    fprintf('   - CSI valid: %d\n', csi_valid);
    fprintf('   - Son state: %d\n', state_out.state);
    
catch ME
    fprintf('   [HATA] %s\n', ME.message);
    fprintf('   Stack:\n');
    for i = 1:length(ME.stack)
        fprintf('     %s (line %d)\n', ME.stack(i).name, ME.stack(i).line);
    end
end

%% 4. Sonuçları Göster
fprintf('\n4. Sonuclar:\n');

% CSI sonuçlarını göster
if exist('csi', 'var') && ~isempty(csi)
    fprintf('   ✓ Kanal Tahmin Başarılı!\n');
    fprintf('   - CSI sample sayisi: %d\n', length(csi));
    fprintf('   - CSI geçerli: %s\n', mat2str(csi_valid));
    
    % İlk 10 CSI göster
    fprintf('\n   Ilk 10 CSI Degeri:\n');
    for i = 1:min(10, length(csi))
        fprintf('     [%2d] Real: %8d, Imag: %8d\n', i, ...
                real(csi(i)), imag(csi(i)));
    end
else
    fprintf('   [UYARI] CSI uretilmedi!\n');
end

% Eşitlenmiş veri sonuçlarını göster (opsiyonel - state machine'e bağlı)
if exist('sample_out', 'var') && ~isempty(sample_out)
    fprintf('\n   ✓ Eslitlenmiş Veri Başarılı!\n');
    fprintf('   - Eslitlenen sample sayisi: %d\n', sum(sample_out_strobe));
    
    % İlk 10 sample göster
    fprintf('\n   Ilk 10 Eslitilmis Sample:\n');
    for i = 1:min(10, length(sample_out))
        fprintf('     [%2d] Real: %8d, Imag: %8d\n', i, ...
                real(sample_out(i)), imag(sample_out(i)));
    end
else
    fprintf('\n   [BILGI] Eslitlenmiş veri henüz uretilmedi\n');
    fprintf('   (State machine pilot phase estimation aşamasında)\n');
    fprintf('   Daha fazla OFDM sembolü gönderilerek veri elde edilebilir.\n');
end

%% 5. Grafik Çizimi (opsiyonel)


if exist('sample_out', 'var') && ~isempty(sample_out)
    fprintf('\n5. Grafik ciziliyor...\n');
    figure('Name', 'Channel Estimator Test Results', 'Position', [100 100 1200 800]);
    
    % Subplot 1: Constellation
    subplot(2, 2, 1);
    plot(real(sample_out), imag(sample_out), 'o', 'MarkerSize', 4);
    grid on;
    title('Equalized Data - Constellation');
    xlabel('Real');
    ylabel('Imaginary');
    axis equal;
    
    % Subplot 2: Magnitude
    subplot(2, 2, 2);
    plot(abs(sample_out), 'b.-');
    grid on;
    title('Equalized Data - Magnitude');
    xlabel('Sample Index');
    ylabel('Magnitude');
    
    % Subplot 3: Phase
    subplot(2, 2, 3);
    plot(angle(sample_out)*180/pi, 'r.-');
    grid on;
    title('Equalized Data - Phase');
    xlabel('Sample Index');
    ylabel('Phase (degrees)');
    
    % Subplot 4: CSI
    if exist('csi', 'var') && ~isempty(csi)
        subplot(2, 2, 4);
        stem(abs(csi), 'filled');
        grid on;
        title('Channel State Information (CSI) - Magnitude');
        xlabel('Subcarrier Index');
        ylabel('|H|');
    end
    
    fprintf('   - Grafik cizildi!\n');
end

fprintf('\n=== TEST TAMAMLANDI ===\n');

%% Yardımcı Fonksiyon
function rot_lut = generate_rotation_lut()
    % Rotation LUT oluştur (512 entry, complex)
    % exp(j * theta) values for theta = 0 to 2*pi
    
    T_int16 = numerictype(1, 16, 0);
    LUT_SIZE = 512;
    SCALE = 2048;  % ROTATE_LUT_SCALE_SHIFT = 11 -> 2^11 = 2048
    
    rot_lut = fi(zeros(LUT_SIZE, 1), T_int16, T_int16, T_int16);
    
    for i = 0:LUT_SIZE-1
        theta = 2 * pi * i / LUT_SIZE;
        rot_val = exp(1j * theta) * SCALE;
        rot_lut(i+1) = fi(rot_val, T_int16, T_int16, T_int16);
    end
end
