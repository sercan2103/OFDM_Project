# Symbol Timing Estimator - Detaylı Algoritma Açıklaması

## 🎯 Genel Bakış

Symbol Timing Estimator, WiFi OFDM alıcısında **FFT penceresinin doğru başlangıç noktasını** bulmak için kullanılır. Bu, **Long Training Sequence (LTS)** ile **cross-correlation** yaparak gerçekleştirilir.

## 📐 Matematiksel Temel

### Cross-Correlation Formülü

Symbol timing estimation için kullanılan cross-correlation:

$$
R[n] = \sum_{k=0}^{N-1} r[n+k] \cdot L^*[k]
$$

Burada:
- $r[n]$ = Gelen sinyal (received samples)
- $L[k]$ = Bilinen LTS referansı
- $L^*[k]$ = LTS'nin complex conjugate'i
- $N = 32$ = Cross-correlation pencere boyutu
- $n$ = Zaman index'i

### Metric Hesaplama

Correlation metric (büyüklük):

$$
M[n] = |R[n]| = \sqrt{Re\{R[n]\}^2 + Im\{R[n]\}^2}
$$

Maksimum metric bulma:

$$
n_{opt} = \arg\max_n M[n]
$$

## 🔢 Fixed-Point Aritmetik

### Veri Formatı

**16-bit Signed Integer (Q15 Format)**

```
Sign bit: 1 bit
Integer: 15 bits
Range: [-32768, +32767]
Resolution: 2^(-15) ≈ 0.00003
```

### Complex Multiplication (Fixed-Point)

```matlab
% Input: a = a_i + j*a_q, b = b_i + j*b_q
% Output: c = a * b = c_i + j*c_q

% Real part
c_i = a_i * b_i - a_q * b_q

% Imaginary part
c_q = a_i * b_q + a_q * b_i
```

**Verilog Karşılığı** (`stage_mult.v`):
```verilog
// 8-parallel complex multiplier
complex_multiplier mult_inst1 (
  .s_axis_a_tdata({X0_i, X0_q}),
  .s_axis_b_tdata({Y0_i, Y0_q}),
  .m_axis_dout_tdata({prod_0_q, prod_0_i})
);
```

### Overflow ve Saturation

```matlab
% Multiplication sonrası 32-bit accumulation
sum_i = int32(0);
sum_q = int32(0);

for k = 1:32
    prod_i = int32(buf_i(k)) * int32(ref_i(k)) - ...
             int32(buf_q(k)) * int32(ref_q(k));
    prod_q = int32(buf_i(k)) * int32(ref_q(k)) + ...
             int32(buf_q(k)) * int32(ref_i(k));
    
    sum_i = sum_i + prod_i;  % 32-bit accumulation
    sum_q = sum_q + prod_q;
end

% Magnitude: sqrt(sum_i^2 + sum_q^2)
metric = sqrt(double(sum_i)^2 + double(sum_q)^2);
```

## 🔄 Algoritma Akışı

### State Machine (Verilog: sync_long.v)

```
┌─────────────────┐
│   S_SKIPPING    │  Skip short preamble tail (32 samples)
└────────┬────────┘
         ▼
┌─────────────────────────┐
│ S_WAIT_FOR_FIRST_PEAK  │  Cross-correlation (88 samples)
└────────┬────────────────┘
         ▼
┌─────────────────┐
│     S_FFT       │  FFT processing
└─────────────────┘
```

### MATLAB Implementation Steps

```matlab
Step 1: Buffer Management
├── 32-sample sliding window
├── FIFO structure (shift register)
└── New sample → buffer[0], shift others

Step 2: Cross-Correlation
├── For each sample position (n = 1 to 88)
│   ├── Load 32 samples from buffer
│   ├── Multiply with LTS reference (32 complex mults)
│   └── Accumulate products → R[n]
└── Calculate magnitude → M[n]

Step 3: Peak Detection
├── Track maximum: metric_max
├── Track position: best_addr
└── If M[n] > metric_max → update both

Step 4: Timing Decision
├── After 88 samples processed
├── detected = true
└── timing_offset = best_addr - 32
```

## 📊 LTS Referans Değerleri

### Frequency Domain (64-point)

LTS frekans domaininde tanımlı:

```matlab
L_{-26,26} = [1  1 -1 -1  1  1 -1  1 -1  1  1  1  1  1  1 -1 -1 ...
              1  1 -1  1 -1  1  1  1  1  0  1 -1 -1  1  1 -1  1 ...
             -1  1 -1 -1 -1 -1 -1  1  1 -1 -1  1 -1  1 -1  1  1  1  1]
```

### Time Domain (32 samples used in correlation)

Verilog `sync_long.v` do_mult task'inde kullanılan değerler:

```matlab
LTS_time_ref = [
    156+0i,    -5+120i,   40+111i,    97-83i,     % Index 0-3
     21-28i,    60+88i,  -115+55i,   -38+106i,    % Index 4-7
     98+26i,    53-4i,      1+115i,  -137+47i,    % Index 8-11
     24+59i,    59+15i,   -22-161i,   119+4i,     % Index 12-15
     62+62i,    37-98i,   -57-39i,  -131-65i,     % Index 16-19
     82-92i,    70-14i,   -60-81i,   -56+22i,     % Index 20-23
    -35+151i, -122+17i,  -127+21i,    75+74i,     % Index 24-27
     -3-54i,   -92-115i,   92-106i,    12-98i      % Index 28-31
];
```

