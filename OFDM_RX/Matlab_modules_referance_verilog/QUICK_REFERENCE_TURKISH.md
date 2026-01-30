# OFDM Alıcı Bileşenleri - Hızlı Referans

Bu döküman, her bileşenin **tam satır numaralarını** ve **anahtar kod parçalarını** içerir.

---

## 1. KABA CFO TAHMİNCİSİ (Coarse CFO Estimator)

### 📂 Dosya: `sync_short.v`

### Başlangıç: Satır ~145
```verilog
complex_mult delay_prod_inst (
    .clock(clock),
    .enable(enable),
    .reset(reset),
    .a_i(sample_in[31:16]),
    .a_q(sample_in[15:0]),
    .b_i(sample_delayed_conj[31:16]),
    .b_q(sample_delayed_conj[15:0]),
    .input_strobe(sample_delayed_conj_stb),
    .p_i(prod[63:32]),
    .p_q(prod[31:0]),
    .output_strobe(prod_stb)
);
```

### Frekans Ofseti Hesaplama: Satır ~200-220
```verilog
// ========== KABA CFO TAHMİNCİSİ (COARSE CFO ESTIMATOR) ==========
mv_avg_dual_ch #(.DATA_WIDTH0(32), .DATA_WIDTH1(32), .LOG2_AVG_LEN(6)) freq_offset_inst (
    .clk(clock),
    .rstn(~(reset|reset_delay1|reset_delay2|reset_delay3|reset_delay4)),
    
    .data_in0(prod[63:32]),
    .data_in1(prod[31:0]),
    .data_in_valid(prod_stb),

    .data_out0(phase_in_i),
    .data_out1(phase_in_q),
    .data_out_valid(phase_in_stb)
);
```

### Faz Hesaplama: Satır ~195
```verilog
phase phase_inst (
    .clock(clock),
    .reset(reset),
    .enable(enable),
    .i(phase_in_i),
    .q(phase_in_q),
    .input_strobe(phase_in_stb),
    .phase(phase_out),
    .phase_stb(phase_out_stb)
);
```

### Çıkış (phase_offset): Satır ~270-280
```verilog
if (has_pos && has_neg && demod_is_ongoing==0) begin
    if(phase_out_neg[3] == 0)
        phase_offset <= {{4{phase_out_neg[15]}}, phase_out_neg[15:4]};
    else
        phase_offset <= ~phase_offset_neg + 1;
end
```

**ÖNEMLİ**: `phase_offset` çıkışı `sync_long.v` modülüne gönderilir.

---

## 2. SEMBOL ZAMANLAMA TAHMİNCİSİ (Symbol Timing Estimator)

### 📂 Dosya: `sync_long.v`

### Buffer Tanımı: Satır ~90
```verilog
// ========== BAŞLANGIÇ: SEMBOL ZAMANLAMA TAHMİNCİSİ ==========
// Cross-correlation buffer for LTS (Long Training Symbol) detection
reg [31:0] cross_corr_buf[0:31];
```

### Stage Multiplier: Satır ~110-135
```verilog
stage_mult stage_mult_inst (
    .clock(clock),
    .enable(enable),
    .reset(reset),

    .X0(stage_X0), .X1(stage_X1), .X2(stage_X2), .X3(stage_X3),
    .X4(stage_X4), .X5(stage_X5), .X6(stage_X6), .X7(stage_X7),

    .Y0(stage_Y0), .Y1(stage_Y1), .Y2(stage_Y2), .Y3(stage_Y3),
    .Y4(stage_Y4), .Y5(stage_Y5), .Y6(stage_Y6), .Y7(stage_Y7),

    .input_strobe(mult_strobe),

    .sum({stage_sum_i, stage_sum_q}),
    .output_strobe(stage_sum_stb)
);
```

### Metric Hesaplama: Satır ~70-80
```verilog
complex_to_mag #(.DATA_WIDTH(32)) sum_mag_inst (
    .clock(clock),
    .enable(enable),
    .reset(reset),

    .i(sum_i),
    .q(sum_q),
    .input_strobe(sum_stb),

    .mag(metric),
    .mag_stb(metric_stb)
);
```

