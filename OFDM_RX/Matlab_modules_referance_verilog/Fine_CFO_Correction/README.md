# Fine CFO Correction - MATLAB Golden Reference Model

Bu dizin, Verilog `rotate.v` modülünün **Fine CFO (Carrier Frequency Offset) Correction** işlevinin MATLAB referans implementasyonunu içerir.

## 📋 İçindekiler

- `fine_cfo_correction.m` - Ana fonksiyon (Golden reference model)
- `load_rotation_lut.m` - Rotasyon LUT yükleme fonksiyonu
- `test_fine_cfo_correction.m` - Kapsamlı test suite
- `README.md` - Bu dosya

## 🎯 Amaç

Bu modül şu amaçlarla oluşturulmuştur:

1. **Verilog Doğrulama**: `rotate.v` modülünün davranışını bit-accurate olarak doğrular
2. **Golden Reference**: Verilog simülasyonları için referans çıktı sağlar
3. **Algoritma Analizi**: CFO düzeltme algoritmasını MATLAB'da analiz etmeye olanak verir
4. **Entegrasyon**: Diğer OFDM alıcı modülleri ile birlikte çalışabilir

## 🔧 Fine CFO Correction Nedir?

**Fine CFO Correction**, WiFi OFDM alıcısında ince (fine) taşıyıcı frekans offset düzeltmesi yapar:

```
                    ┌─────────────────────┐
   I/Q Samples  --->│                     │
                    │  Fine CFO           │---> Corrected I/Q
   Phase Offset --->│  Correction         │
                    │  (Phase Rotation)   │
   LUT Data     --->│                     │
                    └─────────────────────┘
```

### İşleyiş

1. **Giriş**: 
   - I/Q örnekleri (16-bit signed)
   - Phase correction değeri (16-bit signed, [-π, π] scaled)
   - Sin/Cos LUT tablosu

2. **İşlem**:
   - Phase değerinden quadrant belirleme
   - LUT'tan sin/cos değerleri okuma
   - Kompleks çarpım ile faz rotasyonu: `(I + jQ) × (cos + j×sin)`

3. **Çıkış**:
   - Düzeltilmiş I/Q örnekleri (16-bit signed)

### Matematiksel İfade

```
out_i = (in_i × cos(θ) - in_q × sin(θ)) / 2^11
out_q = (in_i × sin(θ) + in_q × cos(θ)) / 2^11
```

Burada `θ = phase_correction / 2^9` (radyan cinsinden).

## 📊 Verilog ile Uyumluluk

Bu MATLAB modeli şu Verilog modülleri ile **bit-accurate** uyumludur:

| Verilog Modülü | Dosya Yolu | Fonksiyon |
|----------------|------------|-----------|
| `rotate.v` | `openofdm_rx/verilog/rotate.v` | Faz rotasyon (Ana modül) |
| `complex_mult.v` | `openofdm_rx/verilog/complex_mult.v` | Kompleks çarpım |
| `sync_long.v` | `openofdm_rx/verilog/sync_long.v` | CFO düzeltmesi (kullanım örneği) |

### Sabit Parametreler

Verilog'daki parametreler (`common_defs.v` ve `common_params.v`):

```verilog
`define ATAN_LUT_SCALE_SHIFT    9
`define ROTATE_LUT_SCALE_SHIFT  11
localparam PI = 1608;  // π × 2^9
```

MATLAB'da aynı değerler kullanılır:

```matlab
ATAN_LUT_SCALE_SHIFT = 9;
ROTATE_LUT_SCALE_SHIFT = 11;
PI = 1608;
```

## 🚀 Kullanım

### Temel Kullanım

```matlab
% 1. LUT'u yükle
rot_lut = load_rotation_lut();

% 2. Örnek veriler hazırla (16-bit signed fixed-point)
in_i = fi([1000, 2000, 3000], 1, 16, 0);
in_q = fi([500, 1000, 1500], 1, 16, 0);
phase = fi([100, 200, 300], 1, 16, 0);

% 3. Fine CFO Correction uygula
[out_i, out_q, debug_info] = fine_cfo_correction(in_i, in_q, phase, rot_lut);

% 4. Sonuçları görüntüle
plot(double(out_i), double(out_q), 'o');
xlabel('I'); ylabel('Q');
title('Corrected Constellation');
```

### Test Suite Çalıştırma

```matlab
% Tüm testleri çalıştır
test_fine_cfo_correction
```

