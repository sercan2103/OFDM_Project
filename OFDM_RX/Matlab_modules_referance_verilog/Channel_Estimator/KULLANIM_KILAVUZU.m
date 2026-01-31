%% KULLANIM KILAVUZU - Channel Estimator MATLAB Referans Model
%
% Bu dosya, Channel Estimator MATLAB referans modelinin nasıl kullanılacağını
% adım adım açıklar.
%
% AUTHOR: Generated for Channel Estimator
% DATE: 2026-01-31

%% ========================================================================
%% ADIM 1: HIZLI TEST (Önerilen başlangıç)
%% ========================================================================

% Basit bir test çalıştırın:
cd ~/Desktop/MATLAB/OFDM_Project/OFDM_RX/Matlab_modules_referance_verilog/Channel_Estimator
run test_channel_estimator.m

% Bu script:
% - Rotation LUT oluşturur
% - Test LTS verisi oluşturur
% - Channel estimator'ı çalıştırır
% - Sonuçları görselleştirir

%% ========================================================================
%% ADIM 2: TEST VERİSİ OLUŞTURMA (Opsiyonel)
%% ========================================================================

% Kendi test verinizi oluşturmak için:
generate_test_data();

% Bu fonksiyon şunları oluşturur:
% - test_input.mat: Input sample'lar (2 LTS)
% - test_expected.mat: Beklenen CSI
% - channel_info.mat: Kanal modeli bilgileri

% Kanal modeli:
% - 3-path multipath
% - Path 1: gain=1.0, delay=0
% - Path 2: gain=0.5, delay=5
% - Path 3: gain=0.3, delay=10

%% ========================================================================
%% ADIM 3: MANUEL KULLANIM
%% ========================================================================

% Channel estimator'ı manuel olarak çağırma:

% 3.1. Parametreleri hazırlayın
sample_in = [...];              % Complex int16 array [Nx1]
sample_in_strobe = true(N, 1);  % Valid signals
ht_next = false;                % Next symbol HT?
pkt_ht = false;                 % Packet HT?
ht_smoothing = false;           % HT smoothing bit
disable_all_smoothing = false;  % Disable all smoothing

% 3.2. Rotation LUT oluşturun
T_int16 = numerictype(1, 16, 0);
LUT_SIZE = 512;
SCALE = 2048;
rot_lut = fi(zeros(LUT_SIZE, 1), T_int16, T_int16, T_int16);
for i = 0:LUT_SIZE-1
    theta = 2 * pi * i / LUT_SIZE;
    rot_val = exp(1j * theta) * SCALE;
    rot_lut(i+1) = fi(rot_val, T_int16, T_int16, T_int16);
end

% 3.3. Channel estimator'ı çalıştırın
[sample_out, sample_out_strobe, csi, csi_valid, state_out] = ...
    channel_estimator_fixed(sample_in, sample_in_strobe, ht_next, pkt_ht, ...
                           ht_smoothing, disable_all_smoothing, rot_lut, []);

% 3.4. Sonuçları kullanın
equalized_data = sample_out(sample_out_strobe);
channel_estimates = csi;

%% ========================================================================
%% ADIM 4: VERILOG İLE KARŞILAŞTIRMA
%% ========================================================================

% 4.1. Verilog testbench'ten çıkış verilerini alın
% Örnek Verilog çıkış formatı:
% - sample_out: Equalized samples [Mx1]
% - csi: Channel estimates [64x1]

% 4.2. MATLAB formatına çevirin ve kaydedin
verilog_output.sample_out = [...];  % Verilog'dan gelen veriler
verilog_output.csi = [...];
save('verilog_output.mat', 'verilog_output');

% 4.3. Karşılaştırma scriptini çalıştırın
compare_with_verilog();

% Bu script:
% - MATLAB ve Verilog çıkışlarını karşılaştırır
% - Farkları hesaplar
% - Grafikleri çizer
% - Bit-accuracy kontrolü yapar

%% ========================================================================
%% ADIM 5: KENDİ VERİLERİNİZ İLE TEST
%% ========================================================================

% Kendi FFT çıkış verilerinizle test etmek için:

% 5.1. FFT çıkışını yükleyin
fft_output = load('your_fft_output.mat');

% 5.2. Format kontrolü yapın
% Her sample complex int16 olmalı:
% sample = complex(int16(real_part), int16(imag_part))

% 5.3. İki LTS gönderin
lts1 = fft_output.lts_symbol1;  % First LTS [64x1]
lts2 = fft_output.lts_symbol2;  % Second LTS [64x1]
sample_in = [lts1; lts2];
sample_in_strobe = true(128, 1);