### Maksimum Bulma: Satır ~285-295 (S_WAIT_FOR_FIRST_PEAK state)
```verilog
S_WAIT_FOR_FIRST_PEAK: begin
    // ========== SEMBOL ZAMANLAMA TAHMİNCİSİ: Çapraz-korelasyon yürütme ==========
    do_mult();

    if (metric_stb && (metric > metric_max1)) begin
        metric_max1 <= metric;
        addr1 <= in_raddr - 1 - fft_win_shift;
    end

    if (num_sample >= 88) begin
        long_preamble_detected <= 1;
        num_sample <= 0;
        mult_strobe <= 0;
        sum_stb <= 0;
        in_raddr <= addr1 - 32;
        num_input_consumed <= addr1 - 32;
        in_offset <= 0;
        num_ofdm_symbol <= 0;
        phase_correction <= 0;
        next_phase_correction <= phase_offset;
        phase_offset_taken <= phase_offset;
        state <= S_FFT;
    end
    ...
end
```

### Do_Mult Task: Satır ~410-550
```verilog
// ========== BAŞLANGIÇ: SEMBOL ZAMANLAMA TAHMİNCİSİ TASK ==========
task do_mult; begin
    // cross correlation of the first 16 samples of LTS
    if (sample_in_strobe) begin
        cross_corr_buf[31] <= sample_in;
        for (do_mult_i = 0; do_mult_i < 31; do_mult_i = do_mult_i+1) begin
            cross_corr_buf[do_mult_i] <= cross_corr_buf[do_mult_i+1];
        end

        sum_stage <= 0;
        sum_i <= 0;
        sum_q <= 0;
        sum_stb <= 0;

        stage_X0 <= cross_corr_buf[1];
        stage_X1 <= cross_corr_buf[2];
        ...
        stage_X7 <= cross_corr_buf[8];

        // LTS reference values (known long training sequence)
        stage_Y0 <= { 16'd156, 16'd0};
        stage_Y1 <= {-16'd5,   16'd120};
        stage_Y2 <= { 16'd40,  16'd111};
        ...
        stage_Y7 <= {-16'd38,  16'd106};

        mult_strobe <= 1;
        mult_stage <= 1;
    end
    ...
end
endtask
```

---

## 3. İNCE CFO DÜZELTMESİ (Fine CFO Correction)

### 📂 Dosya: `sync_long.v`

### Rotate Modülü: Satır ~185-205
```verilog
// ========== BAŞLANGIÇ: İNCE CFO DÜZELTMESİ (Phase Rotation) ==========
rotate rotate_inst (
    .clock(clock),
    .enable(enable),
    .reset(reset),

    .in_i(raw_i),
    .in_q(raw_q),
    .phase(phase_correction),
    .input_strobe(raw_stb),

    .rot_addr(rot_addr),
    .rot_data(rot_data),
    
    .out_i(fft_in_re),
    .out_q(fft_in_im),
    .output_strobe(fft_in_stb)
);
// ========== SON: İNCE CFO DÜZELTMESİ (Phase Rotation) ==========
```

### Faz Güncelleme (Her Örnek): Satır ~330-365
```verilog
// ========== BAŞLANGIÇ: İNCE CFO DÜZELTMESİ (Phase Update Per Sample) ==========
if (raw_stb) begin
    if (phase_offset > 0) begin
        if (next_phase_correction > PI) begin
            phase_correction <= next_phase_correction - DOUBLE_PI;
            if(in_offset == 63 && num_ofdm_symbol > 0)
                next_phase_correction <= next_phase_correction - DOUBLE_PI 
                                       + phase_offset 
                                       + (short_gi ? phase_offset<<<3 : phase_offset<<<4);
            else
                next_phase_correction <= next_phase_correction - DOUBLE_PI + phase_offset;
        end else begin
            phase_correction <= next_phase_correction;
            if(in_offset == 63 && num_ofdm_symbol > 0)
                next_phase_correction <= next_phase_correction 
                                       + phase_offset 
                                       + (short_gi ? phase_offset<<<3 : phase_offset<<<4);
            else
                next_phase_correction <= next_phase_correction + phase_offset;
        end
    end else begin
        if (next_phase_correction < -PI) begin
            phase_correction <= next_phase_correction + DOUBLE_PI;
            ...
        end else begin
            phase_correction <= next_phase_correction;
            ...
        end
    end
end
// ========== SON: İNCE CFO DÜZELTMESİ (Phase Update Per Sample) ==========
```

