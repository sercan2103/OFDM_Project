# DOT11.V MATLAB FIXED-POINT BLOK LİSTESİ

OpenOFDM IEEE 802.11a/g/n Receiver (dot11.v) top modülünü MATLAB fixed-point formatında implement etmek için gereken blokların detaylı listesi.

---

## GENEL MİMARİ

```
Sample In (I/Q) → Power Trigger → Sync Short → Sync Long → Equalizer → OFDM Decoder → Byte Out
                                                              ↓
                                                         State Machine
                                                    (15 State, FSM kontrol)
```

---

## KATMAN 0: TEMEL ARITMETIK BLOKLAR (7 Blok)

### 1. **ARITHMETIC_RIGHT_SHIFT**
- **Verilog Karşılığı**: `>>>` operatörü
- **İşlev**: İşaretli sağa kaydırma (MSB korunur)
- **Fixed-Point**: int16 → int16
- **Kullanım**: calc_mean, tüm pipeline'larda

### 2. **SATURATE_ADD**
- **Verilog Karşılığı**: Overflow kontrolü ile toplama
- **İşlev**: Taşma durumunda max/min değere kırpma
- **Fixed-Point**: int16 + int16 → int16
- **Kullanım**: calc_mean, moving_avg

### 3. **SATURATE_MULTIPLY**
- **Verilog Karşılığı**: Çarpma ile genişleme ve saturation
- **İşlev**: int16 × int16 → int32 (veya scale ile int16)
- **Fixed-Point**: Q15 × Q15 → Q30 (scale: Q15)
- **Kullanım**: complex_mult, magnitude hesaplamaları

