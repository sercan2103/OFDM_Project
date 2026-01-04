# OFDM Verici (TX) - IEEE 802.11n HT Format

## Türkçe

### Proje Hakkında

Bu proje, IEEE 802.11n (Wi-Fi 4) standardına uygun HT-mixed format OFDM verici uygulamasını içermektedir. Proje, MATLAB tabanlı model ve Verilog tabanlı donanım implementasyonunu kapsamaktadır.

### Ana Dosya: hex_to_ofdm_ht.m

**hex_to_ofdm_ht.m**, tüm OFDM verici modelinin ana giriş noktasıdır. Bu fonksiyon, hexadecimal veriyi alır ve tam bir IEEE 802.11n HT-mixed format OFDM sinyaline dönüştürür.

**Girişler:**
- `hex_data`: Hexadecimal veri string'i (örn: 'DEADBEEF...')
- `rate`: L-SIG için rate alanı (genellikle 11 = 6 Mbps)
- `mcs`: Modulation and Coding Scheme (0-7 arası, tek stream için)
- `n_bpsc`: Alt taşıyıcı başına bit sayısı (1, 2, 4 veya 6)
- `n_dbps`: OFDM sembolü başına veri bit sayısı
- `psdu_length_bytes`: L-SIG alanı için PSDU uzunluğu (byte cinsinden)

**Çıkış:**
- `iq_samples`: Kompleks IQ örnekleri (L-STF + L-LTF + L-SIG + HT-SIG + HT-STF + HT-LTF + DATA)

**Örnek Kullanım:**
```matlab
hex_data = 'DEADBEEFCAFEBABE1234567890ABCDEF';
rate = 11;       % 6 Mbps L-SIG için
mcs = 3;         % 16-QAM 1/2
n_bpsc = 4;
n_dbps = 104;
psdu_length = 16;
iq = hex_to_ofdm_ht(hex_data, rate, mcs, n_bpsc, n_dbps, psdu_length);
```

### İşleme Adımları

`hex_to_ofdm_ht.m` fonksiyonu şu adımları gerçekleştirir:

1. **Hex'ten Binary'e Dönüşüm**: Hexadecimal veriyi binary dizisine çevirir
2. **Veri Hazırlama**: Service field (16 bit), PSDU verisi ve Tail bits (6 bit) eklenir
3. **Scrambling**: IEEE 802.11 scrambler ile veri karıştırılır
4. **Convolutional Encoding**: Rate 1/2 konvolüsyonel kodlayıcı uygulanır
5. **Puncturing & Interleaving**: MCS'ye göre puncturing ve interleaving yapılır
6. **Modulation**: BPSK, QPSK, 16-QAM veya 64-QAM modulasyonu uygulanır
7. **IFFT**: 64-nokta IFFT ile OFDM sembolü oluşturulur
8. **Cyclic Prefix**: Her sembole 16 örnek cyclic prefix eklenir
9. **Preamble Oluşturma**: L-STF, L-LTF, L-SIG, HT-SIG, HT-STF, HT-LTF eklenir
10. **Birleştirme**: Tüm bileşenler sırayla birleştirilir

### OFDM Çerçeve Yapısı

```
┌────────────────────────────────────────────────────────────┐
│ L-STF  │ L-LTF  │ L-SIG │ HT-SIG │ HT-STF │ HT-LTF │ DATA  │
│ 8.0 µs │ 8.0 µs │ 4.0 µs│ 8.0 µs │ 4.0 µs │ 4.0 µs │ ...   │
│160 smp │160 smp │80 smp │160 smp │ 80 smp │ 80 smp │ ...   │
└────────────────────────────────────────────────────────────┘
         ↑________________36.0 µs Preamble________________↑
```

### Dosya Yapısı

#### Model Dosyaları (MATLAB)
- **hex_to_ofdm_ht.m**: Ana verici modeli (tüm sistemi çalıştırır)
- **generate_signal_iq.m**: L-SIG ve HT-SIG field'larını oluşturur
- **Scrambler.m**: IEEE 802.11 veri scrambler'ı
- **conv_encoder_80211.m**: Rate 1/2 konvolüsyonel encoder
- **dot11_punc_interlv.m**: Puncturing ve interleaving
- **modulation_model.m**: BPSK, QPSK, 16-QAM, 64-QAM modulasyon
- **ifft64_model.m**: 64-nokta IFFT işlemi
- **punc_interlv_lut.m**: Puncturing/interleaving lookup table'ları
- **read_plcp_config.m**: PLCP konfigürasyon okuma
- **plot_preambles.m**: Preamble görselleştirme