### FFT Çıkışı: Satır ~390-395
```verilog
sample_out_strobe <= fft_valid;
sample_out <= fft_out;
```

---

## 4. KANAL TAHMİNCİSİ (Channel Estimator)

### 📂 Dosya: `equalizer.v`

### S_FIRST_LTS State: Satır ~510-525
```verilog
S_FIRST_LTS: begin
    // ========== KANAL TAHMİNCİSİ BAŞLANGICI: Birinci LTS ==========
    lts_in_stb <= sample_in_strobe;
    {lts_i_in, lts_q_in} <= sample_in;

    if (lts_in_stb) begin
        if (lts_waddr == 63) begin
            lts_waddr <= 0;
            lts_raddr <= 0;
            state <= S_SECOND_LTS;
        end else begin
            lts_waddr <= lts_waddr + 1;
        end
    end
end
```

### S_SECOND_LTS State: Satır ~527-575
```verilog
S_SECOND_LTS: begin
    // ========== KANAL TAHMİNCİSİ: İkinci LTS ve Ortalama ==========
    // KANAL MODELİ: Y = H * X + N
    // KANAL TAHMİNİ: H_est = Y / X = (LTS1 + LTS2) / 2 / lts_ref
    
    if (sample_in_strobe) begin
        calc_mean_strobe <= sample_in_strobe;
        {input_i, input_q} <= sample_in;
        current_sign <= lts_ref[0];
        lts_ref <= {lts_ref[0], lts_ref[63:1]};
        lts_raddr <= lts_raddr + 1;
    end else begin
        calc_mean_strobe <= 0;
    end

    lts_in_stb <= new_lts_stb;
    {lts_i_in, lts_q_in} <= {new_lts_i, new_lts_q};

    if (lts_in_stb) begin
        if (lts_waddr == 63) begin
            lts_waddr <= 0;
            lts_raddr <= 62;
            lts_in_stb <= 0;
            lts_div_in_stb <= 0;
            state <= (disable_all_smoothing?S_GET_POLARITY:S_SMOOTH_CH_DC);
        end else begin
            lts_waddr <= lts_waddr + 1;
        end
    end
end
```

### Calc_Mean Modülü: Satır ~235-255
```verilog
calc_mean #(.DATA_WIDTH(16)) calc_mean_inst (
    .clock(clock),
    .enable(enable),
    .reset(reset|reset_internal),

    .old_i(lts_i_out),
    .old_q(lts_q_out),
    .new_i(input_i),
    .new_q(input_q),
    .sign(current_sign),
    .input_strobe(calc_mean_strobe),

    .mean_i(new_lts_i),
    .mean_q(new_lts_q),
    .output_strobe(new_lts_stb)
);
```

### S_SMOOTH_CH_DC State: Satır ~635-660
```verilog
// ========== KANAL TAHMİNİ DÜZLEŞTİRME (DC) ==========
S_SMOOTH_CH_DC: begin
    if(lts_div_in_stb == 1) begin
        lts_div_in_stb <= 0;
    end else if(lts_raddr == 4) begin
        lts_sum_i <= lts_sum_wo3_i;
        lts_sum_q <= lts_sum_wo3_q;
        lts_mv_avg_len <= 4;
        lts_div_in_stb <= 1;
        lts_raddr <= 5;
    end else if(lts_raddr != 5) begin
        // LTS Shift register
        lts_reg1_i <= lts_i_out; 
        lts_reg2_i <= lts_reg1_i; 
        lts_reg3_i <= lts_reg2_i; 
        lts_reg4_i <= lts_reg3_i; 
        lts_reg5_i <= lts_reg4_i;
        ...
        lts_raddr[5:0] <= lts_raddr[5:0] + 1;
    end
    ...
end
```

### S_SMOOTH_CH_LTS State: Satır ~670-720
```verilog
// ========== KANAL TAHMİNİ DÜZLEŞTİRME (All Subcarriers) ==========
S_SMOOTH_CH_LTS: begin
    if(lts_raddr == 42) begin
        lts_sum_i <= lts_sum_1_3_i;
        lts_sum_q <= lts_sum_1_3_q;
        lts_mv_avg_len <= 3;
        lts_div_in_stb <= 1;
    end else if(lts_raddr == 43) begin
        lts_sum_i <= lts_sum_1_4_i;
        lts_sum_q <= lts_sum_1_4_q;
        lts_mv_avg_len <= 4;
        lts_div_in_stb <= 1;
    end else if(lts_raddr > 43 || lts_raddr < 29) begin
        lts_sum_i <= lts_sum_1_5_i;
        lts_sum_q <= lts_sum_1_5_q;
        lts_mv_avg_len <= 5;
        lts_div_in_stb <= 1;
    end
    ...
end
```