### 4. **NEGATE_INT16**
- **Verilog Karşılığı**: `~value + 1` (2's complement)
- **İşlev**: İşaret değiştirme
- **Fixed-Point**: int16 → int16
- **Kullanım**: Konjuge alma, negatif çarpma

### 5. **RAM_2PORT**
- **Verilog Karşılığı**: `ram_2port.v` (dual-port RAM)
- **İşlev**: İki portlu bellek (read/write aynı anda)
- **Fixed-Point**: Address: 6-bit, Data: 32-bit [I, Q]
- **Kullanım**: LTS buffer, input buffer (equalizer)

### 6. **BITSHIFT_LEFT/RIGHT**
- **Verilog Karşılığı**: `<<` ve `>>` operatörleri
- **İşlev**: Sabit kaydırma (scaling için)
- **Fixed-Point**: uint32 << N veya >> N
- **Kullanım**: Noise power, scaling işlemleri

### 7. **LOOKUP_TABLE**
- **Verilog Karşılığı**: ROM (COE/MIF dosyaları)
- **İşlev**: Sabit değer tablosu (sin/cos, rotation, deinterleave)
- **Fixed-Point**: Address: 9-bit, Data: 32-bit [sin, cos]
- **Kullanım**: rot_lut, atan_lut, deinter_lut

---

## KATMAN 1: COMPLEX ARITMETIK (6 Blok)

### 8. **COMPLEX_MULT**
- **Verilog**: `complex_mult.v`
- **İşlev**: (a_i + ja_q) × (b_i + jb_q) = (a_i×b_i - a_q×b_q) + j(a_i×b_q + a_q×b_i)
- **Fixed-Point**: int16 × int16 → int32
- **Pipeline**: 3 clock cycle
- **Kullanım Yeri**: equalizer (pilot, LTS çarpımları), sync_long

### 9. **COMPLEX_TO_MAG_SQ**
- **Verilog**: `complex_to_mag_sq.v`
- **İşlev**: |z|² = I² + Q²
- **Fixed-Point**: int16 → uint32
- **Pipeline**: 2 clock cycle
- **Kullanım**: Power trigger, sync metrics

### 10. **COMPLEX_TO_MAG**
- **Verilog**: `complex_to_mag.v`
- **İşlev**: |z| = √(I² + Q²)
- **Fixed-Point**: int16 → uint16
- **Pipeline**: CORDIC iterasyonu
- **Kullanım**: Demodulator (soft decision)

### 11. **ROTATE**
- **Verilog**: `rotate.v`
- **İşlev**: CFO correction - z × e^(jθ)
- **Fixed-Point**: int16 × rot_lut[θ] → int16
- **Pipeline**: 4 clock cycle
- **Kullanım**: sync_long (coarse CFO), equalizer (fine CFO)
- **Bağımlılık**: rot_lut (512 entry, sin/cos LUT)

### 12. **PHASE**
- **Verilog**: `phase.v`
- **İşlev**: θ = atan2(Q, I)
- **Fixed-Point**: int32 (I,Q) → int32 (phase)
- **Pipeline**: CORDIC + atan_lut
- **Kullanım**: sync_short (coarse phase), equalizer (pilot phase)
- **Bağımlılık**: atan_lut (256 entry)

### 13. **DIVIDER**
- **Verilog**: `divider.v` (veya `div_gen_v3_0.v`)
- **İşlev**: Tam sayı bölme (dividend / divisor)
- **Fixed-Point**: int32 / uint24 → int32
- **Pipeline**: ~18 clock cycle
- **Kullanım**: equalizer (normalization: Y/H)

---

## KATMAN 2: SİNYAL İŞLEME BLOKLARI (8 Blok)

### 14. **POWER_TRIGGER**
- **Verilog**: `power_trigger.v`
- **İşlev**: Sinyal gücü eşik algılama (packet başlangıcı)
- **Fixed-Point**: int16 → trigger (boolean)
- **Hesaplama**: Moving average of |sample|²
- **Parametre**: Eşik değeri (set_data ile ayarlanabilir)
- **Pipeline**: 8 sample window

### 15. **SYNC_SHORT**
- **Verilog**: `sync_short.v`
- **İşlev**: Short preamble (STS) algılama, coarse CFO/phase tahmini
- **Fixed-Point**: int16 → detect (boolean), phase_offset (int32)
- **Hesaplama**: 
  - Cross-correlation (16 sample delay autocorrelation)
  - Metric = |sum(conj(s[n]) × s[n+16])|² / (sum|s[n]|² × sum|s[n+16]|²)
  - Eşik: metric > threshold
- **Pipeline**: ~20 clock cycle
- **Bağımlılık**: phase.v (atan2), moving_avg, complex_to_mag_sq

### 16. **SYNC_LONG**
- **Verilog**: `sync_long.v`
- **İşlev**: Long preamble (LTS) algılama, coarse CFO correction
- **Fixed-Point**: int16 → detect (boolean), corrected samples (int16)
- **Hesaplama**:
  - Cross-correlation with known LTS pattern
  - Metric peak detection
  - Rotation (CFO correction)
- **Pipeline**: ~30 clock cycle
- **Bağımlılık**: rotate.v, rot_lut, complex_mult
- **State Machine**: 4 states (IDLE, DETECT, SYNC, OUTPUT)

### 17. **CALC_MEAN**
- **Verilog**: `calc_mean.v`
- **İşlev**: İki LTS sinyalinin ortalaması (CSI için)
- **Fixed-Point**: int16 → int16
- **Hesaplama**: mean = sign ? -(a>>>1 + b>>>1) : (a>>>1 + b>>>1)
- **Pipeline**: 3 clock cycle
- **Kullanım**: equalizer (S_SECOND_LTS state)

### 18. **MOVING_AVG**
- **Verilog**: `moving_avg.v`
- **İşlev**: Hareketli ortalama filtre
- **Fixed-Point**: int32 → int32
- **Hesaplama**: avg[n] = (sum of last N samples) / N
- **Window**: 8 veya 16 sample
- **Kullanım**: power_trigger, sync_short

### 19. **DELAY_SAMPLE / DELAYT**
- **Verilog**: `delay_sample.v`, `delayT.v`
- **İşlev**: Pipeline delay (register chain)
- **Fixed-Point**: int16/int32 → int16/int32
- **Delay**: Configurable (1-128 clock cycle)
- **Kullanım**: Pipeline alignment (equalizer'da 6 cycle delay)

### 20. **EQUALIZER**
- **Verilog**: `equalizer.v`
- **İşlev**: Kanal eşitleme (CSI estimation + zero-forcing)
- **Fixed-Point**: int16 → int16
- **State Machine**: 6 states
  - S_FIRST_LTS: İlk LTS'yi kaydet
  - S_SECOND_LTS: İki LTS'nin ortalamasını al (CSI)
  - S_GET_POLARITY: Pilot polarity hazırla
  - S_CALC_FREQ_OFFSET: Residual CFO hesapla (pilot-based)
  - S_ADJUST_FREQ_OFFSET: CFO correction + equalization (Y/H)
  - S_HT_LTS: HT-LTS işleme (802.11n)
- **Pipeline**: 15+ clock cycle (divider bağımlı)
- **Bağımlılık**: calc_mean, rotate, complex_mult, divider, ram_2port

### 21. **RATE_TO_IDX**
- **Verilog**: `rate_to_idx.v`
- **İşlev**: Rate field → modulation/coding index
- **Fixed-Point**: 8-bit → 3-bit index
- **Mapping**: 
  - 1011 (6 Mbps) → 0
  - 1111 (9 Mbps) → 1
  - 1010 (12 Mbps) → 2
  - ... (MCS 0-7 for HT)
- **Kullanım**: ofdm_decoder

---

## KATMAN 3: OFDM DECODING BLOKLARI (6 Blok)

### 22. **DEMODULATE**
- **Verilog**: `demodulate.v`
- **İşlev**: Soft-decision demodulation (BPSK/QPSK/16QAM/64QAM)
- **Fixed-Point**: int16 → 6-bit soft bits
- **Hesaplama**: 
  - BPSK: 1 bit (sign(I))
  - QPSK: 2 bit (sign(I), sign(Q))
  - 16-QAM: 4 bit (2 I + 2 Q levels)
  - 64-QAM: 6 bit (3 I + 3 Q levels)
- **Pipeline**: 1 clock cycle
- **Kullanım**: ofdm_decoder (ilk stage)

### 23. **DEINTERLEAVE**
- **Verilog**: `deinterleave.v`
- **İşlev**: Frequency deinterleaving (802.11 spec)
- **Fixed-Point**: 2-bit soft → 2-bit reordered
- **Hesaplama**: LUT-based permutation
- **Pipeline**: 1 clock cycle
- **Bağımlılık**: deinter_lut (COE file)
- **Pattern**: 48 veya 52 subcarrier permutation

### 24. **VITERBI**
- **Verilog**: `viterbi.v` (veya `viterbi_v7_0.v` CoreGen)
- **İşlev**: Viterbi decoder (convolutional code R=1/2, K=7)
- **Fixed-Point**: 3-bit soft input → 1-bit hard output
- **Hesaplama**: 
  - Trellis state: 64 states
  - Path metric update
  - Traceback (40-bit depth)
- **Pipeline**: 40+ clock cycle (traceback latency)
- **Puncturing**: Support R=2/3, 3/4 (OFDM rates)
- **Kullanım**: ofdm_decoder (Viterbi stage)

### 25. **DESCRAMBLE**
- **Verilog**: `descramble.v`
- **İşlev**: Scrambler XOR sequence removal
- **Fixed-Point**: 1-bit → 1-bit
- **Hesaplama**: 
  - LFSR: x^7 + x^4 + 1
  - Initial state: all 1s
  - bit_out = bit_in XOR lfsr[6]
- **Pipeline**: 1 clock cycle
- **Kullanım**: ofdm_decoder (son stage)

### 26. **BITS_TO_BYTES**
- **Verilog**: `bits_to_bytes.v`
- **İşlev**: Bit stream → byte packing
- **Fixed-Point**: 1-bit × 8 → 8-bit byte
- **Hesaplama**: Shift register (LSB first)
- **Pipeline**: 8 bit latency
- **Kullanım**: ofdm_decoder output

### 27. **OFDM_DECODER**
- **Verilog**: `ofdm_decoder.v`
- **İşlev**: Tam OFDM decoding pipeline
- **Alt Modüller**: demodulate → deinterleave → viterbi → descramble → bits_to_bytes
- **Fixed-Point**: int16 → 8-bit byte
- **Pipeline**: ~60 clock cycle (end-to-end)
- **Kontrol**: rate, num_bits_to_decode, do_descramble

---

## KATMAN 4: CRC VE KONTROL (3 Blok)

### 28. **CRC32**
- **Verilog**: `crc32.v`
- **İşlev**: FCS (Frame Check Sequence) hesaplama
- **Fixed-Point**: 8-bit byte → 32-bit CRC
- **Hesaplama**: 
  - Polynomial: x^32 + x^26 + x^23 + ... + x^2 + x + 1
  - Initial: 0xFFFFFFFF
  - Final XOR: 0xFFFFFFFF
  - Expected: 0xC704DD7B (correct frame)
- **Pipeline**: 1 byte/cycle (streaming)
- **Kullanım**: dot11 (S_DECODE_DATA state)

### 29. **HT_SIG_CRC**
- **Verilog**: `ht_sig_crc.v`
- **İşlev**: HT-SIG CRC-8 hesaplama
- **Fixed-Point**: 1-bit → 8-bit CRC
- **Hesaplama**: 
  - Polynomial: x^8 + x^2 + x + 1
  - 34-bit input (HT-SIG1 + HT-SIG2[9:0])
- **Pipeline**: 1 bit/cycle
- **Kullanım**: dot11 (S_CHECK_HT_SIG_CRC state)

### 30. **RAND_GEN**
- **Verilog**: `rand_gen.v`
- **İşlev**: LFSR pseudo-random generator (test için)
- **Fixed-Point**: 7-bit LFSR
- **Hesaplama**: x^7 + x^4 + 1
- **Kullanım**: Scrambler initialization (opsiyonel)

---

## KATMAN 5: TOP MODÜL VE STATE MACHINE (1 Blok)

### 31. **DOT11_TOP**
- **Verilog**: `dot11.v`
- **İşlev**: Top-level RX controller (15-state FSM)
- **State Machine**:
  1. **S_WAIT_POWER_TRIGGER**: Güç eşiği bekle
  2. **S_SYNC_SHORT**: STS algılama
  3. **S_SYNC_LONG**: LTS algılama + coarse sync
  4. **S_DECODE_SIGNAL**: SIGNAL field decode (24 bit)
  5. **S_CHECK_SIGNAL**: SIGNAL parity/validity check
  6. **S_DETECT_HT**: HT format detection (rotation check)
  7. **S_HT_SIGNAL**: HT-SIG decode (48 bit)
  8. **S_CHECK_HT_SIG_CRC**: CRC-8 check
  9. **S_CHECK_HT_SIG**: HT-SIG validity check
  10. **S_HT_STS**: HT-STF skip (64 samples)
  11. **S_HT_LTS**: HT-LTF processing (64 samples)
  12. **S_DECODE_DATA**: PSDU decoding
  13. **S_DECODE_DONE**: FCS check, finalize
  14. **S_SIGNAL_ERROR**: SIGNAL error recovery
  15. **S_HT_SIG_ERROR**: HT-SIG error recovery

- **Fixed-Point**: int16 → 8-bit byte + metadata
- **Kontrol Sinyalleri**:
  - `pkt_begin`, `pkt_ht`, `pkt_rate`, `pkt_len`
  - `byte_out`, `byte_out_strobe`
  - `fcs_ok`, `status_code`
- **Error Codes**:
  - E_OK (0): Başarılı
  - E_PARITY_FAIL (1): SIGNAL parity hatası
  - E_WRONG_RSVD (2): Reserved bit hatası
  - E_WRONG_TAIL (3): Tail bit hatası
  - E_WRONG_CRC (4): HT-SIG CRC hatası
  - E_UNSUPPORTED_MCS/CBW/STBC/FEC/SGI (5-9)
  - E_WRONG_FCS (10): Frame FCS hatası

---

## TOPLAM BLOK SAYISI: **31 BLOK**

### KATMAN DİSTRİBÜSYONU:
- **Katman 0** (Temel Aritmetik): 7 blok
- **Katman 1** (Complex Aritmetik): 6 blok
- **Katman 2** (Sinyal İşleme): 8 blok
- **Katman 3** (OFDM Decoding): 6 blok
- **Katman 4** (CRC/Kontrol): 3 blok
- **Katman 5** (Top Modül): 1 blok

---

## ÖNCELİK SIRASI (Implementation Order)

### FASE 1: Temel Bloklar (Hemen gerekli)
1. ARITHMETIC_RIGHT_SHIFT
2. SATURATE_ADD
3. SATURATE_MULTIPLY
4. NEGATE_INT16
5. BITSHIFT_LEFT/RIGHT
6. RAM_2PORT
7. LOOKUP_TABLE

### FASE 2: Complex İşlemler
8. COMPLEX_MULT
9. COMPLEX_TO_MAG_SQ
10. COMPLEX_TO_MAG
11. ROTATE
12. PHASE
13. DIVIDER

### FASE 3: Sync Blokları
14. POWER_TRIGGER
15. MOVING_AVG
16. CALC_MEAN
17. DELAY_SAMPLE
18. SYNC_SHORT
19. SYNC_LONG

### FASE 4: Equalizer
20. EQUALIZER (tüm bağımlılıklar hazır olmalı)

### FASE 5: OFDM Decoder
21. RATE_TO_IDX
22. DEMODULATE
23. DEINTERLEAVE
24. VITERBI
25. DESCRAMBLE
26. BITS_TO_BYTES
27. OFDM_DECODER

### FASE 6: CRC ve Top
28. CRC32
29. HT_SIG_CRC
30. RAND_GEN
31. DOT11_TOP

---

## MATLAB IMPLEMENTASYON NOTLARI

### Fixed-Point Type Definitions
```matlab
% Tüm MATLAB fonksiyonlarında kullanılacak tipler
T_16bit = numerictype(1, 16, 15);  % Signed Q15 (int16)
T_32bit = numerictype(1, 32, 31);  % Signed Q31 (int32)
T_32bit_uns = numerictype(0, 32, 0); % Unsigned uint32
```

### Test Framework
Her blok için şu test senaryoları gerekli:
1. **Unit Test**: Tek başına blok testi (known input → expected output)
2. **Integration Test**: Bir önceki blokla birlikte test
3. **System Test**: Tam dot11 pipeline ile end-to-end test

### Validation
- Verilog simülasyon çıktıları ile karşılaştırma (sample-by-sample)
- Testbench: `dot11_tb.v` → MATLAB equivalent
- Test vektörleri: Gerçek WiFi paketleri (PCAP → I/Q samples)

---

## ZORLUK SEVİYESİ

| Blok | Zorluk | Süre Tahmini |
|------|--------|--------------|
| Temel Aritmetik | ⭐ | 1-2 gün |
| Complex İşlemler | ⭐⭐ | 3-5 gün |
| Sync Blokları | ⭐⭐⭐ | 5-7 gün |
| Equalizer | ⭐⭐⭐⭐ | 7-10 gün |
| OFDM Decoder | ⭐⭐⭐⭐ | 7-10 gün |
| CRC + Top | ⭐⭐⭐ | 5-7 gün |

**TOPLAM TAHMİNİ SÜRE**: ~30-40 gün (full-time çalışma)

---

## EK DOSYALAR GEREKLİ

### LUT Dosyaları (COE/MIF)
- `rot_lut.coe`: 512-entry sin/cos rotation table
- `atan_lut.coe`: 256-entry arctan lookup
- `deinter_lut.coe`: Deinterleaver permutation table

### Test Vektörleri
- WiFi capture dosyaları (.pcap veya .bin)
- Known-good reference outputs (Verilog simulation dumps)

### Dokümantasyon
- IEEE 802.11-2016 Standard (PHY layer spec)
- Verilog module documentation (VERILOG_MODULE_DOCUMENTATION.md)

---

## SONUÇ

Bu liste **dot11.v top modülünü MATLAB fixed-point formatında tam olarak implement etmek** için gereken tüm blokları içerir. Toplam **31 blok** ve bunların bağımlılıkları açıkça tanımlanmıştır.

**Önerilen Yaklaşım**:
1. Önce Katman 0-1 (temel ve complex aritmetik) blokları yap
2. Sonra Katman 2 (sync blokları) ile devam et
3. Equalizer'ı implement et (en kritik blok)
4. OFDM decoder pipeline'ı tamamla
5. Son olarak top modül FSM'i yaz

Bu yapı sayesinde **incremental testing** mümkün olur ve her aşamada Verilog ile karşılaştırmalı validasyon yapılabilir.
