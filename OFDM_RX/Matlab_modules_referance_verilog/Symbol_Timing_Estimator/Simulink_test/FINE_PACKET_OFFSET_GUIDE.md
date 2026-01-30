# Fine Packet Offset Estimator - Simulink Test Rehberi

## Dosya Yapısı

```
Simulink_test/
├── fine_packet_offset_input_generator.m      # Input üretir (kaldırıldı - tester'a entegre)
├── fine_packet_offset_tester.m               # Temel test (Symbol Timing Est. tarzı)
├── compare_testers.m                         # Fine Packet Offset vs Symbol Timing Est.
├── fine_packet_offset_simulink_setup.m       # Simulink setup
├── fine_packet_offset_fcn.m                  # Ana fonksiyon (template)
├── SIMULINK_TEST_GUIDE.md                    # Simulink entegrasyonu
├── FINE_PACKET_OFFSET_GUIDE.md              # Bu dosya
└── Results/
    ├── fine_packet_offset_results.csv        # Sonuç raporu
    └── fine_packet_offset_results.mat        # MAT formatında sonuçlar
```

## Hızlı Başlangıç (3 Adım)

### 1️⃣ INPUT'LAR OLUŞTUR
```matlab
>> cd 'Simulink_test'
>> fine_packet_offset_tester
```
**Ne yapar:**
- LTS preamble ile test paketi oluşturur (symbol_timing_estimator benzer)
- AWGN gürültüsü ekler (20 dB SNR)
- Pre-samples timing offset uygular
- Workspace'e testCases kaydeder
- Symbol timing estimator ile karşılaştırılabilir sonuçlar üretir

**Output:** 
- Test sinyalleri + Korelasyon metriği grafikleri (symbol_timing_estimator tarzı)
- Performance özeti
- Resmi MATLAB wlanSymbolTimingEstimate çıktısı

---

### 2️⃣ KARŞILAŞTIRMA (Fine Packet Offset vs Symbol Timing Estimator)
```matlab
>> compare_testers
```
**Ne yapar:**
- Her iki tester'ı aynı test sinyali ile çalıştırır
- Offset tahminlerini karşılaştırır
- Korelasyon metrikleri analiz eder
- Performans tablosu oluşturur
- Yan yana grafikleri gösterir

**Output:** 
- 3 figure (Metric karşılaştırma, IQ karşılaştırma, Magnitude karşılaştırma)
- Detaylı performance tablosu
- Offset farkı analizi

---

## Detaylı Açıklama

### Adım 1: Fine Packet Offset Tester (Symbol Timing Estimator'a benzer)

**Test Yapısı:**
- **Input:** LTS Preamble + Pre-samples (50 sample)
- **Kanal:** AWGN (20 dB SNR), Multipath YOK
- **Timing:** Coarse offset = 50 samples (pre-samples)
- **Output:** Correlation metric + fine offset tahmin

**Grafikleri (2x2 layout - symbol_timing_estimator ile aynı):**
1. **Correlation Metric:** Peak detection ve korelasyon değerleri
2. **IQ Sinyali:** Real ve Imaginary bileşenleri
3. **Magnitude + Offsets:** Coarse ve Fine offset işaretleri
4. **Normalized Metric:** Threshold ile karşılaştırma (0.8)

**Performance Özeti:**
- Detection başarısı (YES/NO)
- Timing accuracy (GOOD/NEEDS IMPROVEMENT)
- Peak metric value
- Average metric value
- Peak-to-average ratio (dB)

---

### Adım 2: Comparison Script (compare_testers.m)

**Karşılaştırılanlar:**
- Aynı test sinyali ile her iki algoritma çalışır
- Offset tahminleri karşılaştırılır
- Metrik değerleri analiz edilir
- Performance metrikleri tablolanır

**Çıktılar:**
- Figure 1: Correlation metric (2 subplot)
- Figure 2: IQ sinyalleri (2 subplot)
- Figure 3: Magnitude + offsets (2 subplot)
- Figure 4: Normalized metric (2 subplot)
- Tablo: Detaylı karşılaştırma