### LTS Buffer (Kanal Katsayıları): Satır ~215-225
```verilog
ram_2port #(.DWIDTH(32), .AWIDTH(6)) lts_buf (
    .clka(clock),
    .ena(1),
    .wea(lts_in_stb),
    .addra(lts_waddr),
    .dia({lts_i_in, lts_q_in}),
    .doa(),

    .clkb(clock),
    .enb(1),
    .web(1'b0),
    .addrb(lts_raddr),
    .dib(32'hFFFF),
    .dob({lts_i_out, lts_q_out})  // Kanal katsayıları H(k)
);
```

---

## 5. GÜRÜLTÜ GÜÇ TAHMİNCİSİ (Noise Power Estimator)

### 📂 Dosya: `equalizer.v`

### Örtük Hesaplama: Satır ~527-575 (S_SECOND_LTS içinde)
```verilog
S_SECOND_LTS: begin
    // ========== GÜRÜLTÜ GÜÇ TAHMİNCİSİ (ÖRTÜK) ==========
    // NE İŞE YARIYOR:
    // - LTS1 ve LTS2 arasındaki fark gürültü + kanal değişimini içerir
    // - Var(LTS2 - LTS1) / 2 ≈ Gürültü Gücü
    // - calc_mean içinde örtük olarak hesaplanır
    
    if (sample_in_strobe) begin
        calc_mean_strobe <= sample_in_strobe;
        {input_i, input_q} <= sample_in;       // LTS2
        current_sign <= lts_ref[0];
        lts_ref <= {lts_ref[0], lts_ref[63:1]};
        lts_raddr <= lts_raddr + 1;            // LTS1'i oku
    end
    ...
end
```

### Calc_Mean Modülü (Gürültü Hesaplama):
`calc_mean.v` dosyasında (referans için):
```verilog
// calc_mean.v içinde:
wire signed [DATA_WIDTH:0] diff_i = new_i - old_i;  // LTS2 - LTS1
wire signed [DATA_WIDTH:0] diff_q = new_q - old_q;  // LTS2 - LTS1

// mean_i = (old_i + new_i * sign) / 2
// mean_q = (old_q + new_q * sign) / 2

// Gürültü gücü örtük olarak:
// noise_power ≈ E[|diff_i|² + |diff_q|²] / 2
```

**NOT**: Bu implementasyonda explicit bir `noise_power` çıkışı bulunmuyor. 
Ancak iki LTS'nin ortalaması alınarak gürültü etkisi azaltılır.

---

## 6. ORTAK FAZ HATASI (CPE - Common Phase Error)

### 📂 Dosya: `equalizer.v`

### S_CPE_ESTIMATE State: Satır ~745-810
```verilog
S_CPE_ESTIMATE: begin
    // ========== ORTAK FAZ HATASI (CPE) TAHMİNİ ==========
    // 4 pilot alt-taşıyıcı kullanarak kalan frekans ofsetini tahmin eder
    // Pilot pozisyonları: -21, -7, +7, +21
    
    if (sample_in_strobe) begin
        in_waddr <= in_waddr + 1;
        lts_raddr <= lts_raddr + 1;

        pilot_mask <= {pilot_mask[0], pilot_mask[63:1]};
        if (pilot_mask[0]) begin
            pilot_count1 <= pilot_count1 + 1;
            // obtain the conjugate of current pilot sub carrier
            if (current_polarity[pilot_count1] == 0) begin
                input_i <= sample_in[31:16];
                input_q <= ~sample_in[15:0] + 1;
            end else begin
                input_i <= ~sample_in[31:16] + 1;
                input_q <= sample_in[15:0];
            end
            pilot_in_stb <= 1;
        end else begin
            pilot_in_stb <= 0;
        end
    end
    ...
    
    if (pilot_out_stb) begin
        pilot_sum_i <= pilot_sum_i + pilot_i;
        pilot_sum_q <= pilot_sum_q + pilot_q;
        pilot_count2 <= pilot_count2 + 1; 
    end else if (pilot_count2 == 4) begin
        pilot_i_reg <= pilot_sum_i;
        pilot_q_reg <= pilot_sum_q; 
        phase_in_stb <= 1;
        pilot_count2 <= 0; 
    end
    
    if (phase_out_stb) begin
        cpe <= phase_out;  // Ortak faz hatası
        ...
    end
end
```

