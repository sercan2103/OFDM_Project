# Fine CFO Estimator - MATLAB Referans Modeli

## GENEL BAKIŞ

Bu dizin, OpenWiFi projesindeki `sync_long.v` Verilog modülünün **Fine CFO (Carrier Frequency Offset) Düzeltme** algoritmasının birebir MATLAB implementasyonunu içerir.

**Amaç:**
- Verilog donanım implementasyonunun golden reference modeli olarak kullanılmak
- Fixed-point aritmetik davranışını tam olarak taklit etmek
- Diğer MATLAB modülleri ile entegre çalışabilmek

## DOSYALAR

```
Fine_CFO_Estimator/
├── fine_cfo_correction.m       : Ana Fine CFO düzeltme fonksiyonu
├── rotate_fixed_point.m        : Fixed-point faz rotasyon fonksiyonu
├── test_fine_cfo_estimator.m   : Test script'i ve doğrulama
└── README.md                   : Bu dosya
```

## FONKSİYON AÇIKLAMALARI

### 1. `fine_cfo_correction.m`

**Amaç:** Her OFDM örneği için fine CFO düzeltmesi yapar.

**Girişler:**
- `samples_in` : Kompleks örnekler (Nx2 matris: [I, Q])
- `phase_offset` : sync_short'tan gelen 16-bit signed faz ofseti
- `short_gi` : Guard Interval tipi (false=Long GI:16, true=Short GI:8)
- `num_ofdm_symbol_in` : Mevcut OFDM sembol sayısı (16-bit)
- `phase_correction_in` : Başlangıç faz düzeltme değeri (32-bit signed)

**Çıkışlar:**
- `samples_out` : Faz düzeltilmiş kompleks örnekler (Nx2 matris)
- `phase_correction_out` : Güncellenmiş faz düzeltme değeri
- `num_ofdm_symbol_out` : Güncellenmiş OFDM sembol sayısı

**Verilog Referansı:** `sync_long.v` (satır 382-427)

**Örnek Kullanım:**
```matlab
samples = [100+50i; 200-30i; ...];
phase_offset = int16(100);
short_gi = false;
[samples_corrected, phase_corr, sym_count] = ...
    fine_cfo_correction(samples, phase_offset, short_gi, 0, 0);
```

### 2. `rotate_fixed_point.m`

**Amaç:** Kompleks sayıyı verilen faz kadar döndürür (fixed-point).

**Girişler:**
- `in_i` : 16-bit signed I bileşeni
- `in_q` : 16-bit signed Q bileşeni
- `phase` : 16-bit signed faz değeri [-PI, PI] (ölçeklenmiş)

**Çıkışlar:**
- `out_i` : 16-bit signed döndürülmüş I bileşeni
- `out_q` : 16-bit signed döndürülmüş Q bileşeni

**Verilog Referansı:** `rotate.v` (satır 1-164)

**Örnek Kullanım:**
```matlab
[out_i, out_q] = rotate_fixed_point(int16(1000), int16(500), int16(400));
```

### 3. `test_fine_cfo_estimator.m`

**Amaç:** Fonksiyonların doğruluğunu test eder ve görselleştirme sağlar.

**Test Senaryoları:**
1. Basit faz rotasyonu testi
2. Negatif phase offset testi
3. Pozitif/Negatif faz wrapping testi
4. Long GI düzeltme testi
5. Short GI düzeltme testi
6. Rotate fonksiyon testi
7. Faz düzeltme görselleştirmesi

**Çalıştırma:**
```matlab
run test_fine_cfo_estimator.m
```

## ALGORİTMA DETAYLARI

### Fine CFO Düzeltme Prensibi

Fine CFO düzeltmesi, alıcı ve verici arasındaki kalan (residual) frekans ofsetini kompanze eder:

1. **Faz Rotasyonu:**
   ```
   sample_out = sample_in * exp(j * phase_correction)
   ```

2. **Faz Güncelleme:**
   ```
   phase_correction(n+1) = phase_correction(n) + phase_offset
   ```

3. **Guard Interval Düzeltme:**
   - Long GI (16 sample): `extra_correction = phase_offset << 4`
   - Short GI (8 sample): `extra_correction = phase_offset << 3`

4. **Faz Wrapping:**
   ```
   if phase_correction > PI:
       phase_correction = phase_correction - 2*PI
   if phase_correction < -PI:
       phase_correction = phase_correction + 2*PI
   ```

