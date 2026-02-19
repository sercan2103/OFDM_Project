%% 1. Parametrelerin Belirlenmesi
chanBW = 'CBW20';     % Kanal Bant Genişliği
Fs = 20e6;            % 20 MHz örnekleme frekansı
Td = 0.8e-6;          % Sembol süresi
symbolLength = 16;    % CBW20 için 1 kısa eğitim sembolü (16 örnek)
trueStartOffset = 200; % Paketin başlayacağı gerçek örnek indeksi (Delay)

%% 2. Sentetik Sinyal (L-STF) Üretimi
% L-STF, art arda gelen 10 adet özdeş kısa sembolden oluşur.
rng(42); % Sonuçların tekrar edilebilir olması için
shortSymbol = (randn(symbolLength, 1) + 1i*randn(symbolLength, 1)); 

% 10 adet kısa sembolü arka arkaya ekle (L-STF)
LSTF = repmat(shortSymbol, 10, 1);

% Paketin geri kalanı (Rastgele veri - L-LTF, SIG, Payload vs.)
payload = (randn(500, 1) + 1i*randn(500, 1));

% Paketin öncesindeki boşluk (Sadece kanal gürültüsü)
idleNoise = 0.1 * (randn(trueStartOffset, 1) + 1i*randn(trueStartOffset, 1));

% Temiz sinyali birleştir
cleanRxWaveform = [idleNoise; LSTF; payload];

%% 3. Test Senaryoları

fprintf('--- PacketDetect Test Başlıyor ---\n\n');

% TEST 1: İdeal (Çok az gürültülü) Sinyal
fprintf('TEST 1: İdeal Sinyal (SNR Yüksek)\n');
% Sinyale çok az AWGN gürültüsü ekleyelim
noisyWaveform1 = cleanRxWaveform + 0.05 * (randn(size(cleanRxWaveform)) + 1i*randn(size(cleanRxWaveform)));

[detStart1, metric1] = asdasd(noisyWaveform1, chanBW);
fprintf('  Beklenen Başlangıç : %d\n', trueStartOffset);
fprintf('  Bulunan Başlangıç  : %d\n', detStart1);
if abs(detStart1 - trueStartOffset) < 5
    fprintf('  Sonuç: BAŞARILI\n\n');
else
    fprintf('  Sonuç: BAŞARISIZ\n\n');
end

% TEST 2: Sadece Gürültü (Paket Yok)
fprintf('TEST 2: Sadece Gürültü (Yanlış Alarm Testi)\n');
pureNoise = randn(1000, 1) + 1i*randn(1000, 1);
[detStart2, ~] = asdasd(pureNoise, chanBW);
if isempty(detStart2)
    fprintf('  Sonuç: BAŞARILI (Paket bulunmadı, beklenen durum)\n\n');
else
    fprintf('  Sonuç: BAŞARISIZ (Yanlış alarm! Başlangıç: %d)\n\n', detStart2);
end

% TEST 3: Offset ve Threshold Parametreleri ile Test
fprintf('TEST 3: Parametreli Kullanım (Offset=100, Threshold=0.75)\n');
offsetVal = 100;
thresholdVal = 0.75;
[detStart3, metric3] = asdasd(noisyWaveform1, chanBW, offsetVal, thresholdVal);
fprintf('  Bulunan Başlangıç  : %d\n', detStart3);
if abs(detStart3 - trueStartOffset) < 5
    fprintf('  Sonuç: BAŞARILI\n\n');
else
    fprintf('  Sonuç: BAŞARISIZ\n\n');
end

%% 4. Sonuçların Görselleştirilmesi
figure('Name', 'Packet Detection Sonuçları', 'Color', 'w');

% Üst Grafik: Gelen Sinyalin Genliği
subplot(2,1,1);
plot(abs(noisyWaveform1), 'b');
hold on;
if ~isempty(detStart1)
    xline(detStart1, 'r-', 'LineWidth', 2);
end
title('Alınan Sinyal Genliği (|x|)');
ylabel('Genlik');
xlabel('Örnek (Sample)');
legend('Sinyal', 'Tespit Edilen Başlangıç', 'Location', 'best');
grid on;

% Alt Grafik: Otokorelasyon Metriği (M)
subplot(2,1,2);
plot(metric1, 'k', 'LineWidth', 1.2);
hold on;
yline(0.5, 'r--', 'Varsayılan Eşik (0.5)'); % Fonksiyondaki default threshold
if ~isempty(detStart1)
    % Bulunan noktanın metrik değerini işaretle
    plot(detStart1, metric1(detStart1), 'ro', 'MarkerSize', 8, 'MarkerFaceColor', 'r');
end
title('Gecikmeli Otokorelasyon Metriği (Mn)');
ylabel('Metrik (0-1 arası)');
xlabel('Örnek (Sample)');
grid on;
ylim([0 1.1]);