---

## 7. DOĞRUSAL DEĞİŞEN FAZ HATASI (LVPE)

### 📂 Dosya: `equalizer.v`

### S_LVPE_ESTIMATE State: Satır ~813-845
```verilog
S_LVPE_ESTIMATE: begin
    // ========== DOĞRUSAL DEĞİŞEN FAZ HATASI (LVPE) TAHMİNİ ==========
    // SFO'nun (Sampling Frequency Offset) frekans boyunca doğrusal etkisini tahmin eder
    
    if (pilot_count1 < 4) begin
        // sampling rate offset (SFO) is calculated as pilot phase error
        if(pilot_iq_phase[pilot_count1] < -1608) begin
            pilot_phase_err <= pilot_iq_phase[pilot_count1] + 3217;
        end else if(pilot_iq_phase[pilot_count1] > 1608) begin
            pilot_phase_err <= pilot_iq_phase[pilot_count1] - 3217;
        end else begin
            pilot_phase_err <= pilot_iq_phase[pilot_count1];
        end

        pilot_count1 <= pilot_count1 + 1;
    end

    if(pilot_count1 == 1) begin
        Sxy <= Sxy + 7*pilot_phase_err;
    end else if(pilot_count1 == 2) begin
        Sxy <= Sxy + 21*pilot_phase_err;
    end else if(pilot_count1 == 3) begin
        Sxy <= Sxy + -21*pilot_phase_err;
    end else if(pilot_count1 == 4) begin
        Sxy <= Sxy + -7*pilot_phase_err;

        in_raddr <= 0; 
        sym_idx <= 0;
        sym_idx2 <= 1; 
        lvpe_in_stb <= 0;
        lts_raddr <= 1;
        rot_in_stb <= 0;
        num_output <= 0;
        state <= S_ALL_SC_PE_CORRECTION;
    end
    // Sx² = 7² + 21² + (-21)² + (-7)² = 980
    // PEG (Phase Error Gradient) = Sxy / Sx²
end
```

### LVPE Divider: Satır ~385-395
```verilog
divider lvpe_inst (
    .clock(clock),
    .enable(enable),
    .reset(reset|reset_internal),

    .dividend(lvpe_dividend),   // sym_idx * Sxy
    .divisor(lvpe_divisor),     // Sx² = 980
    .input_strobe(lvpe_in_stb),

    .quotient(lvpe),            // LVPE(k) = k * Sxy / 980
    .output_strobe(lvpe_out_stb)
);
```

---

## 8. KANAL EŞİTLEME (Channel Equalization)

### 📂 Dosya: `equalizer.v`

### S_ALL_SC_PE_CORRECTION State: Satır ~848-905
```verilog
S_ALL_SC_PE_CORRECTION: begin
    // ========== TÜM ALT-TAŞIYICILAR İÇİN FAZ HATASI DÜZELTMESİ VE EŞİTLEME ==========
    
    if (sym_idx < 64) begin
        sym_idx <= sym_idx + 1;
        lvpe_in_stb <= 1;
    end else begin
        lvpe_in_stb <= 0;
    end

    // first rotate, then normalize by avg LTS
    if (lvpe_out_stb) begin
        sym_idx2 <= sym_idx2 + 1; 
        phase_err <= {cpe[15], cpe[15], cpe[15:0]} + lvpe[17:0] + peg_sym_scale[17:0];
        rot_in_stb <= 1;
        in_raddr <= in_raddr + 1;
        if (sym_idx2 == 32) begin
            prev_peg_reg <= prev_peg_reg + (lvpe >>> 5); 
        end
    end else begin
        rot_in_stb <= 0;
    end

    if (rot_out_stb) begin
        lts_raddr <= lts_raddr + 1;
    end

    if (norm_out_stb) begin
        data_subcarrier_mask <= {data_subcarrier_mask[0], data_subcarrier_mask[63:1]};
        if (data_subcarrier_mask[0]) begin
            sample_out_strobe <= 1;
            sample_out <= {norm_i[31], norm_i[14:0], norm_q[31], norm_q[14:0]};
            num_output <= num_output + 1;
        end else begin
            sample_out_strobe <= 0;
        end
    end else begin
        sample_out_strobe <= 0;
    end

    if (num_output == num_data_carrier) begin
        prev_peg <= prev_peg_reg; 
        state <= S_GET_POLARITY;
    end
end
```