### Fixed-Point Parametreleri

```
PI = 1608                     (ATAN_LUT_SCALE_SHIFT = 9)
DOUBLE_PI = 3216
ROTATE_LUT_SCALE_SHIFT = 14   (sin/cos değerleri için)
ROTATE_LUT_LEN_SHIFT = 9      (LUT boyutu = 512)
```

## VERİLOG KODU İLE KARŞILAŞTIRMA

Bu MATLAB implementasyonu aşağıdaki Verilog modüllerini taklit eder:

| Verilog Modülü | MATLAB Fonksiyonu | Satır Referansı |
|---------------|-------------------|----------------|
| `sync_long.v` | `fine_cfo_correction.m` | 382-427 |
| `rotate.v` | `rotate_fixed_point.m` | 1-164 |
| `complex_mult.v` | İçeride (rotate içinde) | - |
| `rot_lut` ROM | `load_rotate_lut()` | - |

## ÖZEL NOTLAR

### 1. Fixed-Point Aritmetik

MATLAB'da integer tiplerle çalışılır:
```matlab
phase_offset = int16(value);      % 16-bit signed
phase_correction = int32(value);  % 32-bit signed
```

### 2. LUT Yükleme

Rotate LUT'u 3 yöntemle yüklenebilir:
1. `rot_lut.mif` dosyasından okuma (öncelik)
2. `rot_lut.coe` dosyasından okuma
3. Analitik olarak oluşturma (fallback)

LUT dosyaları şu konumda aranır:
```
/home/kemal/Desktop/New_Folder/openwifi-hw/ip/openofdm_rx/verilog/
```

### 3. Bit Operasyonları

Verilog'daki bit-shift operasyonları MATLAB'da:
```matlab
% Verilog: value << 3
matlab_value = bitshift(value, 3);

% Verilog: value >> 4
matlab_value = bitshift(value, -4);
```

## KULLANIM ÖRNEKLERİ

### Örnek 1: Basit Kullanım

```matlab
% Parametreler
samples = complex(randn(64,1)*1000, randn(64,1)*1000);
phase_offset = int16(50);
short_gi = false;

% İlk çağrı
[samples_out, phase_corr, num_sym] = fine_cfo_correction(...
    samples, phase_offset, short_gi, 0, 0);

% İkinci çağrı (state'i koru)
samples2 = complex(randn(64,1)*1000, randn(64,1)*1000);
[samples_out2, phase_corr2, num_sym2] = fine_cfo_correction(...
    samples2, phase_offset, short_gi, num_sym, phase_corr);
```

### Örnek 2: Verilog Doğrulama

```matlab
% Verilog simülasyonundan test vektörleri yükle
verilog_input = load('verilog_input.mat');
verilog_output = load('verilog_output.mat');

% MATLAB modelini çalıştır
[matlab_output, ~, ~] = fine_cfo_correction(...
    verilog_input.samples, ...
    verilog_input.phase_offset, ...
    verilog_input.short_gi, ...
    verilog_input.num_ofdm_symbol, ...
    verilog_input.phase_correction);

% Karşılaştır
max_error = max(abs([matlab_output(:,1) - verilog_output.I, ...
                     matlab_output(:,2) - verilog_output.Q]));
fprintf('Maksimum hata: %d\n', max_error);
assert(max_error < 2, 'Verilog ile uyumsuzluk!');
```

## DEĞİŞİKLİK GEÇMİŞİ

- **v1.0** (2026-01-31): İlk sürüm
  - `fine_cfo_correction.m` oluşturuldu
  - `rotate_fixed_point.m` eklendi
  - Kapsamlı test suite eklendi

## LİSANS

Bu kod, OpenWiFi projesi ile aynı lisansa tabidir.

## İLETİŞİM

Sorularınız için:
- OpenWiFi GitHub: https://github.com/open-sdr/openwifi
- Issue tracker: https://github.com/open-sdr/openwifi/issues

## REFERANSLAR

1. OpenWiFi Verilog Kodu: `openwifi-hw/ip/openofdm_rx/verilog/sync_long.v`
2. IEEE 802.11-2016 Standardı
3. "OFDM Baseband Receiver Design for Wireless Communications" - Tzi-Dar Chiueh

---
**Son Güncelleme:** 2026-01-31  
**Yazar:** GitHub Copilot (MATLAB Referans Model Oluşturma)
