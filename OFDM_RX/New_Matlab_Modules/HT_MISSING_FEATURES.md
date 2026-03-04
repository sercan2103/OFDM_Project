# ⚠️ EKSİK KALAN HT ÖZELLİKLERİ

## Yapılmış Olanlar ✅
1. ✅ equalizer.m - 56 subcarrier, ht_mode input
2. ✅ sync_long.m - HT FFT extraction, short_gi
3. ✅ deinterleave.m - HT carrier count
4. ✅ dot11.m - HT-SIG parsing (basic)

---

## ❌ EKSİK KALAN ÖNEMLİ ÖZELLİKLER

### 1. **equalizer.m - S_HT_LTS State Eksik** 🔴

**Verilog'da:**
```verilog
localparam S_HT_LTS = 5;  // State #5

S_HT_LTS: begin
    // Process HT-LTS symbols (2 extra HT training symbols)
    // Different from Legacy LTS!
    ht_lts_ref <= {ht_lts_ref[0], ht_lts_ref[63:1]};
    if (ht_lts_ref[0] == 0) begin
        // Channel estimation for HT data carriers
    end
end
```

**MATLAB'da:**
- ❌ S_HT_LTS state yok
- ❌ HT-LTS channel estimation eksik
- ❌ Sadece Legacy LTS işleniyor

**Açıklama:**
HT paketlerde, Legacy LTS'den sonra 2 ayrı **HT-LTS** (HT Long Training Symbol) gelir. Bunlar:
- HT-SIG'den sonra başlar
- HT-STS (Short Training) atlanır
- 2 HT-LTS sembolü ile channel estimation güncellenir
- HT için özel LTS_REF kullanır

---

### 2. **dot11.m - HT State Machine Eksik** 🔴

**Verilog State'leri:**
```verilog
S_DETECT_HT        // Legacy mi HT mi detect et (BPSK rotation check)
S_HT_SIGNAL        // HT-SIG decode (6 byte)
S_CHECK_HT_SIG_CRC // CRC-8 validation
S_CHECK_HT_SIG     // MCS/CBW/STBC/FEC check
S_HT_SIG_ERROR     // HT-SIG error handling
S_HT_STS           // HT Short Training (1 symbol skip)
S_HT_LTS           // HT Long Training (2 symbols, channel update)
```

**MATLAB'da:**
```matlab
% Sadece bunlar var:
% S_DECODE_SIGNAL - Legacy + HT-SIG parsing (simplified)
% S_DECODE_DATA
```

**Eksikler:**
- ❌ `S_DETECT_HT` - BPSK rotation detection yok
- ❌ `S_CHECK_HT_SIG_CRC` - CRC-8 validation yok
- ❌ `S_HT_STS` - HT short training skip yok
- ❌ `S_HT_LTS` - HT long training processing yok
- ❌ `S_HT_SIG_ERROR` - Error handling eksik

---

### 3. **HT Detection Logic Eksik** 🔴

**Verilog:**
```verilog
S_DETECT_HT: begin
    if (equalizer_out_strobe) begin
        abs_eq_i <= eq_out_i[15]? ~eq_out_i+1: eq_out_i;
        abs_eq_q <= eq_out_q[15]? ~eq_out_q+1: eq_out_q;
        
        // BPSK rotation check (HT-SIG is rotated 90°)
        if (abs_eq_q > abs_eq_i) begin
            rot_eq_count <= rot_eq_count + 1;  // Rotated → HT
        end else begin
            normal_eq_count <= normal_eq_count + 1;  // Normal → Legacy
        end
    end
    
    if (rot_eq_count >= 4) begin
        state <= S_HT_SIGNAL;  // HT detected
    end else if (normal_eq_count > 4) begin
        state <= S_DECODE_DATA;  // Legacy detected
    end
end
```

**MATLAB'da:**
- ❌ Rotation detection yok
- ❌ Sadece rate field'a bakıyor (yanlış method)
- ❌ `rot_eq_count`, `normal_eq_count` yok

**Neden önemli:**
IEEE 802.11n, HT paketleri Legacy'den ayırt etmek için **BPSK rotation** kullanır:
- Legacy SIGNAL: Normal BPSK
- HT-SIG: 90° clockwise rotation (Q dominant)
- Bu sayede eski cihazlar HT paketleri görmezden gelir

---

### 4. **HT-SIG CRC-8 Validation Eksik** 🔴

