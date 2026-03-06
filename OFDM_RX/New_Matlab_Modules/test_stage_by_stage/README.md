# Stage-by-Stage Test Framework

## Overview

Bu framework, OpenOFDM MATLAB modüllerini stage-by-stage (adım adım) test etmek için geliştirilmiştir. Her RX pipeline bloğu bağımsız olarak test edilir ve sonuçlar detaylı raporlanır.

## Test Pipeline

```
TX Generation
    ↓
┌─────────────────────────────────────────┐
│  Stage 1: Power Trigger                 │
│  - Packet detection                     │
│  - Power threshold check                │
└─────────────────────────────────────────┘
    ↓
┌─────────────────────────────────────────┐
│  Stage 2: Sync Short                    │
│  - Short preamble correlation           │
│  - Coarse CFO estimation                │
└─────────────────────────────────────────┘
    ↓
┌─────────────────────────────────────────┐
│  Stage 3: Sync Long                     │
│  - Long preamble processing             │
│  - Channel estimation                   │
│  - FFT output generation                │
└─────────────────────────────────────────┘
    ↓
┌─────────────────────────────────────────┐
│  Stage 4: Equalizer                     │
│  - Channel compensation                 │
│  - SIGNAL field decoding                │
└─────────────────────────────────────────┘
    ↓
┌─────────────────────────────────────────┐
│  Stage 5: Demodulate                    │
│  - Constellation to soft bits           │
│  - LLR generation                       │
└─────────────────────────────────────────┘
    ↓
┌─────────────────────────────────────────┐
│  Stage 6: Deinterleave                  │
│  - Frequency-domain deinterleaving      │
│  - Bit reordering                       │
└─────────────────────────────────────────┘
    ↓
┌─────────────────────────────────────────┐
│  Stage 7: Viterbi Decode                │
│  - Convolutional decoding               │
│  - Hard decision bits                   │
└─────────────────────────────────────────┘
    ↓
┌─────────────────────────────────────────┐
│  Stage 8: Descramble                    │
│  - Data descrambling (x^7 + x^4 + 1)    │
│  - SERVICE field check                  │
└─────────────────────────────────────────┘
    ↓
┌─────────────────────────────────────────┐
│  Stage 9: Bits to Bytes                 │
│  - 8-bit grouping                       │
│  - Byte formation                       │
└─────────────────────────────────────────┘
    ↓
┌─────────────────────────────────────────┐
│  Stage 10: CRC32                        │
│  - FCS validation                       │
│  - Packet integrity check               │
└─────────────────────────────────────────┘
```

## Dosya Yapısı

```
test_stage_by_stage/
├── stage_by_stage_test.m          # Ana test script
├── generate_html_report.m         # HTML rapor oluşturucu
│
├── test_generators/               # TX data generator
│   └── generate_80211a_packet.m   # IEEE 802.11a/g paket üreteci
│
├── test_validators/               # Her stage için test fonksiyonları
│   ├── test_stage1_power_trigger.m
│   ├── test_stage2_sync_short.m
│   ├── test_stage3_sync_long.m
│   ├── test_stage4_equalizer.m
│   ├── test_stage5_demodulate.m
│   ├── test_stage6_deinterleave.m
│   ├── test_stage7_viterbi.m
│   ├── test_stage8_descramble.m
│   ├── test_stage9_bits_to_bytes.m
│   └── test_stage10_crc32.m
│
├── test_data/                     # Test data (otomatik oluşturulur)
│   ├── tx_samples.mat
│   ├── stage1_output.mat
│   ├── stage2_output.mat
│   └── ...
│
└── test_reports/                  # Test raporları (otomatik oluşturulur)
    ├── test_report_YYYYMMDD_HHMMSS.html
    └── test_results.mat
```

## Kullanım

### 1. Temel Kullanım

```matlab
% MATLAB'da test_stage_by_stage klasörüne gidin
cd test_stage_by_stage

% Ana test script'i çalıştırın
stage_by_stage_test
```

### 2. Parametreli Kullanım

```matlab
% Test konfigürasyonu oluştur
test_config = struct();
test_config.tx_rate = 6;                    % Data rate (Mbps)
test_config.tx_payload_bytes = 100;         % Payload size
test_config.tx_packet_type = 'legacy';      % 'legacy' or 'ht'
test_config.enable_plots = true;            % Grafik göster
test_config.save_intermediate = true;       % Ara sonuçları kaydet

% Testi çalıştır
stage_by_stage_test(test_config);
```

### 3. Sadece Belirli Stage'leri Test Et

```matlab
% Sadece Stage 1-5 arası test et
test_config.test_stages = 1:5;
stage_by_stage_test(test_config);
```

## Test Çıktıları

### Console Output