**Not**: Bu değerler IFFT(LTS_freq)'in ilk 32 sample'ı

## ⚙️ Parametreler ve Ayarlar

### Verilog Parametreleri

```verilog
// sync_long.v
parameter IN_BUF_LEN_SHIFT = 8;        // Buffer size = 2^8 = 256
parameter NUM_STS_TAIL = 32;           // Short preamble tail
localparam CROSS_CORR_BUF_SIZE = 32;   // Correlation window
localparam NUM_SAMPLES = 88;            // Processing window
```

### MATLAB Karşılıkları

```matlab
WORD_WIDTH = 16;                % 16-bit fixed-point
CROSS_CORR_BUF_SIZE = 32;       % Buffer size
NUM_SAMPLES_TO_PROCESS = 88;    % Search window
```

## 🎲 4-Stage Parallel Processing (Verilog)

Verilog implementasyonu **paralel işlem** yapar:

```
Stage 0: Process samples [0-7]   (8 complex multiplications)
Stage 1: Process samples [8-15]  (8 complex multiplications)
Stage 2: Process samples [16-23] (8 complex multiplications)
Stage 3: Process samples [24-31] (8 complex multiplications)

Total: 32 complex multiplications in 4 stages
Latency: 5 clock cycles (stage_mult.v)
```

**MATLAB** sequential işlem yapar:
```matlab
for k = 1:32
    % One multiplication at a time
end
```

**Sonuç**: Aynı, sadece timing farklı

## 📈 Performance Metrikleri

### Timing Accuracy

Teorik:
- Perfect channel: ±0 sample
- SNR > 20 dB: ±1 sample
- SNR = 10 dB: ±2 samples

### Computational Complexity

**Per Sample**:
- Complex multiplications: 32
- Complex additions: 31
- Magnitude calculation: 1 (sqrt)

**Total (88 samples)**:
- ~2800 complex multiplications
- ~2700 complex additions

### Latency (Verilog)

```
Buffer fill:           32 cycles
Cross-correlation:     88 × 4 = 352 cycles
Peak detection:        1 cycle
Total:                 ~385 clock cycles
```

At 20 MHz clock: ~19.25 μs

## 🔍 Debug ve Troubleshooting

### Common Issues

**1. Metric çok düşük**
```matlab
% Kontrol: LTS reference doğru mu?
plot(abs(LTS_ref));  % Uniform olmamalı
```

**2. Wrong timing detection**
```matlab
% Kontrol: FFT window shift
fft_win_shift = 0;  % Genellikle 0 olmalı
```

**3. Fixed-point overflow**
```matlab
% Kontrol: Input scaling
max_val = max(abs(samples_in));
if max_val > 32767
    warning('Input overflow!');
end
```

### Visualization Tips

```matlab
% 1. Correlation metric plot
plot(metric_values);
xlabel('Sample Index'); ylabel('Metric');
title('Cross-Correlation Metric');

% 2. Find peak
[peak_val, peak_idx] = max(metric_values);
hold on; plot(peak_idx, peak_val, 'ro');

% 3. Check peak-to-average ratio
PAR = 10*log10(peak_val / mean(metric_values));
fprintf('Peak-to-Average Ratio: %.2f dB\n', PAR);
% Good: > 10 dB
```

## 🧮 Karşılaştırma: MATLAB vs Verilog

| Özellik | MATLAB | Verilog |
|---------|--------|---------|
| **Aritmetik** | int16/int32 | 16-bit fixed |
| **Multiplication** | Sequential | 8-parallel |
| **Magnitude** | `sqrt(i^2+q^2)` | CORDIC |
| **Memory** | Array | Dual-port RAM |
| **Timing** | Functional | Cycle-accurate |
| **Speed** | ~ms | ~20 μs |

### Doğruluk Karşılaştırması

```matlab
% Test aynı input ile:
input_samples = randn(200,1) + 1i*randn(200,1);
input_fp = convert_to_fixed_point(input_samples, 16);

% MATLAB
[det_matlab, off_matlab, ~] = symbol_timing_estimator(input_fp, 0);

% Verilog simulation results
det_verilog = 1;   % From testbench
off_verilog = 42;  % From testbench

% Compare
assert(det_matlab == det_verilog, 'Detection mismatch!');
assert(abs(off_matlab - off_verilog) <= 1, 'Timing mismatch!');
```

## 📚 Referanslar

1. **IEEE 802.11-2012** - Section 18.3.3: OFDM training structure
2. **sync_long.v** - Lines 100-650: Cross-correlation implementation
3. **stage_mult.v** - Lines 1-206: Parallel multiplier
4. **Schmidl & Cox (1997)** - "Robust Frequency and Timing Synchronization for OFDM"

---
**Not**: Bu dokümantasyon, Verilog implementasyonunun MATLAB referansı içindir.
