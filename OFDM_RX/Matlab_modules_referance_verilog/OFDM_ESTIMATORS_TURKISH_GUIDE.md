# OpenOFDM RX - Tahminleyici ve Düzeltme Modülleri Kılavuzu

Bu döküman, OpenOFDM RX alıcısındaki temel sinyal işleme bloklarının yerini, işlevini ve önemini açıklamaktadır.

## 📍 Genel Veri Akışı

```
sample_in 
   ↓
[Power Trigger] → Paket başlangıcını tespit et
   ↓
[SYNC_SHORT] → Kaba CFO tahmini + Kısa preamble algılama
   ↓
[SYNC_LONG] → Sembol zamanlaması + İnce CFO düzeltmesi + FFT
   ↓
[EQUALIZER] → Kanal tahmini + Gürültü tahmini + Kanal eşitleme
   ↓
[DEMODULATOR] → Sembol → Bit dönüşümü
   ↓
sample_out
```

---

## 1️⃣ KABA CFO TAHMİNCİSİ (Coarse CFO Estimator)

### 📂 Dosya: `sync_short.v`
### 📍 Satırlar: ~200-220

### ❓ NE İŞE YARIYOR?
Alıcı ve verici osilatörleri arasındaki frekans farkını (Carrier Frequency Offset - CFO) tahmin eder. 16 örnek gecikmeli auto-correlation kullanır.

