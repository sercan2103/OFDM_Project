# Noise Power Estimator - MATLAB Golden Reference

Bu dizin, OpenOFDM RX projesindeki **Noise Power Estimator** Verilog modülünün MATLAB golden reference implementasyonunu içerir.

## 📁 Dosyalar

- **`noise_power_estimator.m`** - Ana MATLAB fonksiyonu (Verilog `calc_mean.v` referansı)
- **`test_noise_power_estimator.m`** - Kapsamlı test scripti
- **`README.md`** - Bu dosya

## �� Amaç

Bu MATLAB modülü şu amaçlarla geliştirilmiştir:

1. **Golden Reference**: Verilog implementasyonun doğruluğunu test etmek
2. **Algorithm Verification**: Gürültü gücü tahmin algoritmasını doğrulamak
3. **Simulation**: MATLAB ortamında OFDM receiver simülasyonu yapmak
4. **Integration**: Diğer MATLAB OFDM modülleri ile birlikte çalışabilme

## 🔧 Verilog Referansları

Bu modül aşağıdaki Verilog dosyalarının birebir MATLAB karşılığıdır:

```
openwifi-hw/ip/openofdm_rx/verilog/
├── calc_mean.v         (Ana implementasyon)
└── equalizer.v         (S_SECOND_LTS state - gürültü gücü tahmini)
```

## 📊 Teori - Noise Power Estimation

### Matematiksel Model

İki ardışık Long Training Symbol (LTS) kullanılarak gürültü gücü tahmin edilir:

```
LTS1 = H·X + N₁
LTS2 = H·X + N₂

Δ = LTS2 - LTS1 = N₂ - N₁

σ² ≈ E[|Δ|²] / 2
```

**Notasyon:**
- `H`: Kanal katsayısı (iki LTS arasında sabit)
- `X`: Bilinen LTS sinyali
- `N₁, N₂`: Gürültü örnekleri (i.i.d.)
- `E[·]`: Beklenen değer (64 örnek üzerinden ortalama)
- `σ²`: Gürültü gücü

### Pipeline İşleme (calc_mean.v)

```
Clock Cycle 1: aa = lts1 >> 1,  bb = lts2 >> 1
Clock Cycle 2: cc = aa + bb
Clock Cycle 3: c = sign ? -cc : cc
Clock Cycle 4: output_strobe = 1
```

**Toplam Pipeline Delay: 3 clock cycle**

### Fixed-Point Format

- **Giriş**: Q15 format (16-bit signed, 15 fractional bits)
  - Aralık: [-32768, 32767]
  - Çözünürlük: 2⁻¹⁵ ≈ 0.0000305

- **İşlem**: Arithmetic right shift, saturated arithmetic
- **Çıkış**: 32-bit unsigned (noise power)

## 🚀 Kullanım

### Temel Kullanım

```matlab
% LTS sinyalleri (64 örnek, int16 format)
N = 64;
lts1_i = int16(randn(N,1) * 5000);
lts1_q = int16(randn(N,1) * 5000);
lts2_i = lts1_i + int16(randn(N,1) * 500);  % + gürültü
lts2_q = lts1_q + int16(randn(N,1) * 500);

% Sign vektörü (LTS reference'dan)
sign_vec = zeros(N, 1);  % veya LTS referans işaretleri

% Fonksiyonu çağır
[noise_power, np_valid, mean_i, mean_q, m_valid] = ...
    noise_power_estimator(lts1_i, lts1_q, lts2_i, lts2_q, sign_vec, 1);

% Sonuçları göster
avg_noise_power = mean(double(noise_power(np_valid)));
fprintf('Ortalama Gürültü Gücü: %.2f\n', avg_noise_power);
```

### Test Scripti Çalıştırma

```matlab
>> test_noise_power_estimator
```

Bu script şu testleri yapar:
1. ✅ Basit test (bilinen değerlerle)
2. ✅ IEEE 802.11 LTS sekansı testi
3. ✅ Farklı SNR seviyeleri (0-30 dB)
4. ✅ Fixed-point overflow/saturation
5. ✅ Sıfır giriş testi
6. ✅ Sign işareti testi
7. ✅ Büyük veri seti performans testi
8. ✅ Görselleştirme (SNR vs tahmin)

## 📈 Giriş/Çıkış Özellikleri

### Girişler

