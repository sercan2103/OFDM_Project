%% GENERATE_TEST_DATA - LTS Test Verisi Oluştur
% Verilog testbench ile karşılaştırma için test verisi üretir
%
% KULLANIM:
%   generate_test_data();
%
% ÇIKIŞ:
%   - test_input.mat: Input sample'lar
%   - test_expected.mat: Beklenen output (varsa)
%
% AUTHOR: Generated for Channel Estimator
% DATE: 2026-01-31

function generate_test_data()

fprintf('=== TEST VERİSİ OLUŞTURULUYOR ===\n\n');

%% 1. LTS Sequence (IEEE 802.11)
fprintf('1. LTS sekansı oluşturuluyor...\n');

% Long Training Sequence - Frekans domaininde
% 52 subcarrier için bilinen BPSK değerler
lts_freq_nonzero = [1, 1, -1, -1, 1, 1, -1, 1, -1, 1, 1, 1, 1, 1, 1, -1, -1, ...
                    1, 1, -1, 1, -1, 1, 1, 1, 1, 1, 1, -1, -1, 1, 1, -1, 1, ...
                    -1, 1, -1, -1, -1, -1, -1, 1, 1, -1, -1, 1, -1, 1, -1, 1, 1, 1, 1];

% 64-point FFT için mapping
% DC (index 0) = 0
% Subcarriers -26 to -1 and 1 to 26
lts_freq = zeros(64, 1);
lts_freq(2:27) = lts_freq_nonzero(27:52);    % Positive frequencies (1 to 26)
lts_freq(39:64) = lts_freq_nonzero(1:26);    % Negative frequencies (-26 to -1)

fprintf('   - LTS frekans değerleri hazır\n');

%% 2. Kanal Modeli
fprintf('\n2. Kanal modeli oluşturuluyor...\n');

% Basit multipath kanal
% h(t) = δ(t) + 0.5*δ(t-τ1) + 0.3*δ(t-τ2)
H_freq = ones(64, 1);

% İlk yol: Direct (delay=0)
path1_gain = 1.0;
path1_phase = 0;

% İkinci yol: Delay=5 samples
path2_gain = 0.5;
path2_delay = 5;
path2_phase = -2*pi*path2_delay/64;

% Üçüncü yol: Delay=10 samples
path3_gain = 0.3;
path3_delay = 10;
path3_phase = -2*pi*path3_delay/64;

for k = 1:64
    subcarrier_idx = k - 1;
    if subcarrier_idx > 32
        subcarrier_idx = subcarrier_idx - 64;
    end
    
    H_freq(k) = path1_gain * exp(1j * path1_phase * subcarrier_idx) + ...
                path2_gain * exp(1j * path2_phase * subcarrier_idx) + ...
                path3_gain * exp(1j * path3_phase * subcarrier_idx);
end

fprintf('   - 3-path multipath kanal modeli\n');
fprintf('   - Path 1: gain=%.1f, delay=0\n', path1_gain);
fprintf('   - Path 2: gain=%.1f, delay=%d\n', path2_gain, path2_delay);
fprintf('   - Path 3: gain=%.1f, delay=%d\n', path3_gain, path3_delay);

%% 3. Alınan Sinyal (Noise-free)
fprintf('\n3. Alınan sinyal hesaplanıyor...\n');

% Y = H * X
Y_freq = lts_freq .* H_freq;

% Fixed-point conversion (int16)
T_int16 = numerictype(1, 16, 0);
SCALE_FACTOR = 8000;  % Overflow'u önlemek için

Y_freq_scaled = Y_freq * SCALE_FACTOR;
Y_int16_real = int16(round(real(Y_freq_scaled)));
Y_int16_imag = int16(round(imag(Y_freq_scaled)));

% Complex int16 array
Y_int16 = complex(double(Y_int16_real), double(Y_int16_imag));

fprintf('   - Ölçekleme faktörü: %d\n', SCALE_FACTOR);
fprintf('   - Min değer: %d + j%d\n', min(Y_int16_real), min(Y_int16_imag));
fprintf('   - Max değer: %d + j%d\n', max(Y_int16_real), max(Y_int16_imag));

%% 4. İki LTS Paketi
fprintf('\n4. LTS paketleri oluşturuluyor...\n');

% İlk LTS
lts1 = Y_int16;