### 🎯 NİÇİN YAPILIYOR?
- WiFi paketinin başlangıcını tespit etmek için
- Kaba (±312.5 kHz'e kadar) frekans ofseti tahmin etmek için
- sync_long modülü için hazırlık yapmak için

### 🔍 NEREDE BAŞLAYIP BİTİYOR?

#### BAŞLANGIÇ:
```verilog
// Satır ~145-170: Gecikmiş örnek ile çarpım
complex_mult delay_prod_inst (
    .a_i(sample_in[31:16]),
    .a_q(sample_in[15:0]),
    .b_i(sample_delayed_conj[31:16]),
    .b_q(sample_delayed_conj[15:0]),
    ...
);
```

#### HESAPLAMA:
```verilog
// Satır ~200-220: 64 örneklik ortalama (freq_offset_inst)
mv_avg_dual_ch #(.DATA_WIDTH0(32), .DATA_WIDTH1(32), .LOG2_AVG_LEN(6)) freq_offset_inst (
    .data_in0(prod[63:32]),  // I kanalı
    .data_in1(prod[31:0]),   // Q kanalı
    ...
    .data_out0(phase_in_i),
    .data_out1(phase_in_q),
);
```

#### FÖZ HESAPLAMA:
```verilog
// Satır ~195-200: phase modülü ile açı hesaplama
phase phase_inst (
    .i(phase_in_i),
    .q(phase_in_q),
    .phase(phase_out)  // Frekans ofseti açısı
);
```

#### BİTİŞ:
```verilog
// Satır ~270-280: phase_offset çıkışı
phase_offset <= ~phase_offset_neg + 1;  // sync_long'a gönderilir
```

### 📊 FORMÜL:
```
CFO_coarse = angle(sum(r(n) * conj(r(n-16)))) / (16 * 2π * T)
```

---

## 2️⃣ SEMBOL ZAMANLAMA TAHMİNCİSİ (Symbol Timing Estimator)

### 📂 Dosya: `sync_long.v`
### 📍 Satırlar: ~90-140 (buffer), ~280-310 (execution), ~410-550 (task)

### ❓ NE İŞE YARIYOR?
Uzun preamble (Long Training Sequence - LTS) algılayarak FFT penceresinin optimal başlangıç noktasını belirler. Bilinen LTS dizisi ile çapraz-ilişkilendirme (cross-correlation) yapar.

### 🎯 NİÇİN YAPILIYOR?
- OFDM sembollerinin doğru zaman noktasında örneklenmesini sağlamak için
- ISI (Inter-Symbol Interference) ve ICI (Inter-Carrier Interference) etkilerini minimize etmek için
- FFT işleminin doğru noktada başlamasını garantilemek için

### 🔍 NEREDE BAŞLAYIP BİTİYOR?

#### BAŞLANGIÇ (Buffer):
```verilog
// Satır ~90-100: 32 örneklik tampon
reg [31:0] cross_corr_buf[0:31];
```

#### ÇARPIM İŞLEMİ:
```verilog
// Satır ~410-550: do_mult task - 4 aşamada (4x8=32 örnek)
task do_mult; begin
    // cross correlation of the first 16 samples of LTS
    if (sample_in_strobe) begin
        cross_corr_buf[31] <= sample_in;
        ...
        // Bilinen LTS değerleri ile çarpım
        stage_Y0 <= { 16'd156, 16'd0};
        stage_Y1 <= {-16'd5,   16'd120};
        ...
    end
    ...
end
endtask
```

#### KORELASYON HESAPLAMA:
```verilog
// Satır ~110-135: stage_mult modülü ile paralel çarpım
stage_mult stage_mult_inst (
    .X0(stage_X0), .X1(stage_X1), ..., .X7(stage_X7),  // Gelen örnekler
    .Y0(stage_Y0), .Y1(stage_Y1), ..., .Y7(stage_Y7),  // LTS referansı
    .sum({stage_sum_i, stage_sum_q}),                   // Çıkış
    ...
);
```

#### MAKSIMUM BULMA:
```verilog
// Satır ~285-295: S_WAIT_FOR_FIRST_PEAK state
if (metric_stb && (metric > metric_max1)) begin
    metric_max1 <= metric;
    addr1 <= in_raddr - 1 - fft_win_shift;  // En iyi zamanla noktası
end
```

#### BİTİŞ:
```verilog
// Satır ~295-310: FFT başlangıç adresini ayarla
if (num_sample >= 88) begin
    long_preamble_detected <= 1;
    in_raddr <= addr1 - 32;  // FFT penceresi başlangıcı
    num_input_consumed <= addr1 - 32;
    state <= S_FFT;
end
```

### 📊 FORMÜL:
```
metric(d) = |sum(r(d+n) * LTS*(n))|²
d_opt = argmax(metric(d))
```

---

## 3️⃣ İNCE CFO DÜZELTMESİ (Fine CFO Correction)

### 📂 Dosya: `sync_long.v`
### 📍 Satırlar: ~185-205 (rotasyon), ~330-365 (güncelleme)

### ❓ NE İŞE YARIYOR?
sync_short'tan gelen phase_offset değerini kullanarak her örnekte faz rotasyonu uygular. Kalan taşıyıcı frekans ofseti (CFO) etkisini giderir.

### 🎯 NİÇİN YAPILIYOR?
- Kaba CFO düzeltmesi mükemmel olmadığı için kalan ofseti düzeltmek
- FFT öncesi sinyali düzeltmek ve alt-taşıyıcılar arası girişimi önlemek
- Kanal tahmini ve eşitleme için temiz sinyal sağlamak

### 🔍 NEREDE BAŞLAYIP BİTİYOR?

#### FAZ ROTASYONU:
```verilog
// Satır ~185-205: rotate modülü
rotate rotate_inst (
    .in_i(raw_i),              // Ham I kanalı
    .in_q(raw_q),              // Ham Q kanalı
    .phase(phase_correction),  // Faz düzeltme miktarı
    .input_strobe(raw_stb),
    ...
    .out_i(fft_in_re),        // Düzeltilmiş I
    .out_q(fft_in_im)         // Düzeltilmiş Q
);
```

#### FAZ GÜNCELLEME (Her Örnek İçin):
```verilog
// Satır ~330-365: S_FFT state içinde
if (raw_stb) begin
    if (phase_offset > 0) begin
        if (next_phase_correction > PI) begin
            phase_correction <= next_phase_correction - DOUBLE_PI;  // Wrapping
            if(in_offset == 63 && num_ofdm_symbol > 0)
                // Guard Interval için ekstra düzeltme
                next_phase_correction <= next_phase_correction - DOUBLE_PI 
                                       + phase_offset 
                                       + (short_gi ? phase_offset<<<3 : phase_offset<<<4);
            else
                next_phase_correction <= next_phase_correction - DOUBLE_PI + phase_offset;
        end else begin
            phase_correction <= next_phase_correction;
            ...
        end
    end
    ...
end
```

#### BİTİŞ:
```verilog
// Satır ~390-395: FFT'ye gönderilir
sample_out_strobe <= fft_valid;
sample_out <= fft_out;  // Düzeltilmiş ve FFT'lenmiş sinyal
```

### 📊 FORMÜL:
```
r_corrected(n) = r(n) * e^(-j*φ(n))
φ(n) = φ(n-1) + Δφ
Δφ = phase_offset (sync_short'tan)
```

---

## 4️⃣ KANAL TAHMİNCİSİ (Channel Estimator)

### 📂 Dosya: `equalizer.v`
### 📍 Satırlar: ~510-575 (LTS1), ~527-620 (LTS2), ~635-700 (smoothing)

### ❓ NE İŞE YARIYOR?
Long Training Symbol (LTS) kullanarak her alt-taşıyıcı için kanal yanıtını (H) tahmin eder. İki LTS'nin ortalamasını alır ve isteğe bağlı düzleştirme (smoothing) uygular.

### 🎯 NİÇİN YAPILIYOR?
- Kablosuz kanalda oluşan bozulmaları tespit etmek için
- Çok-yollu yayılım (multipath) etkilerini ölçmek için
- Kanal eşitleme (equalization) için gerekli H katsayılarını hesaplamak için

### 🔍 NEREDE BAŞLAYIP BİTİYOR?

#### BAŞLANGIÇ - Birinci LTS (S_FIRST_LTS):
```verilog
// Satır ~510-525: İlk LTS'yi sakla
S_FIRST_LTS: begin
    lts_in_stb <= sample_in_strobe;
    {lts_i_in, lts_q_in} <= sample_in;  // 64 alt-taşıyıcı
    
    if (lts_in_stb) begin
        if (lts_waddr == 63) begin
            state <= S_SECOND_LTS;
        end else begin
            lts_waddr <= lts_waddr + 1;
        end
    end
end
```

#### İkinci LTS ve Ortalama (S_SECOND_LTS):
```verilog
// Satır ~527-575: İkinci LTS ile ortalama al
S_SECOND_LTS: begin
    if (sample_in_strobe) begin
        calc_mean_strobe <= sample_in_strobe;
        {input_i, input_q} <= sample_in;      // LTS2
        current_sign <= lts_ref[0];            // Bilinen LTS referansı
        lts_ref <= {lts_ref[0], lts_ref[63:1]};
        lts_raddr <= lts_raddr + 1;
    end
    
    // calc_mean modülü: (LTS1 + LTS2) / 2 hesaplar
    lts_in_stb <= new_lts_stb;
    {lts_i_in, lts_q_in} <= {new_lts_i, new_lts_q};  // H_raw tahminleri
    ...
end
```

#### Kanal Tahmini Düzleştirme (S_SMOOTH_CH_DC ve S_SMOOTH_CH_LTS):
```verilog
// Satır ~635-660: DC yakını için düzleştirme
S_SMOOTH_CH_DC: begin
    if(lts_raddr == 4) begin
        lts_sum_i <= lts_sum_wo3_i;  // 4 örneklik ortalama
        lts_sum_q <= lts_sum_wo3_q;
        lts_mv_avg_len <= 4;
        lts_div_in_stb <= 1;
    end
    ...
end

// Satır ~670-720: Tüm alt-taşıyıcılar için düzleştirme
S_SMOOTH_CH_LTS: begin
    if(lts_raddr > 43 || lts_raddr < 29) begin
        lts_sum_i <= lts_sum_1_5_i;  // 5 örneklik ortalama
        lts_sum_q <= lts_sum_1_5_q;
        lts_mv_avg_len <= 5;
        lts_div_in_stb <= 1;
    end
    ...
    // Düzleştirme sonuçları lts_buf'a yazılır
end
```

#### BİTİŞ:
```verilog
// Kanal tahminleri lts_buf'ta saklanır (lts_i_out, lts_q_out)
// Daha sonra eşitleme için kullanılır (S_ALL_SC_PE_CORRECTION state'inde)
```

### 📊 FORMÜL:
```
Y(k) = H(k) * X(k) + N(k)
H_raw(k) = (LTS1(k) + LTS2(k)) / 2 / X_known(k)
H_smooth(k) = (1/L) * Σ H_raw(k+i)  ; i=-L/2 ... L/2
```

---

## 5️⃣ GÜRÜLTÜ GÜÇ TAHMİNCİSİ (Noise Power Estimator)

### 📂 Dosya: `equalizer.v`
### 📍 Satırlar: ~527-575 (örtük olarak S_SECOND_LTS içinde)

### ❓ NE İŞE YARIYOR?
İki LTS arasındaki farkı kullanarak gürültü gücünü tahmin eder. Bu, kanal kalitesini (SNR) belirlemek için kullanılır.

### 🎯 NİÇİN YAPILIYOR?
- Viterbi decoder için soft-decision metriklerinde kullanılabilir
- SNR (Signal-to-Noise Ratio) tahmininde kullanılabilir
- Link adaptasyonu ve hız kontrolü için
- Kanal kalitesi değerlendirmesi için

### 🔍 NEREDE BAŞLAYIP BİTİYOR?

#### ÖRTÜK HESAPLAMA:
```verilog
// Satır ~545-565: S_SECOND_LTS state içinde
// calc_mean modülü çağrılır:
calc_mean #(.DATA_WIDTH(16)) calc_mean_inst (
    .clock(clock),
    .enable(enable),
    .reset(reset|reset_internal),
    
    .old_i(lts_i_out),       // LTS1
    .old_q(lts_q_out),       // LTS1
    .new_i(input_i),         // LTS2
    .new_q(input_q),         // LTS2
    .sign(current_sign),
    .input_strobe(calc_mean_strobe),
    
    .mean_i(new_lts_i),      // (LTS1 + LTS2) / 2
    .mean_q(new_lts_q),      // (LTS1 + LTS2) / 2
    .output_strobe(new_lts_stb)
);

// calc_mean modülü içinde:
// diff_i = LTS2 - LTS1
// diff_q = LTS2 - LTS1
// noise_power ≈ E[|diff|²] / 2
```

#### KULLANIM:
```
NOT: Bu implementasyonda açık bir noise_power çıkışı bulunmuyor.
Ancak:
1. İki LTS'nin ortalaması alınarak gürültü etkisi azaltılır
2. Fark bilgisi kanal tahmini kalitesini dolaylı olarak etkiler
3. İleride soft-decision için eklenebilir
```

### 📊 FORMÜL:
```
N(k) = (LTS1(k) - LTS2(k))
σ²_noise ≈ E[|N(k)|²] / 2
SNR(k) = |H(k)|² / σ²_noise
```

### 💡 NOT:
Bu implementasyonda gürültü gücü **örtük** olarak hesaplanır. Eğer explicit bir noise power çıkışı gerekiyorsa, `calc_mean.v` modülüne aşağıdaki gibi ekleme yapılabilir:

```verilog
// calc_mean.v içinde eklenebilir:
output [31:0] noise_power,
output noise_power_stb

// Hesaplama:
wire [31:0] diff_i = new_i - old_i;
wire [31:0] diff_q = new_q - old_q;
wire [63:0] noise_sq = diff_i * diff_i + diff_q * diff_q;
assign noise_power = noise_sq >> 1;  // Bölme 2
```

---

## 📈 EK DÜZELTMELER (EQUALIZER'DA)

### ORTAK FAZ HATASI DÜZELTMESİ (CPE - Common Phase Error)
- **Dosya**: `equalizer.v`
- **Satırlar**: ~745-810 (S_CPE_ESTIMATE)
- **Amaç**: 4 pilot alt-taşıyıcı kullanarak kalan frekans ofsetini düzeltir

### DOĞRUSAL DEĞİŞEN FAZ HATASI (LVPE - Linear Varying Phase Error)
- **Dosya**: `equalizer.v`
- **Satırlar**: ~813-845 (S_LVPE_ESTIMATE)
- **Amaç**: Örnekleme frekans ofseti (SFO) etkisini kompanze eder

### KANAL EŞİTLEME (Channel Equalization)
- **Dosya**: `equalizer.v`
- **Satırlar**: ~848-905 (S_ALL_SC_PE_CORRECTION)
- **Amaç**: Y/H hesabı yaparak kanal etkilerini giderir

---

## 🔄 İŞLEM SIRASI

```
1. Power Trigger          → Paket başlangıcı
2. SYNC_SHORT             → Kaba CFO (phase_offset)
3. SYNC_LONG              
   - Symbol Timing        → FFT pencere başlangıcı
   - Fine CFO Correction  → Faz rotasyonu
   - FFT                  → Frekans domaine
4. EQUALIZER
   - Channel Estimation   → H(k) katsayıları (LTS1, LTS2)
   - Noise Estimation     → σ²_noise (örtük)
   - CPE Correction       → Pilot tabanlı RFO
   - LVPE Correction      → SFO kompanzasyonu
   - Equalization         → Y(k) / H(k)
5. DEMODULATOR            → Bit çıkarma
```

---

## 🎓 ÖZET TABLO

| Bileşen | Dosya | State/Satırlar | Giriş | Çıkış | Amaç |
|---------|-------|---------------|-------|-------|------|
| **Kaba CFO** | sync_short.v | ~200-280 | sample_in | phase_offset | Kaba frekans ofseti tahmini |
| **Sembol Zamanla** | sync_long.v | S_WAIT_FOR_FIRST_PEAK | sample_in | addr1 | FFT pencere başlangıcı |
| **İnce CFO** | sync_long.v | S_FFT, ~330-365 | phase_offset | rotated samples | Faz düzeltmesi |
| **Kanal Tahmini** | equalizer.v | S_FIRST/SECOND_LTS | FFT out | H(k) | Kanal yanıtı |
| **Gürültü Gücü** | equalizer.v | S_SECOND_LTS (örtük) | LTS1, LTS2 | implicit | SNR tahmini |
| **CPE** | equalizer.v | S_CPE_ESTIMATE | pilots | cpe | Kalan RFO |
| **LVPE** | equalizer.v | S_LVPE_ESTIMATE | pilot errors | PEG | SFO kompanzasyonu |
| **Eşitleme** | equalizer.v | S_ALL_SC_PE_CORRECTION | Y(k), H(k) | X(k) | Veri kurtarma |

---

## 📚 REFERANSLAR

- **802.11-2012 Standard**: WiFi fiziksel katman spesifikasyonları
- **OFDM Modülasyonu**: Orthogonal Frequency Division Multiplexing
- **CFO**: Carrier Frequency Offset (Taşıyıcı Frekans Ofseti)
- **SFO**: Sampling Frequency Offset (Örnekleme Frekans Ofseti)
- **LTS**: Long Training Sequence (Uzun Eğitim Dizisi)
- **CPE**: Common Phase Error (Ortak Faz Hatası)
- **LVPE**: Linear Varying Phase Error (Doğrusal Değişen Faz Hatası)

---

**Tarih**: 2026-01-24  
**Proje**: openwifi-hw/ip/openofdm_rx  
**Dil**: Türkçe
