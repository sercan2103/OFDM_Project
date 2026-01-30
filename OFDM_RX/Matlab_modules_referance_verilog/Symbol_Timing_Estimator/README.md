# Symbol Timing Estimator - MATLAB Referans Model

Bu klasör, OpenWiFi projesindeki `sync_long.v` Verilog modülünün MATLAB referans implementasyonunu içerir.

## 📋 İçerik

### Ana Fonksiyonlar
- **`symbol_timing_estimator.m`** - Ana symbol timing estimator fonksiyonu
- **`convert_to_fixed_point.m`** - Floating-point'ten fixed-point'e dönüşüm
- **`generate_lts_sequence.m`** - IEEE 802.11 Long Training Sequence üretici

### Test ve Doğrulama
- **`test_symbol_timing_estimator.m`** - Test script ve performans analizi
- **`README.md`** - Bu dosya
- **`ALGORITHM_DETAILS.md`** - Detaylı algoritma açıklaması

## 🎯 Amaç

Bu MATLAB modeli:
1. ✅ **Golden Reference**: Verilog implementasyonunun doğruluğunu test etmek için
2. ✅ **Fixed-Point**: Verilog ile birebir aynı fixed-point aritmetik kullanır
3. ✅ **Modüler**: Diğer OFDM RX modülleri ile entegre çalışabilir
4. ✅ **Test Edilebilir**: Kapsamlı test scriptleri içerir

## 🚀 Hızlı Başlangıç

### Temel Kullanım

```matlab
% 1. LTS sinyali üret
lts_signal = generate_lts_sequence();

% 2. Fixed-point'e çevir
lts_fp = convert_to_fixed_point(lts_signal, 16);

% 3. Symbol timing tahmin et
[detected, timing_offset, metric] = symbol_timing_estimator(lts_fp, 0);

% 4. Sonuçları görüntüle
fprintf('Detected: %d, Timing Offset: %d\n', detected, timing_offset);
```

### Test Script'ini Çalıştırma

```matlab
% Test script'ini çalıştır
test_symbol_timing_estimator

% Farklı SNR ve timing offset değerleri ile test etmek için
% script içindeki parametreleri değiştirin:
% - SNR_dB: 0 ile 30 dB arası
% - timing_offset_samples: 0 ile 100 arası
% - fft_win_shift: 0 ile 15 arası (genellikle 0)
```

## 📊 Algoritma Özeti

### Symbol Timing Estimation

**Amaç**: Long Training Sequence (LTS) başlangıç noktasını bul

**Yöntem**: Cross-Correlation
1. 32 örneklik sliding window kullan
2. Bilinen LTS referans değerleri ile çapraz korelasyon hesapla
3. 88 örnek boyunca correlation metric'i izle
4. Maksimum correlation noktasını FFT başlangıcı olarak seç

**Fixed-Point Implementasyon**:
- **Word Width**: 16-bit (I ve Q için ayrı ayrı)
- **Format**: Signed integer (int16)
- **Overflow**: Automatic saturation
- **Rounding**: Round-to-nearest

### Verilog Karşılığı

```
sync_long.v modülü (satır 100-650)
├── Cross-correlation buffer (32 samples)
├── do_mult task (4-stage parallel multiplication)
├── stage_mult.v (8x parallel complex multiplier)
└── complex_to_mag.v (magnitude calculation)
```

## 📈 Input/Output Spesifikasyonları

### Inputs

| Parametre | Tip | Açıklama |
|-----------|-----|----------|
| `samples_in` | `complex int16` | Gelen IQ samples (I:16-bit, Q:16-bit) |
| `fft_win_shift` | `uint8` | FFT window shift (0-15, tipik: 0) |

### Outputs

| Parametre | Tip | Açıklama |
|-----------|-----|----------|
| `detected` | `boolean` | Long preamble detection flag |
| `timing_offset` | `int32` | FFT window başlangıç offset'i |
| `metric_out` | `double[]` | Correlation metric değerleri (debug) |

## 🔧 Entegrasyon

### Diğer Modüllerle Kullanım