% İkinci LTS (hafif gürültü ekle)
noise_level = 10;  % int16 noise
noise_real = int16(noise_level * randn(64, 1));
noise_imag = int16(noise_level * randn(64, 1));
lts2 = Y_int16 + complex(double(noise_real), double(noise_imag));

% Toplam input
sample_in = [lts1; lts2];
sample_in_strobe = true(length(sample_in), 1);

fprintf('   - LTS1: %d sample\n', length(lts1));
fprintf('   - LTS2: %d sample (gürültülü)\n', length(lts2));
fprintf('   - Toplam: %d sample\n', length(sample_in));

%% 5. Beklenen Çıkış (İdeal)
fprintf('\n5. Beklenen çıkış hesaplanıyor...\n');

% İdeal kanal tahmini
H_estimated = (lts1 + lts2) ./ 2;

% Veri alt-taşıyıcı maskeleri
DATA_SUBCARRIER_MASK = logical([1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,1,1,1,1,1,0,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1]);

% CSI (kanal katsayıları)
csi_expected = H_estimated;

fprintf('   - CSI: %d katsayı\n', sum(DATA_SUBCARRIER_MASK));

%% 6. Kaydet
fprintf('\n6. Dosyalar kaydediliyor...\n');

% Test input
test_input.sample_in = sample_in;
test_input.sample_in_strobe = sample_in_strobe;
test_input.ht_next = false;
test_input.pkt_ht = false;
test_input.ht_smoothing = false;
test_input.disable_all_smoothing = false;
test_input.description = 'LTS test data with 3-path multipath channel';

save('test_input.mat', 'test_input');
fprintf('   - test_input.mat kaydedildi\n');

% Test expected
test_expected.csi = csi_expected;
test_expected.H_channel = H_freq;
test_expected.lts_original = lts_freq;
test_expected.scale_factor = SCALE_FACTOR;

save('test_expected.mat', 'test_expected');
fprintf('   - test_expected.mat kaydedildi\n');

% Kanal bilgileri
channel_info.H_freq = H_freq;
channel_info.paths = struct('gain', {path1_gain, path2_gain, path3_gain}, ...
                            'delay', {0, path2_delay, path3_delay});

save('channel_info.mat', 'channel_info');
fprintf('   - channel_info.mat kaydedildi\n');

%% 7. Grafik
fprintf('\n7. Grafik oluşturuluyor...\n');

figure('Name', 'Test Data Generation', 'Position', [100 100 1400 800]);

% Subplot 1: LTS Frequency Domain
subplot(2, 3, 1);
stem(abs(lts_freq), 'filled');
grid on;
title('Original LTS (Frequency Domain)');
xlabel('Subcarrier Index');
ylabel('Magnitude');

% Subplot 2: Channel Frequency Response
subplot(2, 3, 2);
plot(abs(H_freq), 'LineWidth', 2);
grid on;
title('Channel Frequency Response |H(f)|');
xlabel('Subcarrier Index');
ylabel('Magnitude');

% Subplot 3: Channel Phase
subplot(2, 3, 3);
plot(angle(H_freq)*180/pi, 'LineWidth', 2);
grid on;
title('Channel Phase Response');
xlabel('Subcarrier Index');
ylabel('Phase (degrees)');

% Subplot 4: Received LTS1
subplot(2, 3, 4);
plot(real(lts1), imag(lts1), 'o');
grid on;
title('Received LTS1 (Constellation)');
xlabel('Real');
ylabel('Imaginary');
axis equal;

% Subplot 5: Received LTS2 (with noise)
subplot(2, 3, 5);
plot(real(lts2), imag(lts2), 'o');
grid on;
title('Received LTS2 (with Noise)');
xlabel('Real');
ylabel('Imaginary');
axis equal;

% Subplot 6: Estimated CSI
subplot(2, 3, 6);
stem(abs(csi_expected), 'filled');
grid on;
title('Expected CSI (Channel Estimate)');
xlabel('Subcarrier Index');
ylabel('Magnitude');

fprintf('   - Grafik çizildi\n');

fprintf('\n=== TEST VERİSİ HAZIR ===\n');
fprintf('Dosyalar:\n');
fprintf('  - test_input.mat\n');
fprintf('  - test_expected.mat\n');
fprintf('  - channel_info.mat\n\n');

end