**Başarı Kriteri:**
```
Offset farkı <= 2 samples → ✓ İKİ TESİ BENZERDİR
Offset farkı > 2 samples  → ⚠ TESİ ARASI FARKI VAR
```

#### 3a. Model Yapısı

```
┌─────────────────┐
│ From Workspace  │  ← rx_signal (time series)
│   rx_signal     │
└────────┬────────┘
         │
         ↓
    ┌────────────────────────────┐
    │  MATLAB Function Block     │
    │  fine_packet_offset_fcn    │
    │                            │
    │  Input 1: rx              │
    │  Input 2: coarse_offset   │
    │  Input 3: channel_bw      │
    │                            │
    │  Output: offset           │
    │  Output: peak_metric      │
    └────────────┬───────────────┘
                 │
         ┌───────┴────────┐
         ↓                ↓
    ┌─────────┐      ┌──────────────┐
    │  Scope  │      │To Workspace  │
    │         │      │simout_offset │
    └─────────┘      └──────────────┘
```

#### 3b. From Workspace Bloğu Setup

1. Kütüphaneden "From Workspace" bloğu ekle
2. Parametreleri ayarla:
   - **Variable name:** `rx_signal`
   - **Sample time:** -1
   - **Interpret vector as 1-D array:** ✓

#### 3c. MATLAB Function Bloğu

1. Bloğu çift-tıkla
2. Aşağıdaki kodu yapıştır:

```matlab
function [offset, peak_metric] = fcn(rx, coarse_offset, channel_bw)
    % Fine Packet Offset Estimator
    
    cfgHT = wlanHTConfig('ChannelBandwidth', channel_bw);
    ind = wlanFieldIndices(cfgHT);
    
    try
        % Non-HT fields çıkart
        idx_start = coarse_offset + double(ind.LSTF(1));
        idx_end = coarse_offset + double(ind.LSIG(2));
        
        if idx_end > length(rx), idx_end = length(rx); end
        if idx_start < 1, idx_start = 1; end
        
        nonhtfields = rx(idx_start:idx_end, :);
        
        % Fine timing estimate
        fine_est = wlanSymbolTimingEstimate(nonhtfields, channel_bw);
        
        offset = coarse_offset + fine_est(1);
        peak_metric = max(abs(fine_est));
        
    catch
        offset = coarse_offset;
        peak_metric = 0;
    end
end
```

#### 3d. To Workspace Bloğu

1. "To Workspace" bloğu ekle
2. Parametreleri:
   - **Variable name:** `simout_offset`
   - **Save format:** Array

#### 3e. Scope Bloğu (Opsiyonel)

1. "Scope" bloğu ekle
2. Fine offset output'unu bağla
3. Simulasyon sırasında gerçek-zamanlı görüntüle

---

## OUTPUT GÖZLEMLEME YÖNTEMLERİ

### 🔍 Yöntem 1: SCOPE BLOK (Gerçek-zamanlı)

**Avantajlar:**
- ✅ Simulasyon sırasında gerçek-zamanlı
- ✅ İnterektif (zoom, pan, vb.)
- ✅ Hızlı kontrol

**Kullanım:**
```matlab
>> sim('fine_packet_offset_sim')
% Scope otomatik açılır
% Offset değişimi görüntüle
```

### 📊 Yöntem 2: TO WORKSPACE (Simulasyondan Sonra Analiz)

**Avantajlar:**
- ✅ Tüm zaman serisini kaydeder
- ✅ Post-processing mümkün
- ✅ İstatistiksel analiz yapabilir

**Kullanım:**
```matlab
>> sim('fine_packet_offset_sim')
>> 
>> % Sonuçları analiz et
>> figure;
>> plot(simout_offset);
>> grid on;
>> title('Fine Offset Estimation');
>> 
>> % İstatistikler
>> mean(simout_offset)
>> std(simout_offset)
>> max(simout_offset)
```

### 🐛 Yöntem 3: SIGNAL LOGGING (Debug)

**Avantajlar:**
- ✅ Blok arası sinyalleri kaydeder
- ✅ Detaylı trace
- ✅ Hata bulma

