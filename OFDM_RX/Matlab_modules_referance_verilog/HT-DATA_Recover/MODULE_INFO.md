# HT-DATA Recover Fixed-Point Reference Model

## Genel Bakış

Bu MATLAB modülü, OpenWiFi projesi Verilog implementasyonunun HT-DATA recovery pipeline'ını birebir taklit eden **fixed-point golden reference** modelidir.

## İçerik

### Ana Dosyalar
- `ht_data_recover_fixed.m` - Ana modül fonksiyonu (fixed-point implementasyon)
- `test_ht_data_recover.m` - Kapsamlı test suite
- `example_usage.m` - Kullanım örnekleri
- `README.m` - Detaylı dokümantasyon
- `MODULE_INFO.md` - Bu dosya

### Pipeline Aşamaları

1. **Demodulation** (Constellation Demapping)
   - BPSK, QPSK, QAM-16, QAM-64
   - Hard ve soft decision destekli
   - Verilog: `demodulate.v`

2. **Deinterleaving**
   - IEEE 802.11a/n deinterleaving pattern
   - Legacy (48 subcarrier) ve HT (52 subcarrier) mode
   - Verilog: `deinterleave.v`

3. **Viterbi Decoding**
   - Constraint length 7, rate 1/2
   - Polynomials: [133, 171] (octal)
   - Verilog: `viterbi.v` (Xilinx IP wrapper)

4. **Descrambling**
   - Polynomial: x^7 + x^4 + 1
   - Optional (SIGNAL field için disable)
   - Verilog: `descramble.v`

5. **Bits-to-Bytes Conversion**
   - LSB-first byte packing
   - Verilog: `bits_to_bytes.v`

## Verilog Kaynak

Referans alınan Verilog modüller:
- `/openwifi-hw/ip/openofdm_rx/verilog/ofdm_decoder.v`
- `/openwifi-hw/ip/openofdm_rx/verilog/demodulate.v`
- `/openwifi-hw/ip/openofdm_rx/verilog/deinterleave.v`
- `/openwifi-hw/ip/openofdm_rx/verilog/viterbi.v`
- `/openwifi-hw/ip/openofdm_rx/verilog/descramble.v`
- `/openwifi-hw/ip/openofdm_rx/verilog/bits_to_bytes.v`

## Kullanım

### Basit Kullanım
```matlab
% Equalized semboller (52 x 10, int16 complex)
eq_symbols = complex(int16(randn(52,10)*512), int16(randn(52,10)*512));

% HT-MCS 1 (QPSK) ile decode
rate = hex2dec('91');
[bytes, count] = ht_data_recover_fixed(eq_symbols, rate, 1040, 1, 1);
```

### Test Çalıştırma
```matlab
test_ht_data_recover  % Tüm test case'leri çalıştır
example_usage         % Örnek kullanımları göster
```

## Fixed-Point Özellikleri

### Constellation Scale
- `CONS_SCALE_SHIFT = 10`
- `MAX = 1024`
- Input: int16 complex (I/Q)

### Soft Decision Quantization
- 3-bit soft values (0-7)
- 0 = strong zero, 7 = strong one
- Verilog implementasyonu ile birebir eşleşir

### Data Types
- Input symbols: `int16` complex
- Output bytes: `uint8`
- Internal processing: fixed-point arithmetic

## Desteklenen Modlar

### Legacy Rates (802.11a)
- 6, 9, 12, 18, 24, 36, 48, 54 Mbps
- 48 data subcarriers

### HT Rates (802.11n)
- MCS 0-7
- 52 data subcarriers
- 20 MHz bandwidth

## Test Coverage

Test suite şunları içerir:
- BPSK, QPSK, QAM-16, QAM-64 modulations
- Legacy ve HT modes
- Hard ve soft decision decoding
- Known pattern validation
- Performance benchmarking

## Performans

Tipik MATLAB performansı:
- 10 OFDM symbols: ~10-50 ms
- Throughput: ~20-100 decodes/sec
- (Hardware implementasyonu çok daha hızlıdır)

## Kısıtlamalar ve Bilinen Sorunlar

1. **Deinterleaving LUT**: Basitleştirilmiş implementasyon kullanılır. Tam bit-exact uyum için Verilog LUT'larının port edilmesi gerekir.

2. **Viterbi Decoder**: MATLAB `vitdec` kullanılır. Xilinx IP core ile küçük farklılıklar olabilir.

3. **Timing**: Functional model, clock-accurate timing simülasyonu içermez.

## Doğrulama

Model şu şekilde doğrulanmalıdır:
1. Known test vectors ile karşılaştırma
2. Verilog simulation çıkışları ile karşılaştırma
3. Hardware test sonuçları ile karşılaştırma

## Gelecek İyileştirmeler

- [ ] Bit-exact deinterleaving LUT
- [ ] Xilinx Viterbi IP exact match
- [ ] MEX file optimization
- [ ] Comprehensive test vectors
- [ ] BER curve generation

## Referanslar

1. IEEE 802.11-2016 Standard
2. OpenWiFi Project: https://github.com/open-sdr/openwifi
3. Xilinx Viterbi Decoder v7.0 (PG027)

## Yazar ve Tarih

- Auto-generated MATLAB Reference Model
- Kaynak: OpenWiFi Verilog implementasyonu
- Tarih: 2026-02-25

## Lisans

OpenWiFi projesi lisansı ile uyumlu (AGPL-3.0)