```matlab
% OFDM RX Chain içinde kullanım örneği:

% 1. Power trigger'dan sonra
if power_detected
    % 2. Short preamble detection
    [short_detected, cfo_coarse] = sync_short(rx_samples);
    
    if short_detected
        % 3. Symbol timing estimation (BU MODÜL)
        [long_detected, timing_offset, ~] = ...
            symbol_timing_estimator(rx_samples, fft_win_shift);
        
        if long_detected
            % 4. CFO correction
            samples_corrected = apply_cfo_correction(rx_samples, cfo_coarse);
            
            % 5. FFT ve equalization
            fft_start_idx = timing_offset;
            % ... devam eder
        end
    end
end
```

## 📝 Verilog ile Karşılaştırma

### Temel Farklar

| Özellik | Verilog (`sync_long.v`) | MATLAB Model |
|---------|-------------------------|--------------|
| **Aritmetik** | 16-bit fixed-point | 16-bit fixed-point (aynı) |
| **Paralellik** | 8-parallel multiplier | Sequential (MATLAB) |
| **Timing** | Clock-cycle accurate | Functional model |
| **Magnitude** | CORDIC algorithm | `sqrt(i^2 + q^2)` |
| **Memory** | Dual-port RAM | Array indexing |

### Doğruluk Kontrolü

```matlab
% Verilog simülasyon sonuçları ile karşılaştırma:
% 1. Aynı input samples kullan
% 2. Her ikisini de çalıştır
% 3. Sonuçları karşılaştır:
%    - timing_offset (maksimum ±1 sample fark olabilir)
%    - metric_values (CORDIC vs. sqrt farkından dolayı %1-2 fark)
```

## 🧪 Test Senaryoları

### Temel Testler
1. ✅ **Ideal LTS**: SNR=∞, timing offset = 0
2. ✅ **Gürültülü Kanal**: SNR = 10-30 dB
3. ✅ **Timing Offset**: 0-100 sample gecikme
4. ✅ **FFT Window Shift**: 0-15 değer kontrolü

### Kenar Durumlar (Edge Cases)
- LTS yok (false alarm testi)
- Çok düşük SNR (< 5 dB)
- Çok yüksek timing offset (> 100 samples)
- Buffer taşması senaryoları

## 📚 Referanslar

### Verilog Kaynak Dosyaları
- `sync_long.v` (satır 1-661) - Ana modül
- `stage_mult.v` (satır 1-206) - Paralel çarpıcı
- `complex_to_mag.v` - Magnitude hesaplama
- `common_params.v` - Sabit tanımları

### IEEE Standartları
- IEEE 802.11-2012, Section 18.3.3 (Long Training Field)
- IEEE 802.11-2012, Section 18.3.2.3 (Timing Synchronization)

## 🐛 Bilinen Sorunlar ve Sınırlamalar

1. **Magnitude Hesaplama**: MATLAB `sqrt()` kullanır, Verilog CORDIC kullanır
   - Çözüm: Metric değerlerinde %1-2 fark kabul edilebilir
   
2. **Parallel Processing**: MATLAB sequential, Verilog paralel
   - Etki: MATLAB daha yavaş ama sonuç aynı
   
3. **Memory Model**: MATLAB array, Verilog dual-port RAM
   - Etki: Sadece implementation farkı, davranış aynı

## 🔄 Versiyon Geçmişi

| Versiyon | Tarih | Değişiklikler |
|----------|-------|---------------|
| 1.0 | 2026-01-29 | İlk release - Verilog `sync_long.v` referans |

## 👤 Geliştirici Notları

### Fixed-Point Debugging
```matlab
% Fixed-point overflow kontrolü
samples_i = int16(real(samples));
samples_q = int16(imag(samples));
assert(all(samples_i >= -32768 & samples_i <= 32767), 'I overflow!');
assert(all(samples_q >= -32768 & samples_q <= 32767), 'Q overflow!');
```

### Performance Profiling
```matlab
% Profiler ile performans analizi
profile on
test_symbol_timing_estimator
profile viewer
```

## 📧 İletişim

Bu model, OpenWiFi `sync_long.v` Verilog modülünün MATLAB referansıdır.
Sorular için proje dokümantasyonuna bakınız.

---
**Not**: Bu model golden reference olarak kullanılmak üzere tasarlanmıştır.
Real-time implementasyon için Verilog/FPGA versiyonu kullanılmalıdır.