Test suite şunları içerir:
- ✅ Basit sinyal testi
- ✅ Rastgele I/Q örnekleri
- ✅ Farklı faz offsetleri (0°, ±45°, ±90°, ±135°, 180°)
- ✅ Sınır değerleri (overflow/underflow kontrolü)
- ✅ Performans testi

### Diğer Modüllerle Entegrasyon

```matlab
% Fine CFO Estimation modülünden gelen phase_offset kullanımı
estimated_phase_offset = 250;  % Fine CFO Estimation'dan

% Her örnek için birikimli faz (Verilog'daki gibi)
num_samples = 64;
phase_accum = fi(zeros(num_samples, 1), 1, 16, 0);
for idx = 1:num_samples
    phase_accum(idx) = fi(estimated_phase_offset * idx, 1, 16, 0);
end

% CFO düzeltmesi uygula
[corrected_i, corrected_q] = fine_cfo_correction(data_i, data_q, phase_accum, rot_lut);
```

## 📁 Giriş/Çıkış Formatları

### Girişler

| Parametre | Tip | Açıklama |
|-----------|-----|----------|
| `in_i` | `fi(1,16,0)` | I bileşeni örnekleri (16-bit signed) |
| `in_q` | `fi(1,16,0)` | Q bileşeni örnekleri (16-bit signed) |
| `phase_correction` | `fi(1,16,0)` | Faz düzeltme değerleri ([-π,π] × 2^9) |
| `rot_lut` | `struct` | LUT tablosu (`.cos_lut`, `.sin_lut`) |

### Çıkışlar

| Parametre | Tip | Açıklama |
|-----------|-----|----------|
| `out_i` | `fi(1,16,0)` | Düzeltilmiş I bileşeni |
| `out_q` | `fi(1,16,0)` | Düzeltilmiş Q bileşeni |
| `debug_info` | `struct` | Debug bilgileri (opsiyonel) |

### Debug Info İçeriği

```matlab
debug_info.phase_abs      % Faz mutlak değeri
debug_info.quadrant       % Quadrant numarası (0-7)
debug_info.actual_phase   % Normalize edilmiş faz
debug_info.rot_i          % Cos değeri (LUT'tan)
debug_info.rot_q          % Sin değeri (LUT'tan)
debug_info.lut_addr       % LUT adresi
```

## 🔬 Verilog ile Karşılaştırma

### Pipeline Mimarisi

**Verilog (`rotate.v`):**
```
Cycle 1: Phase absolute value
Cycle 2: Quadrant determination
Cycle 3: LUT read
Cycle 4: Quadrant correction
Cycle 5+: Complex multiplication (6 cycles)
Total: ~10 cycles
```

**MATLAB:**
MATLAB modeli aynı işlem sırasını taklit eder ancak pipeline yoktur (her örnek sıralı işlenir).

### Fixed-Point Aritmetik

Her iki implementasyon da **aynı fixed-point formatı** kullanır:

- **I/Q örnekleri**: 16-bit signed, integer (Q0 format)
- **Phase**: 16-bit signed, integer (π × 2^9 scaled)
- **LUT değerleri**: 16-bit signed, integer (cos/sin × 2^11 scaled)
- **Çarpım sonuçları**: 32-bit signed → 16-bit'e scale edilir

### Bit-Accurate Doğrulama

MATLAB ve Verilog sonuçları **aynı input için aynı output** üretir:

```matlab
% Verilog testbench'inden gelen değerler
verilog_in_i = 1234;
verilog_in_q = -567;
verilog_phase = 300;

% MATLAB ile hesapla
[matlab_out_i, matlab_out_q] = fine_cfo_correction(...
    fi(verilog_in_i, 1, 16, 0), ...
    fi(verilog_in_q, 1, 16, 0), ...
    fi(verilog_phase, 1, 16, 0), ...
    rot_lut);

% Verilog sonuçları ile karşılaştır
assert(double(matlab_out_i) == verilog_expected_i);
assert(double(matlab_out_q) == verilog_expected_q);
```

## 📚 Algoritma Detayları

### 1. Quadrant Belirleme

Faz değeri `[-π, π]` aralığında 8 quadrant'a bölünür:

| Quadrant | Faz Aralığı | İşaret |
|----------|-------------|--------|
| 0 | [0, π/4] | Pozitif |
| 1 | [π/4, π/2] | Pozitif |
| 2 | [π/2, 3π/4] | Pozitif |
| 3 | [3π/4, π] | Pozitif |
| 4 | [0, -π/4] | Negatif |
| 5 | [-π/4, -π/2] | Negatif |
| 6 | [-π/2, -3π/4] | Negatif |
| 7 | [-3π/4, -π] | Negatif |

### 2. LUT Organizasyonu

- **LUT Boyutu**: 512 entry (9-bit adres)
- **Entry Formatı**: 32-bit = [cos(16-bit) | sin(16-bit)]
- **Kapsanan Aralık**: [0, π/4] (diğer quadrantlar simetri ile hesaplanır)

### 3. Kompleks Çarpım

```
out = (in_i + j×in_q) × (cos(θ) + j×sin(θ))

out_i = in_i × cos(θ) - in_q × sin(θ)
out_q = in_i × sin(θ) + in_q × cos(θ)
```

Verilog'da Xilinx `complex_multiplier` IP core kullanılır.

## 🧪 Test Senaryoları

### Test 1: Basit Sinyal
- Saf sinüs dalgası
- Sabit faz düzeltmesi
- Constellation plot ile görselleştirme

### Test 2: Rastgele Örnekler
- 64 örneklik rastgele I/Q
- Rastgele faz düzeltmeleri
- Overflow kontrolü

### Test 3: Faz Açıları
- 0°, ±45°, ±90°, ±135°, 180°
- Her açı için beklenen rotasyon
- Constellation diagram

### Test 4: Sınır Değerleri
- Maximum/minimum I/Q değerleri
- Overflow/underflow testi
- Saturation kontrolü

### Test 5: Entegrasyon
- Fine CFO Estimation ile birlikte
- Birikimli faz düzeltmesi (OFDM sembolü boyunca)
- 64-sample OFDM sembol testi

## 🛠️ Geliştirme Notları

### Fixed-Point Conversion

MATLAB'da `fi` (fixed-point) objesi kullanılır:

```matlab
T_16bit = numerictype(1, 16, 0);  % Signed, 16-bit, 0 fraction
data = fi(values, T_16bit);
```

### LUT Yükleme

LUT iki şekilde yüklenebilir:

1. **Verilog dosyasından** (`rot_lut.coe` veya `rot_lut.mif`)
2. **Matematiksel oluşturma** (dosya yoksa otomatik)

### Performans

MATLAB implementasyonu:
- ~100 μs/sample (interpretive mode)
- Verilog: ~50 ns/sample @ 20 MHz clock

## 📖 Referanslar

### Verilog Dosyaları

```
/home/kemal/Desktop/New_Folder/openwifi-hw/ip/openofdm_rx/verilog/
├── rotate.v              # Ana rotasyon modülü
├── complex_mult.v        # Kompleks çarpım
├── sync_long.v           # CFO düzeltmesi kullanım örneği
├── common_defs.v         # Sabit tanımları
├── common_params.v       # Parametreler
└── rot_lut.coe           # Rotasyon LUT dosyası
```

### İlgili Modüller

- **Fine CFO Estimation**: Faz offsetini tahmin eder (bu modül sadece düzeltme yapar!)
- **Sync Long**: LTS senkronizasyonu ve CFO düzeltmesi birlikte
- **FFT**: CFO düzeltmesinden sonra FFT işlemi

## ⚠️ Önemli Notlar

1. **Bu modül CFO tahmini yapmaz!** Sadece verilen phase_offset'i kullanarak düzeltme yapar.
2. **Fine CFO Estimation** modülünden gelen `phase_offset` değeri gereklidir.
3. **Fixed-point aritmetik** kullanılır - floating-point değil!
4. **LUT tablosu** mutlaka yüklenmelidir (`load_rotation_lut()`).
5. **Verilog ile bit-accurate** uyumlu - test edilmiştir.

## 📞 İletişim ve Destek

Sorular veya sorunlar için:
- Verilog referans: `rotate.v`, `complex_mult.v`, `sync_long.v`
- MATLAB fonksiyonlar: `fine_cfo_correction.m`, `load_rotation_lut.m`
- Test dosyası: `test_fine_cfo_correction.m`

## 📄 Lisans

Bu referans model, orijinal Verilog kodu ile aynı lisansa tabidir (openwifi-hw projesi).

---

**Son Güncelleme**: 2026-02-19  
**Versiyon**: 1.0  
**Durum**: ✅ Test Edildi ve Doğrulandı