**Verilog:**
```verilog
ht_sig_crc crc_inst (
    .clock(clock),
    .enable(enable),
    .reset(reset | crc_reset),
    .bit(crc_in),
    .input_strobe(crc_in_stb),
    .crc(crc_out)  // 8-bit CRC
);

S_CHECK_HT_SIG_CRC: begin
    // Feed 34 bits to CRC calculator
    if (crc_count < 24) begin
        crc_in <= ht_sig1[crc_count];
    end else if (crc_count < 34) begin
        crc_in <= ht_sig2[crc_count-24];
    end
    
    // Compare with received CRC
    if (crc_out ^ crc) begin
        state <= S_HT_SIG_ERROR;
    end
end
```

**MATLAB'da:**
- ❌ CRC-8 modülü yok
- ❌ HT-SIG validation yapılmıyor
- ❌ Hatalı HT-SIG'ler kabul ediliyor

---

### 5. **HT-SIG Field Checks Eksik** 🔴

**Verilog:**
```verilog
S_CHECK_HT_SIG: begin
    if (ht_mcs > 7) begin
        status_code <= E_UNSUPPORTED_MCS;
        state <= S_HT_SIG_ERROR;
    end else if (ht_cbw) begin
        status_code <= E_UNSUPPORTED_CBW;  // 40 MHz not supported
        state <= S_HT_SIG_ERROR;
    end else if (ht_rsvd == 0) begin  // Rsvd must be 1!
        status_code <= E_HT_WRONG_RSVD;
        state <= S_HT_SIG_ERROR;
    end else if (ht_stbc != 0) begin
        status_code <= E_UNSUPPORTED_STBC;
        state <= S_HT_SIG_ERROR;
    end else if (ht_fec_coding) begin
        status_code <= E_UNSUPPORTED_FEC;  // LDPC not supported
        state <= S_HT_SIG_ERROR;
    end else if (short_gi) begin
        status_code <= E_UNSUPPORTED_SGI;
        state <= S_HT_SIG_ERROR;
    end
    // ... more checks
end
```

**MATLAB'da:**
- ❌ Hiçbir validation yok
- ❌ Desteklenmeyen özellikler kabul ediliyor
- ❌ Error handling yok

---

### 6. **HT-STS Skip Logic Eksik** 🔴

**Verilog:**
```verilog
S_HT_STS: begin
    // Skip 1 HT Short Training symbol (64 samples)
    if (sync_long_out_strobe) begin
        sync_long_out_count <= sync_long_out_count + 1;
    end
    if (sync_long_out_count == 64) begin
        sync_long_out_count <= 0;
        ht_next <= 1;  // Signal equalizer: HT-LTS coming!
        state <= S_HT_LTS;
    end
end
```

**MATLAB'da:**
- ❌ HT-STS skip yok
- ❌ `ht_next` signaling yok
- ❌ Symbol count tracking yok

---

### 7. **HT-LTS Processing Eksik** 🔴

**Verilog:**
```verilog
S_HT_LTS: begin
    short_gi <= ht_sgi;  // Update GI for data symbols
    
    if (sync_long_out_strobe) begin
        sync_long_out_count <= sync_long_out_count + 1;
    end
    
    // Process 2 HT-LTS symbols (128 samples total)
    if (sync_long_out_count == 64) begin
        ht_next <= 0;
        num_bits_to_decode <= (ht_len+3)<<4;
        pkt_rate <= {1'b1, ht_mcs};  // MSB=1 indicates HT
        do_descramble <= 1;
        pkt_ht <= 1;
        state <= S_DECODE_DATA;
    end
end
```

**MATLAB'da:**
- ❌ HT-LTS state yok
- ❌ 2 HT training symbols işlenmiyor
- ❌ `ht_next` signal yok
- ❌ Rate encoding yanlış

---

### 8. **equalizer.m - ht_next Signal Handling Eksik** 🔴

**Verilog:**
```verilog
input ht_next,  // Signal from dot11: HT-LTS coming next

S_GET_POLARITY: begin
    if (~ht & ht_next) begin
        // Switch to HT mode
        ht <= 1;
        num_data_carrier <= 52;
        subcarrier_mask <= HT_SUBCARRIER_MASK;
        data_subcarrier_mask <= HT_DATA_SUBCARRIER_MASK;
        lts_ref <= HT_LTS_REF;
        state <= S_HT_LTS;  // Go to HT-LTS processing
    end
end
```

**MATLAB'da:**
- ❌ `ht_next` input signal yok
- ❌ Dynamic mode switching yok
- ❌ HT-LTS state transition yok

---

### 9. **HT-SIG 90° Rotation Eksik** 🔴

**Verilog:**
```verilog
S_HT_SIGNAL: begin
    ofdm_in_stb <= eq_out_stb_delayed;
    
    // IMPORTANT: Rotate clockwise by 90 degree!
    ofdm_in_i <= eq_out_q_delayed;
    ofdm_in_q <= ~eq_out_i_delayed + 1;  // -I
end
```