#### Test Dosyaları (MATLAB)
Test dosyaları model doğrulaması için kullanılır, model implementasyonu değildir:
- **test_hex_to_ofdm_ht.m**: Ana fonksiyonun kapsamlı testi
- **test_generate_signal_iq.m**: Signal field testleri
- **test_dot11_punc_interlv.m**: Puncturing/interleaving testleri
- **test_ifft64.m**: IFFT testleri
- **modulation_test.m**: Modulasyon testleri
- **Conv_encoder_test.m**: Encoder testleri

#### Verilog Implementasyonu
- **Verilog_IP/openofdm_tx/src/dot11_tx.v**: Donanım implementasyonu
  - Bu dosya detaylı olarak parse edilmiş ve Türkçe yorumlar eklenmiştir
  - Tüm state machine'ler ve veri akışı açıklanmıştır
  - MATLAB modelinin donanım karşılığıdır

### Detaylı Dokümantasyon

- **TX.pdf**: Tüm blokların ve modellerin detaylı açıklaması
  - Sinyal işleme adımları
  - Matematiksel formüller
  - Blok diyagramları
  - Zamanlama diyagramları

- **dot11_tx.v**: Verilog donanım implementasyonunun detaylı açıklaması
  - State machine açıklamaları
  - Veri yolu diyagramları
  - Zamanlama kriterleri
  - Port açıklamaları

### MCS (Modulation and Coding Scheme) Tablosu

| MCS | Modulasyon | Kod Oranı | N_BPSC | N_DBPS | Veri Hızı (Mbps) |
|-----|------------|-----------|--------|--------|------------------|
| 0   | BPSK       | 1/2       | 1      | 26     | 6.5              |
| 1   | QPSK       | 1/2       | 2      | 52     | 13.0             |
| 2   | QPSK       | 3/4       | 2      | 78     | 19.5             |
| 3   | 16-QAM     | 1/2       | 4      | 104    | 26.0             |
| 4   | 16-QAM     | 3/4       | 4      | 156    | 39.0             |
| 5   | 64-QAM     | 2/3       | 6      | 208    | 52.0             |
| 6   | 64-QAM     | 3/4       | 6      | 234    | 58.5             |
| 7   | 64-QAM     | 5/6       | 6      | 260    | 65.0             |

### Kurulum ve Çalıştırma

1. MATLAB'ı açın
2. OFDM_TX klasörüne gidin
3. Ana fonksiyonu çalıştırın:
```matlab
cd OFDM_TX
test_hex_to_ofdm_ht  % Test ve görselleştirme için
```

### Gereksinimler

- MATLAB R2019b veya üzeri
- Signal Processing Toolbox (opsiyonel, temel işlevler için gerekli değil)

---

## English

### About the Project

This project contains an IEEE 802.11n (Wi-Fi 4) HT-mixed format OFDM transmitter implementation. The project includes both MATLAB-based modeling and Verilog-based hardware implementation.

### Main File: hex_to_ofdm_ht.m

**hex_to_ofdm_ht.m** is the main entry point for the entire OFDM transmitter model. This function takes hexadecimal data and converts it into a complete IEEE 802.11n HT-mixed format OFDM signal.

**Inputs:**
- `hex_data`: Hexadecimal data string (e.g., 'DEADBEEF...')
- `rate`: Rate field for L-SIG (typically 11 = 6 Mbps)
- `mcs`: Modulation and Coding Scheme (0-7 for single stream)
- `n_bpsc`: Number of Bits Per SubCarrier (1, 2, 4, or 6)
- `n_dbps`: Number of Data Bits Per Symbol
- `psdu_length_bytes`: PSDU length in bytes for L-SIG field

**Output:**
- `iq_samples`: Complex IQ samples (L-STF + L-LTF + L-SIG + HT-SIG + HT-STF + HT-LTF + DATA)

**Example Usage:**
```matlab
hex_data = 'DEADBEEFCAFEBABE1234567890ABCDEF';
rate = 11;       % 6 Mbps for L-SIG
mcs = 3;         % 16-QAM 1/2
n_bpsc = 4;
n_dbps = 104;
psdu_length = 16;
iq = hex_to_ofdm_ht(hex_data, rate, mcs, n_bpsc, n_dbps, psdu_length);
```

### Processing Pipeline

The `hex_to_ofdm_ht.m` function performs the following steps:

1. **Hex to Binary Conversion**: Converts hexadecimal data to binary array
2. **Data Preparation**: Adds Service field (16 bits), PSDU data, and Tail bits (6 bits)
3. **Scrambling**: Applies IEEE 802.11 scrambler to randomize data
4. **Convolutional Encoding**: Applies rate 1/2 convolutional encoder
5. **Puncturing & Interleaving**: Performs puncturing and interleaving based on MCS
6. **Modulation**: Applies BPSK, QPSK, 16-QAM, or 64-QAM modulation
7. **IFFT**: Creates OFDM symbol using 64-point IFFT
8. **Cyclic Prefix**: Adds 16-sample cyclic prefix to each symbol
9. **Preamble Generation**: Generates L-STF, L-LTF, L-SIG, HT-SIG, HT-STF, HT-LTF
10. **Concatenation**: Combines all components in correct order

### OFDM Frame Structure

```
┌────────────────────────────────────────────────────────────┐
│ L-STF  │ L-LTF  │ L-SIG │ HT-SIG │ HT-STF │ HT-LTF │ DATA  │
│ 8.0 µs │ 8.0 µs │ 4.0 µs│ 8.0 µs │ 4.0 µs │ 4.0 µs │ ...   │
│160 smp │160 smp │80 smp │160 smp │ 80 smp │ 80 smp │ ...   │
└────────────────────────────────────────────────────────────┘
         ↑________________36.0 µs Preamble________________↑
```

### File Structure

#### Model Files (MATLAB)
- **hex_to_ofdm_ht.m**: Main transmitter model (runs entire system)
- **generate_signal_iq.m**: Generates L-SIG and HT-SIG fields
- **Scrambler.m**: IEEE 802.11 data scrambler
- **conv_encoder_80211.m**: Rate 1/2 convolutional encoder
- **dot11_punc_interlv.m**: Puncturing and interleaving
- **modulation_model.m**: BPSK, QPSK, 16-QAM, 64-QAM modulation
- **ifft64_model.m**: 64-point IFFT operation
- **punc_interlv_lut.m**: Puncturing/interleaving lookup tables
- **read_plcp_config.m**: PLCP configuration reader
- **plot_preambles.m**: Preamble visualization

#### Test Files (MATLAB)
Test files are used for model verification, not model implementation:
- **test_hex_to_ofdm_ht.m**: Comprehensive test of main function
- **test_generate_signal_iq.m**: Signal field tests
- **test_dot11_punc_interlv.m**: Puncturing/interleaving tests
- **test_ifft64.m**: IFFT tests
- **modulation_test.m**: Modulation tests
- **Conv_encoder_test.m**: Encoder tests

#### Verilog Implementation
- **Verilog_IP/openofdm_tx/src/dot11_tx.v**: Hardware implementation
  - This file has been parsed in detail with Turkish comments
  - All state machines and data flows are explained
  - Hardware equivalent of the MATLAB model

### Detailed Documentation

- **TX.pdf**: Detailed explanation of all blocks and models
  - Signal processing steps
  - Mathematical formulas
  - Block diagrams
  - Timing diagrams

- **dot11_tx.v**: Detailed explanation of Verilog hardware implementation
  - State machine descriptions
  - Data path diagrams
  - Timing requirements
  - Port descriptions

### MCS (Modulation and Coding Scheme) Table

| MCS | Modulation | Code Rate | N_BPSC | N_DBPS | Data Rate (Mbps) |
|-----|------------|-----------|--------|--------|------------------|
| 0   | BPSK       | 1/2       | 1      | 26     | 6.5              |
| 1   | QPSK       | 1/2       | 2      | 52     | 13.0             |
| 2   | QPSK       | 3/4       | 2      | 78     | 19.5             |
| 3   | 16-QAM     | 1/2       | 4      | 104    | 26.0             |
| 4   | 16-QAM     | 3/4       | 4      | 156    | 39.0             |
| 5   | 64-QAM     | 2/3       | 6      | 208    | 52.0             |
| 6   | 64-QAM     | 3/4       | 6      | 234    | 58.5             |
| 7   | 64-QAM     | 5/6       | 6      | 260    | 65.0             |

### Installation and Running

1. Open MATLAB
2. Navigate to OFDM_TX folder
3. Run the main function:
```matlab
cd OFDM_TX
test_hex_to_ofdm_ht  % For testing and visualization
```

### Requirements

- MATLAB R2019b or later
- Signal Processing Toolbox (optional, not required for basic functions)

---

## License

This project is for educational and research purposes.

## Contact

For questions or contributions, please open an issue on the repository.

