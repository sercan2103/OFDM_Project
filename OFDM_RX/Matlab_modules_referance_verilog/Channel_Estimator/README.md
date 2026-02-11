# Channel Estimator - MATLAB Referans Model

Bu dizin, Verilog `equalizer.v` modülünün bit-accurate MATLAB referans modelini içerir.

## 📁 Dosyalar

### 1. `channel_estimator_fixed.m`
Ana channel estimator fonksiyonu. Fixed-point aritmetik kullanır ve Verilog kodunu birebir taklit eder.

**Giriş Parametreleri:**
- `sample_in`: FFT çıkışından gelen IQ örnekleri (complex int16)
- `sample_in_strobe`: Valid sinyali
- `ht_next`: Sonraki sembol HT mi?
- `pkt_ht`: Paket HT mi?
- `ht_smoothing`: HT smoothing biti
- `disable_all_smoothing`: Tüm smoothing'i kapat
- `rot_lut`: Rotasyon LUT (512 entry)
- `params`: Sabit parametreler

**Çıkış Parametreleri:**
- `sample_out`: Eşitlenmiş veri alt-taşıyıcıları
- `sample_out_strobe`: Valid sinyali
- `csi`: Channel State Information (kanal katsayıları)
- `csi_valid`: CSI valid sinyali
- `state_out`: İç durum değişkenleri (debug)

### 2. `test_channel_estimator.m`
Test scripti. Channel estimator'ı test eder ve sonuçları görselleştirir.

**Kullanım:**
```matlab
cd ~/Desktop/MATLAB/OFDM_Project/OFDM_RX/Matlab_modules_referance_verilog/Channel_Estimator
run test_channel_estimator.m
```

## 🔧 Özellikler

### Kanal Tahmini (Channel Estimation)
1. **İki LTS Ortalaması**: LTS1 ve LTS2'nin ortalamasını alır
2. **Kanal Smoothing**: DC ve LTS bölgelerinde hareketli ortalama (opsiyonel)
3. **CSI Çıkışı**: Her OFDM sembolü için kanal katsayılarını sağlar

### Faz Hatası Düzeltmesi
1. **CPE (Common Phase Error)**: Kalan frekans ofseti (RFO) düzeltmesi
2. **LVPE (Linear Varying Phase Error)**: Örnekleme frekans ofseti (SFO) kompanzasyonu
3. **Pilot Tracking**: 4 pilot alt-taşıyıcı ile faz takibi

### Kanal Eşitleme (Channel Equalization)
1. **Zero-Forcing**: Y/H hesabı ile veri düzeltme
2. **Phase Rotation**: CPE ve LVPE ile faz düzeltme
3. **Normalization**: Kanal katsayısına bölme

## 📊 Fixed-Point Formatlar

| Değişken | Format | Açıklama |
|----------|--------|----------|
| Input/Output | int16 | Signed 16-bit integer |
| LTS Buffer | int16 | Channel coefficients |
| Pilot Accumulator | int32 | Signed 32-bit accumulator |
| Phase | int16 | -π to π, scaled by 512 |
| LVPE | int32 | Phase error gradient |

## 🎯 Kullanım Senaryoları

### Senaryo 1: Legacy (Non-HT) Paket
```matlab
ht_next = false;
pkt_ht = false;
disable_all_smoothing = false;

[sample_out, ~, csi, ~, ~] = channel_estimator_fixed(...
    sample_in, strobe, ht_next, pkt_ht, false, disable_all_smoothing, rot_lut, []);
```

### Senaryo 2: HT Paket
```matlab
ht_next = true;
pkt_ht = true;
ht_smoothing = true;

[sample_out, ~, csi, ~, ~] = channel_estimator_fixed(...
    sample_in, strobe, ht_next, pkt_ht, ht_smoothing, false, rot_lut, []);
```

### Senaryo 3: Smoothing Kapalı (Hızlı Mod)
```matlab
disable_all_smoothing = true;

[sample_out, ~, csi, ~, ~] = channel_estimator_fixed(...
    sample_in, strobe, false, false, false, disable_all_smoothing, rot_lut, []);
```

## 🔍 Verilog ile Karşılaştırma

Bu model aşağıdaki Verilog dosyalarına karşılık gelir:
- `equalizer.v` - Ana state machine ve kontrol
- `complex_mult.v` - Kompleks çarpma
- `divider.v` - Sabit noktalı bölme
- `calc_mean.v` - LTS ortalaması
- `rotate.v` - Faz rotasyonu
- `phase.v` - ATAN2 hesaplama

## ⚠️ Önemli Notlar

1. **Persistent Variables**: MATLAB fonksiyonu stateful'dır (persistent değişkenler kullanır)
2. **Reset**: İlk çağrıda otomatik olarak sıfırlanır
3. **Strobe Signals**: Her sample için strobe sinyali gereklidir
4. **Fixed-Point**: MATLAB Fixed-Point Toolbox gereklidir
5. **Bit-Accurate**: Verilog ile tam uyumlu olması hedeflenmiştir

## 🧪 Doğrulama

Model doğrulaması için:
1. Verilog testbench'ten sample'ları al
2. MATLAB modeline besle
3. Çıkışları karşılaştır
4. Bit-level farkları kontrol et

```matlab
% Verilog çıkışı
verilog_out = load('verilog_output.mat');

% MATLAB çıkışı
matlab_out = channel_estimator_fixed(...);

% Karşılaştırma
diff = abs(matlab_out - verilog_out);
max_diff = max(diff);
fprintf('Max difference: %d bits\n', max_diff);
```

## 📚 Referanslar

1. IEEE 802.11-2012: Wireless LAN Medium Access Control (MAC) and Physical Layer (PHY) Specifications
2. Section 20.3.9.4.3: Channel estimation and smoothing
3. OpenOFDM Verilog Implementation: equalizer.v

## 👤 Yazar

Auto-generated from Verilog equalizer.v
Date: 2026-01-31

## 📄 Lisans

Bu kod OpenWiFi projesinin bir parçasıdır.