**MATLAB'da:**
- ❌ 90° rotation yok
- ❌ HT-SIG directly processed
- ❌ Demodulation yanlış olur

---

### 10. **Rate Encoding Eksik** 🔴

**Verilog:**
```verilog
// Legacy rate: {1'b0, 3'b0, legacy_rate[3:0]}
// HT rate:     {1'b1, ht_mcs[6:0]}
pkt_rate <= {1'b1, ht_mcs};  // MSB=1 → HT, bits[6:0]=MCS
```

**MATLAB'da:**
```matlab
% Current:
pkt_rate = ht_mcs;  // Wrong! MSB should be 1
```

**Sorun:**
Demodulator rate'den HT mi Legacy mi ayırt edemiyor!

---

## 📊 Eksiklik Özeti

| Özellik | Verilog | MATLAB | Kritiklik |
|---------|---------|--------|-----------|
| HT Detection (rotation) | ✅ | ❌ | 🔴 **CRITICAL** |
| HT-SIG CRC-8 validation | ✅ | ❌ | 🔴 **CRITICAL** |
| HT-SIG field checks | ✅ | ❌ | 🟡 Medium |
| HT-STS skip | ✅ | ❌ | 🔴 **CRITICAL** |
| HT-LTS processing | ✅ | ❌ | 🔴 **CRITICAL** |
| equalizer S_HT_LTS state | ✅ | ❌ | 🔴 **CRITICAL** |
| HT-SIG 90° rotation | ✅ | ❌ | 🔴 **CRITICAL** |
| ht_next signaling | ✅ | ❌ | 🔴 **CRITICAL** |
| Rate encoding (MSB=HT) | ✅ | ❌ | 🔴 **CRITICAL** |
| State machine full | ✅ | ❌ | 🔴 **CRITICAL** |

---

## 🎯 ÖNCELİKLENDİRME

### **P0 - CRITICAL (Olmadan HT çalışmaz):**
1. ✅ ~~56 subcarrier support~~ - YAPILDI
2. ❌ **HT detection via BPSK rotation** - YOK
3. ❌ **HT-SIG 90° rotation** - YOK
4. ❌ **HT-STS skip** - YOK
5. ❌ **HT-LTS state & processing** - YOK
6. ❌ **ht_next signaling** - YOK
7. ❌ **Rate encoding fix** - YOK

### **P1 - HIGH (Validation için gerekli):**
1. ❌ HT-SIG CRC-8 validation
2. ❌ HT-SIG field checks
3. ❌ Error state handling

### **P2 - MEDIUM (Nice to have):**
1. ✅ ~~Short GI support~~ - YAPILDI
2. ❌ Status codes for debugging
3. ❌ Sample count timeouts

---

## 🔧 YAPILMASI GEREKENLER

### Immediate (P0):

1. **equalizer.m:**
   - `ht_next` input ekle
   - `S_HT_LTS` state ekle
   - HT-LTS channel estimation ekle
   - Dynamic mode switching ekle

2. **dot11.m:**
   - `S_DETECT_HT` state ekle (rotation detection)
   - `S_HT_SIGNAL` state ekle (90° rotation)
   - `S_HT_STS` state ekle (skip)
   - `S_HT_LTS` state ekle (processing)
   - `ht_next` signal gönder
   - Rate encoding düzelt (MSB=1 for HT)

3. **sync_long.m:**
   - ✅ Zaten yapıldı (GI support var)

4. **demodulate.m:**
   - Rate bit 7'yi check et (HT flag)
   - HT MCS 0-7 için demodulation

### Follow-up (P1):

5. **ht_sig_crc.m:**
   - Yeni modül: CRC-8 calculator
   - 34-bit input
   - Polynomial: x^8+x^7+x^4+x^3+x+1

6. **dot11.m validation:**
   - HT-SIG CRC check
   - Field validation (MCS, CBW, STBC, etc.)
   - Error handling

---

## 📝 SONUÇ

**Mevcut durum:** MATLAB modülleri **temel HT infrastructure** var ama **kritik state machine logic** eksik.

**Gerçek durum:** 
- ✅ 30% tamamlandı (subcarrier support, basic parsing)
- ❌ 70% eksik (state machine, detection, training)

**Çalışır mı?**
- ❌ **HAYIR** - Legacy LTS'den sonra HT-LTS işlenemiyor
- ❌ HT vs Legacy detection çalışmıyor
- ❌ HT-SIG 90° rotation eksik → decode edilemez

**Ne zaman çalışır?**
Yukarıdaki P0 kritik özellikler eklenince.

---

*Analiz Tarihi: March 4, 2026*