| Parametre | Tip | Boyut | Açıklama |
|-----------|-----|-------|----------|
| `lts1_i` | int16 | [Nx1] | İlk LTS I bileşeni |
| `lts1_q` | int16 | [Nx1] | İlk LTS Q bileşeni |
| `lts2_i` | int16 | [Nx1] | İkinci LTS I bileşeni |
| `lts2_q` | int16 | [Nx1] | İkinci LTS Q bileşeni |
| `sign_vec` | logical | [Nx1] | LTS referans işaretleri (0 veya 1) |
| `clk_enable` | logical | scalar | Clock enable (1=aktif, 0=pasif) |

### Çıkışlar

| Parametre | Tip | Boyut | Açıklama |
|-----------|-----|-------|----------|
| `noise_power` | uint32 | [Nx1] | Tahmin edilen gürültü gücü |
| `noise_power_valid` | logical | [Nx1] | Noise power çıkışı geçerlilik biti |
| `mean_i` | int16 | [Nx1] | Ortalama I: (LTS1+LTS2)/2 |
| `mean_q` | int16 | [Nx1] | Ortalama Q: (LTS1+LTS2)/2 |
| `mean_valid` | logical | [Nx1] | Ortalama çıkışı geçerlilik biti |

## 🔍 Verilog ile Karşılaştırma

### calc_mean.v Modülü

```verilog
module calc_mean (
    input clock,
    input enable,
    input reset,
    input signed [15:0] a,          // lts1
    input signed [15:0] b,          // lts2
    input sign,                      // işaret kontrolü
    input input_strobe,
    output reg signed [15:0] c,     // mean output
    output reg output_strobe
);
```

**MATLAB Eşdeğeri:**
```matlab
[noise_power, np_valid, mean_i, mean_q, m_valid] = ...
    noise_power_estimator(lts1_i, lts1_q, lts2_i, lts2_q, sign_vec, clk_enable);
```

### Doğruluk Kriterleri

✅ **Bit-exact**: Her clock cycle için Verilog ile aynı sonuç  
✅ **Pipeline delay**: 3 clock cycle gecikme korunur  
✅ **Overflow handling**: Saturated arithmetic uygulanır  
✅ **Sign handling**: Two's complement negation doğru çalışır

## 📚 IEEE 802.11 Standart Referansları

- **IEEE 802.11-2012**, Section 20.3.9.4.2: Channel Estimation
- **IEEE 802.11-2012**, Section 20.3.9.4.3: Channel Smoothing
- **Long Training Field (LTF)**: 64 subcarrier, 2 symbols

## 🔗 Diğer Modüllerle Entegrasyon

Bu modül, OFDM RX zincirinde şu modüllerle birlikte çalışır:

```
[Sync Short] → [Sync Long] → [FFT] → [Equalizer]
                                          ↓
                            [Noise Power Estimator] ← Bu modül
                                          ↓
                                  [Demodulator]
```

**Önceki Modül**: Channel Estimator (Equalizer)  
**Sonraki Modül**: Soft-Decision Demodulator (opsiyonel)

## 📝 Notlar

1. **Fixed-Point Hassasiyet**: 
   - Bu implementasyon tam olarak Verilog'daki fixed-point aritmetiği taklit eder
   - Floating-point hesaplamalar kullanılmaz

2. **Pipeline Timing**: 
   - İlk 2-3 çıkış invalid olacaktır (pipeline fill-up)
   - `*_valid` çıkışlarını kontrol edin

3. **Sign Vektörü**: 
   - IEEE 802.11 LTS referansından gelir (1, -1, 1, 1, -1, ...)
   - 0 = pozitif, 1 = negatif

4. **Performans**: 
   - 10,000 örnek için ~100ms (Intel i7)
   - Vectorized operations kullanır

## 🐛 Hata Ayıklama

### Sık Karşılaşılan Sorunlar

**Problem**: "lts1_i int16 tipinde olmalı" hatası  
**Çözüm**: 
```matlab
lts1_i = int16(lts1_i);  % double'dan int16'ya dönüştür
```

**Problem**: Noise power çok yüksek/düşük  
**Çözüm**: 
- Girişlerin Q15 formatına uygun olduğundan emin olun
- Aralık: [-32768, 32767]
- Ölçekleme: `value * 2^15` (normalize edilmiş değerler için)

**Problem**: Valid çıkışları yok  
**Çözüm**: 
- `clk_enable = 1` olmalı
- Pipeline delay sonrası çıkışlar gelir (3+ samples)

## 📞 Destek

Bu modül hakkında sorularınız için:
- GitHub Issues: [openwifi-hw repository]
- E-posta: [proje yöneticisi]

## 📄 Lisans

Bu kod, OpenOFDM RX projesi ile aynı lisansa tabidir.

---

**Son Güncelleme**: 31 Ocak 2026  
**Versiyon**: 1.0  
**Yazar**: MATLAB Referans Model Generator