Her stage için detaylı bilgi:
```
=== STAGE 1: Power Trigger ===
[Stage 1] Packet detected at sample 125
[Stage 1] Average power: 2.50e+07 (threshold: 1.00e+03)
[Stage 1] PASS: Triggered at sample 125 (expected range: 1-320)
[Stage 1] Test complete: PASS

=== STAGE 2: Sync Short ===
[Stage 2] Processing samples 125 to 285
[Stage 2] Short preamble detected at sample 160
[Stage 2] Phase estimate: 245
[Stage 2] PASS: Short sync at sample 160
...
```

### HTML Report

Otomatik oluşturulan HTML raporu:
- **Test Summary**: Genel başarı/başarısızlık
- **Stage Results**: Her stage için detaylı sonuçlar
- **Metrics**: Sayısal değerler ve istatistikler
- **Pass/Fail Badges**: Görsel durum göstergeleri

Rapor dosyası: `test_reports/test_report_YYYYMMDD_HHMMSS.html`

### MAT Files

Her stage'in çıktıları `.mat` dosyası olarak kaydedilir:

```matlab
% Stage 1 çıktısını yükle
load('test_data/stage1_output.mat');

% Trigger bilgisini görüntüle
disp(stage1_result.trigger_sample);

% Power profilini çiz
figure; plot(stage1_result.power_profile);
```

## Test Validation Kriterleri

### Stage 1: Power Trigger
- ✓ Packet detected within preamble (first 320 samples)
- ✓ Average power above threshold

### Stage 2: Sync Short
- ✓ Short preamble correlation detected
- ✓ Phase estimate within reasonable range (|phase| < 1000)

### Stage 3: Sync Long
- ✓ Channel estimation completed (52/56 subcarriers)
- ✓ FFT outputs generated (at least 1 OFDM symbol)
- ✓ Average channel power > 100

### Stage 4: Equalizer
- ✓ Equalized symbols generated
- ✓ Symbol magnitude in reasonable range (10 < mag < 10000)
- ✓ SIGNAL field decoded successfully

### Stage 5: Demodulate
- ✓ Soft bits generated (expected count per modulation)
- ✓ Soft bit range: [-127, 127]

### Stage 6: Deinterleave
- ✓ Bit count preserved (input == output)
- ✓ Soft bit range preserved

### Stage 7: Viterbi
- ✓ Decoded bits are binary (0 or 1)
- ✓ Output count ≈ input/2 (rate 1/2 code)

### Stage 8: Descramble
- ✓ Descrambled bits are binary
- ✓ SERVICE field (first 16 bits) should be all zeros

### Stage 9: Bits to Bytes
- ✓ Valid uint8 bytes (0-255)
- ✓ Byte count = bits / 8

### Stage 10: CRC32
- ✓ CRC matches FCS (4 last bytes)
- ✓ Packet integrity validated

## Debugging

### Enable Plots

Her stage için diagnostic plots görmek için:

```matlab
test_config.enable_plots = true;
test_config.plot_stage = [1, 3, 4, 5];  % Sadece bu stage'ler için plot
stage_by_stage_test(test_config);
```

### Intermediate Data Inspection

```matlab
% Stage 3'ün çıktısını incele
load('test_data/stage3_output.mat');

% Channel estimate'leri görselleştir
figure;
subplot(2,1,1);
plot(abs(stage3_result.freq_est));
title('Channel Magnitude');

subplot(2,1,2);
plot(angle(stage3_result.freq_est));
title('Channel Phase');
```

### Compare with Expected Data

Golden reference data ile karşılaştırma:

```matlab
% Expected data yükle (Verilog simulation'dan)
load('golden_reference.mat');

% Test et
test_config.expected_data = golden_reference;
results = stage_by_stage_test(test_config);

% BER hesapla
ber = calculate_ber(results.stage7_viterbi.decoded_bits, ...
                    golden_reference.decoded_bits);
fprintf('BER: %.6f\n', ber);
```

## Known Issues

1. **TX Generator**: Basitleştirilmiş implementasyon - gerçek convolutional encoder, interleaver, ve modulator eklenecek
2. **Module Placeholders**: Bazı modül çağrıları placeholder - gerçek modül fonksiyonları implement edilecek
3. **HT Support**: TX generator şu an sadece Legacy mode - HT mode eklenecek

## Next Steps

1. **TX Generator İyileştirme**
   - Gerçek convolutional encoder (K=7, rate 1/2)
   - Puncturing patterns (rate 2/3, 3/4)
   - Proper interleaver
   - BPSK/QPSK/16-QAM/64-QAM modulation

2. **Module Integration**
   - Gerçek MATLAB modüllerini çağırma
   - Verilog modül davranışını tam olarak kopyalama

3. **Golden Reference**
   - Verilog simulation'dan test vektörleri çıkarma
   - Bit-exact comparison

4. **Performance Metrics**
   - BER curves
   - SNR vs BER
   - Execution time profiling

## Contact

İletişim: Bu framework OpenOFDM MATLAB conversion projesi için geliştirilmiştir.