% 5.4. Çalıştırın
[sample_out, ~, csi, ~, ~] = channel_estimator_fixed(...
    sample_in, sample_in_strobe, false, false, false, false, rot_lut, []);

% 5.5. Sonuçları analiz edin
figure;
subplot(2,2,1);
plot(real(sample_out), imag(sample_out), 'o');
title('Equalized Constellation');
grid on; axis equal;

subplot(2,2,2);
stem(abs(csi));
title('Channel Estimates |H|');
grid on;

subplot(2,2,3);
plot(angle(csi)*180/pi);
title('Channel Phase');
grid on;

%% ========================================================================
%% ÖRNEK SENARYOLAR
%% ========================================================================

%% Senaryo 1: Legacy (Non-HT) Paket ile Smoothing
fprintf('\n=== Senaryo 1: Legacy paket ===\n');
load('test_input.mat');
rot_lut = generate_rotation_lut();

[out1, ~, csi1, ~, ~] = channel_estimator_fixed(...
    test_input.sample_in, test_input.sample_in_strobe, ...
    false, false, false, false, rot_lut, []);

fprintf('Output: %d sample\n', length(out1));
fprintf('CSI: %d estimate\n', length(csi1));

%% Senaryo 2: HT Paket
fprintf('\n=== Senaryo 2: HT paket ===\n');

[out2, ~, csi2, ~, ~] = channel_estimator_fixed(...
    test_input.sample_in, test_input.sample_in_strobe, ...
    true, true, true, false, rot_lut, []);

fprintf('Output: %d sample (52 data subcarriers expected)\n', length(out2));

%% Senaryo 3: Smoothing Kapalı (Hızlı mod)
fprintf('\n=== Senaryo 3: Smoothing kapali ===\n');

[out3, ~, csi3, ~, ~] = channel_estimator_fixed(...
    test_input.sample_in, test_input.sample_in_strobe, ...
    false, false, false, true, rot_lut, []);

fprintf('Output: %d sample\n', length(out3));

%% ========================================================================
%% PERFORMANS İPUÇLARI
%% ========================================================================

% 1. Fixed-Point Toolbox gereklidir
% 2. Persistent değişkenler kullanıldığı için fonksiyon stateful'dır
% 3. İlk çağrıda otomatik reset olur
% 4. Her paket için yeni bir session başlatın (clear fonksiyonu)

% Fonksiyonu resetlemek için:
clear channel_estimator_fixed

%% ========================================================================
%% SORUN GİDERME
%% ========================================================================

% Sorun 1: "Undefined function or variable"
% Çözüm: Fixed-Point Toolbox kurulu olmalı
%        >> ver  % Kurulu toolbox'ları kontrol edin

% Sorun 2: "Output boş geliyor"
% Çözüm: - sample_in_strobe doğru mu?
%        - Input formatı doğru mu (complex int16)?
%        - En az 128 sample var mı (2 LTS)?

% Sorun 3: "Verilog ile fark var"
% Çözüm: - Fixed-point overflow kontrol edin
%        - Rotation LUT aynı mı?
%        - Strobe timing'leri aynı mı?

%% ========================================================================
%% YARDIMCI FONKSİYONLAR
%% ========================================================================

function rot_lut = generate_rotation_lut()
    % Rotation LUT generator (512 entry)
    T_int16 = numerictype(1, 16, 0);
    LUT_SIZE = 512;
    SCALE = 2048;
    
    rot_lut = fi(zeros(LUT_SIZE, 1), T_int16, T_int16, T_int16);
    
    for i = 0:LUT_SIZE-1
        theta = 2 * pi * i / LUT_SIZE;
        rot_val = exp(1j * theta) * SCALE;
        rot_lut(i+1) = fi(rot_val, T_int16, T_int16, T_int16);
    end
end

%% ========================================================================
%% REFERANSLAR
%% ========================================================================

% 1. Verilog Kaynak: equalizer.v
% 2. IEEE 802.11-2012: Section 20.3.9.4.3
% 3. OpenOFDM Project: https://github.com/open-sdr/openwifi
% 4. MATLAB Fixed-Point Toolbox: doc fi

%% ========================================================================
%% İLETİŞİM
%% ========================================================================

% Bu model Verilog equalizer.v'den otomatik üretilmiştir.
% Sorular için OpenOFDM projesi dokümantasyonuna bakın.

fprintf('\n=== KULLANIM KILAVUZU SONU ===\n');
fprintf('Basit test icin: run test_channel_estimator.m\n\n');