### Rotate Modülü: Satır ~310-325
```verilog
rotate rotate_inst (
    .clock(clock),
    .enable(enable),
    .reset(reset|reset_internal),

    .in_i(buf_i_out),
    .in_q(buf_q_out),
    .phase(sym_phase[15:0]),  // phase_err = cpe + lvpe + peg
    .input_strobe(rot_in_stb),

    .rot_addr(rot_addr),
    .rot_data(rot_data),
    
    .out_i(rot_i),
    .out_q(rot_q),
    .output_strobe(rot_out_stb)
);
```

### Normalizasyon (Y/H): Satır ~355-380
```verilog
divider norm_i_inst (
    .clock(clock),
    .enable(enable),
    .reset(reset|reset_internal),

    .dividend(dividend_i),      // Rotated I
    .divisor(divisor_i),        // |H|²
    .input_strobe(div_in_stb),

    .quotient(quotient_i),      // I_out
    .output_strobe(div_out_stb)
);

divider norm_q_inst (
    .clock(clock),
    .enable(enable),
    .reset(reset|reset_internal),

    .dividend(dividend_q),      // Rotated Q
    .divisor(divisor_q),        // |H|²
    .input_strobe(div_in_stb),

    .quotient(quotient_q)       // Q_out
);
```

---

## 🔄 ÖZET: VERİ AKIŞI ve SATIR NUMARALARI

```
1. sample_in (RF → ADC → I/Q)
   ↓
2. sync_short.v
   • Satır ~145: complex_mult (16 örnek delay)
   • Satır ~200: freq_offset_inst (64 örnek avg)
   • Satır ~270: phase_offset çıkışı
   ↓
3. sync_long.v
   • Satır ~90: cross_corr_buf[0:31]
   • Satır ~285: S_WAIT_FOR_FIRST_PEAK (max bulma)
   • Satır ~185: rotate_inst (CFO correction)
   • Satır ~330: Phase update per sample
   • Satır ~390: FFT output
   ↓
4. equalizer.v
   • Satır ~510: S_FIRST_LTS (H1 buffer)
   • Satır ~527: S_SECOND_LTS (H2, noise implicit)
   • Satır ~635: S_SMOOTH_CH_DC (smoothing)
   • Satır ~670: S_SMOOTH_CH_LTS (smoothing)
   • Satır ~745: S_CPE_ESTIMATE (RFO)
   • Satır ~813: S_LVPE_ESTIMATE (SFO)
   • Satır ~848: S_ALL_SC_PE_CORRECTION (Y/H)
   ↓
5. sample_out → demodulator
```

---

## 📊 ANAHTAR DEĞİŞKENLER

| Değişken | Dosya | Anlamı |
|----------|-------|--------|
| `phase_offset` | sync_short.v, satır ~270 | Kaba CFO tahmini |
| `addr1` | sync_long.v, satır ~290 | FFT pencere başlangıcı |
| `phase_correction` | sync_long.v, satır ~330 | İnce CFO düzeltme miktarı |
| `lts_i_out, lts_q_out` | equalizer.v, satır ~220 | Kanal katsayıları H(k) |
| `cpe` | equalizer.v, satır ~800 | Ortak faz hatası |
| `Sxy` | equalizer.v, satır ~835 | LVPE gradyent |
| `lvpe` | equalizer.v, satır ~390 | Doğrusal faz hatası |
| `sample_out` | equalizer.v, satır ~890 | Eşitlenmiş veri |

---

**Güncelleme**: 2026-01-24  
**Proje**: openwifi-hw/ip/openofdm_rx  
**Not**: Tüm satır numaraları yaklaşıktır, yorum eklendikten sonra kaymış olabilir.