**Kullanım:**
```matlab
>> set_param('fine_packet_offset_sim', 'SignalLogging', 'on');
>> sim('fine_packet_offset_sim');
>> logsout.get('offset').Values
```

### 📈 Yöntem 4: GRAFIK ANALİZİ

```matlab
% Simulasyondan sonra
figure('Position', [100, 100, 1200, 800]);

% Plot 1: Offset zaman serileri
subplot(2, 2, 1);
plot(simout_offset, 'b-', 'LineWidth', 2);
grid on;
xlabel('Sample');
ylabel('Offset (samples)');
title('Fine Offset Estimation');

% Plot 2: Error
subplot(2, 2, 2);
expected = coarse_offset * ones(size(simout_offset));
error = abs(simout_offset - expected);
plot(error, 'r-');
grid on;
xlabel('Sample');
ylabel('Error (samples)');
title('Estimation Error');

% Plot 3: Histogram
subplot(2, 2, 3);
histogram(error, 20);
xlabel('Error (samples)');
ylabel('Frequency');
title('Error Distribution');

% Plot 4: İstatistikler
subplot(2, 2, 4);
text(0.1, 0.5, sprintf(['Mean: %.2f\nStd: %.2f\nMax: %.2f\nMin: %.2f'], ...
    mean(error), std(error), max(error), min(error)), ...
    'FontSize', 12);
axis off;
title('Statistics');
```

---

## DOĞRULAMA KONTROL LİSTESİ

- [ ] fine_packet_offset_tester çalıştırıldı
- [ ] Grafikler symbol_timing_estimator tarzında (2x2 layout)
- [ ] Metric peak doğru detect edildi
- [ ] Coarse vs Fine offset işaretleri doğru
- [ ] compare_testers çalıştırıldı
- [ ] İki tester arasında offset farkı <= 2 samples
- [ ] Performance tablosu uyumlu
- [ ] Normalized metric threshold (0.8) doğru görünüyor
- [ ] results CSV dosyası oluşturuldu
- [ ] comparison_results workspace'te var

---

## HATA AYIKLAMA

### "fine_packet_offset_fcn bulunamadı"
```matlab
% Çözüm: Dosya var mı kontrol et
which fine_packet_offset_fcn
% Yoksa template oluştur: compare_testers otomatik oluşturur
```

### "wlanSymbolTimingEstimate sonuç vermedi"
```matlab
% Çözüm: Communications Toolbox versiyonu kontrol et
ver communications
```

### "Offset farkı çok büyük (compare_testers'da)"
```matlab
% Çözüm: 
% 1. Test sinyalleri aynı mı kontrol et
% 2. Coarse offset değerleri eşit mi kontrol et
% 3. SNR parametreleri aynı mı kontrol et
```

---

## KOMUTLARı HIZLI REFERANS

```matlab
% 1. Fine Packet Offset test (Symbol Timing Estimator tarzı)
cd 'Simulink_test'
fine_packet_offset_tester

% 2. Karşılaştırma (Fine Packet Offset vs Symbol Timing Estimator)
compare_testers

% 3. Simulink setup (opsiyonel)
fine_packet_offset_simulink_setup

% 4. CSV raporu aç
open fine_packet_offset_results.csv

% 5. MAT dosyasından yükle
load fine_packet_offset_results.mat
```

---

## İLERİ AYARLAMALAR

### Farklı SNR Değerleri Test Et
Düzenle: `fine_packet_offset_input_generator.m` satır 20-21
```matlab
SNR_values = [10, 15, 20, 25, 30];  % Değiştir
```

### Farklı Kanal Bandwidth
Düzenle: satır 14
```matlab
simParams.channelBandwidth = 'CBW40';  % 'CBW20', 'CBW40', 'CBW80'
```

### Multipath Kanal Tipleri
Düzenle: satır 52
```matlab
delayProfile = 'Model-B';  % 'Model-A', 'Model-B', 'Model-C', 'Model-D'
```

---

## İLETİŞİM

- **Sorular:** README.md dosyasını kontrol et
- **Hatalar:** Error message'ı kopyala ve araştır
- **Geliştirilmeler:** Script'leri özelleştir

---

**Başarılar! 🚀**
