%% HT-DATA Recover Fixed-Point Reference Model - README
%
% Bu MATLAB modülü, Verilog OpenOFDM RX implementasyonunun HT-DATA recovery
% pipeline'ını birebir taklit eden fixed-point referans modelidir.
%
% ============================================================================
% GENEL BAKIŞ
% ============================================================================
%
% HT-DATA Recover modülü, IEEE 802.11a/n OFDM alıcısının veri kurtarma 
% aşamasını gerçekleştirir. Equalizer çıkışındaki karmaşık sembolleri alır
% ve byte dizisine dönüştürür.
%
% Pipeline Aşamaları:
%   1. Demodulation (Constellation Demapping)
%   2. Deinterleaving
%   3. Viterbi Decoding (Convolutional Decoder)
%   4. Descrambling
%   5. Bits-to-Bytes Conversion
%
% ============================================================================
% DOSYALAR
% ============================================================================
%
% ht_data_recover_fixed.m  - Ana modül fonksiyonu
% test_ht_data_recover.m   - Test script
% README.m                 - Bu dokümantasyon dosyası
%
% ============================================================================
% VERİLOG KARŞILAŞTIRMASI
% ============================================================================
%
% Bu model aşağıdaki Verilog modüllerinin fonksiyonalitesini içerir:
%
% 1. ofdm_decoder.v       - Ana decoder pipeline
% 2. demodulate.v         - Constellation demapping (BPSK/QPSK/QAM16/QAM64)
% 3. deinterleave.v       - Bit deinterleaving
% 4. viterbi.v            - Viterbi decoder wrapper
% 5. descramble.v         - Descrambler (x^7 + x^4 + 1)
% 6. bits_to_bytes.v      - Bit to byte converter
%
% ============================================================================
% KULLANIM
% ============================================================================
%
% Temel Kullanım:
%   [byte_out, byte_count] = ht_data_recover_fixed(eq_symbols, rate, ...
%       num_bits_to_decode, do_descramble, soft_decoding)
%
% Parametreler:
%   eq_symbols        - Equalized OFDM symbols [Nsc x Nsym] complex int16
%                       Nsc = 48 (Legacy) veya 52 (HT)
%   rate              - Rate field [8-bit uint8]:
%                       bit[7] = HT flag (1=HT, 0=Legacy)
%                       bit[3:0] = MCS/rate index
%   num_bits_to_decode - Toplam decode edilecek bit sayısı
%                        (service bits dahil)
%   do_descramble     - Descrambling aktif mi? (1=evet, 0=hayır)
%                       SIG/HT-SIG için 0, DATA için 1
%   soft_decoding     - Soft decision decoding? (1=evet, 0=hayır)
%
% Çıkışlar:
%   byte_out          - Decode edilmiş byte dizisi [N x 1] uint8
%   byte_count        - Geçerli byte sayısı
%
% ============================================================================
% RATE FIELD KODLAMASI
% ============================================================================
%
% Legacy Rates (bit[7]=0):
%   0x0B (01011) - BPSK  1/2  6 Mbps
%   0x0F (01111) - BPSK  3/4  9 Mbps
%   0x0A (01010) - QPSK  1/2  12 Mbps
%   0x0E (01110) - QPSK  3/4  18 Mbps
%   0x09 (01001) - QAM16 1/2  24 Mbps
%   0x0D (01101) - QAM16 3/4  36 Mbps
%   0x08 (01000) - QAM64 2/3  48 Mbps
%   0x0C (01100) - QAM64 3/4  54 Mbps
%
% HT Rates (bit[7]=1):
%   0x90 (10000) - MCS 0: BPSK  1/2   6.5/7.2 Mbps
%   0x91 (10001) - MCS 1: QPSK  1/2   13/14.4 Mbps
%   0x92 (10010) - MCS 2: QPSK  3/4   19.5/21.7 Mbps
%   0x93 (10011) - MCS 3: QAM16 1/2   26/28.9 Mbps
%   0x94 (10100) - MCS 4: QAM16 3/4   39/43.3 Mbps
%   0x95 (10101) - MCS 5: QAM64 2/3   52/57.8 Mbps
%   0x96 (10110) - MCS 6: QAM64 3/4   58.5/65 Mbps
%   0x97 (10111) - MCS 7: QAM64 5/6   65/72.2 Mbps
%
% ============================================================================
% FİXED-POINT DETAYLARI
% ============================================================================
%
% Constellation Scale:
%   - CONS_SCALE_SHIFT = 10
%   - MAX = 2^10 = 1024
%   - Girişler int16 formatında
%
% Soft Decision Quantization:
%   - 3-bit soft values: 0-7
%   - 0 = strong zero, 7 = strong one
%   - 3-4 arası nötr bölge
%
% Viterbi Decoder:
%   - Constraint length: 7
%   - Code rate: 1/2
%   - Generator polynomials: [133, 171] (octal)
%   - Traceback depth: 48
%
% Descrambler:
%   - Polynomial: x^7 + x^4 + 1
%   - İlk 7 bit scrambler state initialization
%   - Sonraki bitler descramble edilir
%
% ============================================================================
% ÖRNEK KULLANIM
% ============================================================================
%
% Örnek 1: Legacy 6 Mbps BPSK
%   eq_sym = complex(int16(randn(48,10)*512), int16(randn(48,10)*512));
%   [bytes, count] = ht_data_recover_fixed(eq_sym, hex2dec('0B'), ...
%       500, 1, 0);
%
% Örnek 2: HT-MCS 3 (QAM-16)
%   eq_sym = complex(int16(randn(52,20)*512), int16(randn(52,20)*512));
%   [bytes, count] = ht_data_recover_fixed(eq_sym, hex2dec('93'), ...
%       2000, 1, 1);
%
% ============================================================================
% TEST ETME
% ============================================================================
%
% Test script'i çalıştırma:
%   >> test_ht_data_recover
%
% Test script şunları içerir:
%   - Farklı modülasyon tiplerinde test case'ler (BPSK/QPSK/QAM16/QAM64)
%   - Legacy ve HT mode testleri
%   - Hard ve soft decision testleri
%   - Performance benchmarking
%   - Known pattern validation
%
% ============================================================================
% VERİLOG IMPLEMENTASYONU İLE FARKLILIKLARI
% ============================================================================
%
% 1. Deinterleaving LUT:
%    - Verilog: ROM-based lookup table (deinter_lut.v)
%    - MATLAB: Basitleştirilmiş algoritmik implementasyon
%    - UYARI: Tam uyum için LUT'ların port edilmesi gerekir
%
% 2. Viterbi Decoder:
%    - Verilog: Xilinx Viterbi IP core (viterbi_v7_0)
%    - MATLAB: Built-in vitdec fonksiyonu
%    - Küçük farklılıklar olabilir, özellikle edge case'lerde
%
% 3. Pipeline Timing:
%    - Verilog: Clock-accurate, pipeline register'ları
%    - MATLAB: Functional model, timing abstractionu
%
% ============================================================================
% PERFORMANS ÖZELLİKLERİ
% ============================================================================
%
% Tipik işlem süreleri (MATLAB):
%   - 10 OFDM symbol (~480 bytes): ~10-50 ms
%   - Soft decoding hard decoding'den ~2x yavaş
%   - QAM-64, BPSK'dan ~1.5x yavaş
%
% Bellek kullanımı:
%   - Minimal, çoğunlukla input/output buffer'ları
%   - Viterbi decoder için traceback buffer
%
% ============================================================================
% SORUN GİDERME
% ============================================================================
%
% Problem: Çıkış byte'ları boş veya çok az
%   - num_bits_to_decode parametresini kontrol edin
%   - Equalizer symbol'larının doğru scale'de olduğunu doğrulayın
%   - rate parametresinin doğru olduğunu kontrol edin
%
% Problem: Decode edilen veriler yanlış
%   - Viterbi decoder soft decision değerlerini kontrol edin
%   - Deinterleaving pattern'inin doğru olduğunu doğrulayın
%   - Descrambler state initialization'ı kontrol edin
%
% Problem: MATLAB hatası: "Index exceeds array bounds"
%   - Input symbol matrix boyutlarını kontrol edin
%   - [Nsc x Nsym] formatında olmalı
%   - Nsc = 48 (Legacy) veya 52 (HT)
%
% ============================================================================
% GELIŞTIRME NOTLARI
% ============================================================================
%
% Gelecek İyileştirmeler:
%   1. Tam deinterleaving LUT implementasyonu
%   2. Bit-exact Viterbi decoder (Xilinx IP match)
%   3. Performance optimization (MEX file)
%   4. Comprehensive test vector suite
%   5. BER/SNR karakterizasyonu
%
% ============================================================================
% REFERANSLAR
% ============================================================================
%
% [1] IEEE Std 802.11-2016 - Wireless LAN Medium Access Control (MAC) and
%     Physical Layer (PHY) Specifications
% [2] OpenWiFi Project - openwifi-hw repository
%     https://github.com/open-sdr/openwifi-hw
% [3] Xilinx Viterbi Decoder v7.0 Product Guide (PG027)
%
% ============================================================================
% YAZAN
% ============================================================================
%
% Auto-generated MATLAB Reference Model
% Verilog kaynak: openwifi-hw/ip/openofdm_rx/verilog/
% Tarih: 2026-02-25
%
% ============================================================================

fprintf('HT-DATA Recover Fixed-Point Reference Model - README\n');
fprintf('Bu dosya dokümantasyon amaçlıdır.\n');
fprintf('Ana fonksiyon için: help ht_data_recover_fixed\n');
fprintf('Test için: test_ht_data_recover\n');
