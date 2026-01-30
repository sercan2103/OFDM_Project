# OFDM Alıcı Mimarisi - Görsel Diyagram

Bu döküman, OFDM alıcısının blok diyagramını ve veri akışını görsel olarak gösterir.

---

## 📊 GENEL MİMARİ

```
┌─────────────────────────────────────────────────────────────────────────┐
│                         OFDM ALICI MİMARİSİ                             │
└─────────────────────────────────────────────────────────────────────────┘

RF Sinyal (sample_in)
    │
    │ I/Q Samples (32-bit)
    ↓
┌─────────────────────┐
│  POWER_TRIGGER      │ ← power_thres, min_plateau
│  (power_trigger.v)  │
└─────────────────────┘
    │ short_preamble_start
    ↓
┌─────────────────────────────────────────────────────────────────────────┐
│                     1️⃣ SYNC_SHORT MOD DUL                               │
│  (sync_short.v)                                                         │
│                                                                          │
│  ┌──────────────┐    ┌──────────────┐    ┌──────────────┐             │
│  │ Delay 16     │───>│ Complex Mult │───>│ Moving Avg   │             │
│  │ samples      │    │ (Auto-corr)  │    │ (64 samples) │             │
│  └──────────────┘    └──────────────┘    └──────────────┘             │
│                            │                     │                      │
│                            │                     ↓                      │
│                            │              ┌──────────────┐             │
│                            │              │    Phase     │             │
│                            │              │  Calculator  │             │
│                            │              └──────────────┘             │
│                            │                     │                      │
│                            ↓                     ↓                      │
│                      [Plateau Det]         phase_offset                │
│                            │                (Coarse CFO)               │
│                            ↓                                            │
│                  short_preamble_detected                               │
└─────────────────────────────────────────────────────────────────────────┘
    │ phase_offset (Kaba CFO: ±312.5 kHz'e kadar)
    ↓
┌─────────────────────────────────────────────────────────────────────────┐
│                     2️⃣ SYNC_LONG MODULU                                 │
│  (sync_long.v)                                                          │
│                                                                          │
│  ┌────────────────────────────────────────────────────────────────┐   │
│  │  SEMBOL ZAMANLAMA TAHMİNCİSİ (Symbol Timing Estimator)         │   │
│  │                                                                  │   │
│  │  ┌─────────────┐    ┌──────────────┐    ┌────────────┐       │   │
│  │  │ Cross-Corr  │───>│  Stage Mult  │───>│   Metric   │       │   │
│  │  │ Buffer[32]  │    │  (8 parallel)│    │ (Magnitude)│       │   │
│  │  └─────────────┘    └──────────────┘    └────────────┘       │   │
│  │        │                    │                    │             │   │
│  │        │    ┌───────────────┘                    │             │   │
│  │        │    │ Known LTS Values                   ↓             │   │
│  │        │    │ (156, -5+120j, ...)        ┌──────────────┐    │   │
│  │        │    │                            │  Find Max    │    │   │
│  │        │    │                            │  metric_max1 │    │   │
│  │        │    │                            │  addr1       │    │   │
│  │        │    │                            └──────────────┘    │   │
│  └────────┼────┼──────────────────────────────────┬─────────────┘   │
│           │    │                                   │                  │
│           │    │                  FFT Start Address (addr1-32)       │
│           │    │                                   │                  │
│  ┌────────┼────┼───────────────────────────────────┼─────────────┐  │
│  │  İNCE CFO DÜZELTMESİ (Fine CFO Correction)     │             │  │
│  │        │    │                                   ↓             │  │
│  │        │    │                          ┌─────────────────┐   │  │
│  │        └────┼─────────────────────────>│  Input Buffer   │   │  │
│  │             │                          │  (256 samples)  │   │  │
│  │             │                          └─────────────────┘   │  │
│  │             │                                   │             │  │
│  │             │                                   ↓             │  │
│  │             │  phase_correction        ┌─────────────────┐   │  │
│  │             │  (accumulator)           │  Rotate Module  │   │  │
│  │             └─────────────────────────>│  (Phase Shift)  │   │  │
│  │                                         └─────────────────┘   │  │
│  │                                                  │             │  │
│  │       φ(n) = φ(n-1) + Δφ                       ↓             │  │
│  │       Δφ = phase_offset ± GI_compensation  [Corrected]       │  │
│  └──────────────────────────────────────────────────────────────┘  │
│                                                     │                 │
│                                                     ↓                 │
│                                          ┌──────────────────┐        │
│                                          │   FFT (64-pt)    │        │
│                                          │   xfft_v9        │        │
│                                          └──────────────────┘        │
│                                                     │                 │
│                                            [Frequency Domain]         │
└─────────────────────────────────────────────────────────────────────────┘
    │ FFT Output (64 subcarriers)
    ↓
┌─────────────────────────────────────────────────────────────────────────┐
│                     3️⃣ EQUALIZER MOD DUL                                │
│  (equalizer.v)                                                          │
│                                                                          │
│  ┌────────────────────────────────────────────────────────────────┐   │
│  │  KANAL TAHMİNCİSİ (Channel Estimator)                          │   │
│  │                                                                  │   │
│  │  State: S_FIRST_LTS                                            │   │
│  │  ┌────────────┐                                                │   │
│  │  │ LTS1 (64)  │───> Store in lts_buf                          │   │
│  │  └────────────┘                                                │   │
│  │                                                                  │   │
│  │  State: S_SECOND_LTS                                           │   │
│  │  ┌────────────┐    ┌──────────────┐                           │   │
│  │  │ LTS2 (64)  │───>│  Calc Mean   │───> H_raw(k)              │   │
│  │  └────────────┘    │ (LTS1+LTS2)/2│                           │   │
│  │  LTS1 from buf ───>│  / lts_ref   │                           │   │
│  │                     └──────────────┘                           │   │
│  │                                                                  │   │
│  │  ┌─────────────────────────────────────────────────────┐      │   │
│  │  │ GÜRÜLTÜ TAHMİNCİSİ (Noise Estimator - Implicit)    │      │   │
│  │  │                                                      │      │   │
│  │  │  N(k) = LTS2(k) - LTS1(k)                          │      │   │
│  │  │  σ²_noise ≈ E[|N(k)|²] / 2                         │      │   │
│  │  │                                                      │      │   │
│  │  │  (calc_mean modülü içinde örtük hesaplama)         │      │   │
│  │  └─────────────────────────────────────────────────────┘      │   │
│  │                          │                                      │   │
│  │                          ↓                                      │   │
│  │  State: S_SMOOTH_CH_DC & S_SMOOTH_CH_LTS                      │   │
│  │  ┌──────────────────────────────┐                             │   │
│  │  │  Moving Average (L=3,4,5)    │───> H_smooth(k)             │   │
│  │  │  (802.11 standard smoothing) │                             │   │
│  │  └──────────────────────────────┘                             │   │
│  └────────────────────────────────────────────────────────────────┘  │
│                                                                        │
│  ┌────────────────────────────────────────────────────────────────┐  │
│  │  FAZ HATASI DÜZELTMESİ (Phase Error Correction)                │  │
│  │                                                                  │  │
│  │  State: S_CPE_ESTIMATE (Ortak Faz Hatası)                      │  │
│  │  ┌───────────────────────────────────────────────┐            │  │
│  │  │  4 Pilot Alt-Taşıyıcı: -21, -7, +7, +21       │            │  │
│  │  │                                                 │            │  │
│  │  │  Y_pilot * conj(LTS_pilot) ───> Phase ───> CPE│            │  │
│  │  │                                                 │            │  │
│  │  │  CPE: Tüm alt-taşıyıcılar için ortak          │            │  │
│  │  └───────────────────────────────────────────────┘            │  │
│  │                           │                                     │  │
│  │  State: S_PILOT_PE_CORRECTION                                  │  │
│  │  ┌───────────────────────────────────────────────┐            │  │
│  │  │  Pilotları önceki PEG ile düzelt              │            │  │
│  │  │  Yeni pilot faz hatalarını hesapla            │            │  │
│  │  └───────────────────────────────────────────────┘            │  │
│  │                           │                                     │  │
│  │  State: S_LVPE_ESTIMATE (Doğrusal Değişen Faz Hatası)         │  │
│  │  ┌───────────────────────────────────────────────┐            │  │
│  │  │  Sxy = Σ (pilot_idx[i] * phase_err[i])       │            │  │
│  │  │  Sx² = 7² + 21² + (-21)² + (-7)² = 980       │            │  │
│  │  │  PEG = Sxy / Sx²                              │            │  │
│  │  │  LVPE(k) = PEG * k                            │            │  │
│  │  └───────────────────────────────────────────────┘            │  │
│  └────────────────────────────────────────────────────────────────┘  │
│                                                                        │
│  ┌────────────────────────────────────────────────────────────────┐  │
│  │  KANAL EŞİTLEME (Channel Equalization)                         │  │
│  │                                                                  │  │
│  │  State: S_ALL_SC_PE_CORRECTION                                 │  │
│  │  ┌───────────┐    ┌──────────┐    ┌─────────┐    ┌─────────┐ │  │
│  │  │ Input     │───>│  Rotate  │───>│ Divide  │───>│ Output  │ │  │
│  │  │ Buffer    │    │ (φ_total)│    │ by H(k) │    │ (48/52) │ │  │
│  │  └───────────┘    └──────────┘    └─────────┘    └─────────┘ │  │
│  │                          │              │                       │  │
│  │  φ_total = CPE + LVPE(k) + PEG*k       │                       │  │
│  │                                         │                       │  │
│  │                          H(k) from lts_buf                      │  │
│  │                                                                  │  │
│  │  X_est(k) = [Y(k) * e^(-j*φ_total)] / H(k)                    │  │
│  └────────────────────────────────────────────────────────────────┘  │
└─────────────────────────────────────────────────────────────────────────┘
    │ Equalized Data (48 data subcarriers for legacy, 52 for HT)
    ↓
┌─────────────────────┐
│   DEMODULATOR       │
│  (demodulate.v)     │
└─────────────────────┘
    │
    ↓
Soft Bits / Hard Bits
```

---

## 🔍 DETAYLI VERİ AKIŞI - SYNC_SHORT

```
sample_in (I/Q, 32-bit)
    │
    ├──────────────────────────────────────┐
    │                                      │
    ↓                                      ↓
┌────────────┐                    ┌────────────────┐
│ Magnitude² │                    │ Delay 16 samp. │
│  (Power)   │                    │ + Conjugate    │
└────────────┘                    └────────────────┘
    │                                      │
    ↓                                      │
┌────────────┐                             │
│ Moving Avg │                             │
│ (16 samp)  │                             │
└────────────┘                             │
    │                                      │
    │   mag_sq_avg                         │
    │                                      │
    ├──────────> prod_thres                │
    │           (threshold)                │
    │                                      │
    │                              sample_in (delayed)
    │                                      │
    │                                      ↓
    │                              ┌────────────────┐
    │                              │ Complex Mult   │
    │                              │ (Auto-corr)    │
    │                              └────────────────┘
    │                                      │
    │                                      ↓
    │                              ┌────────────────┐
    │                              │ Moving Avg     │
    │                              │ (16 samples)   │ → prod_avg
    │                              └────────────────┘
    │                                      │
    │                                      ├──> magnitude → delay_prod_avg_mag
    │                                      │
    │                                      └──────────────────┐
    │                                                         │
    │                              ┌────────────────────────┐ │
    │                              │ Moving Avg (64 samples)│ │
    │                              │ freq_offset_inst       │ │
    │                              └────────────────────────┘ │
    │                                         │                │
    │                                         ↓                │
    │                                  phase_in_i/q            │
    │                                         │                │
    │                                         ↓                │
    │                                  ┌───────────┐           │
    │                                  │   Phase   │           │
    │                                  │ Calculator│           │
    │                                  └───────────┘           │
    │                                         │                │
    │                                         ↓                │
    │                                    phase_out             │
    │                                         │                │
    ↓                                         ↓                ↓
[delay_prod_avg_mag > prod_thres] ───> Plateau Detection
                                              │
                                              ↓
                        [plateau_count > min_plateau]
                                   &
                        [has_pos & has_neg samples]
                                              │
                                              ↓
                              short_preamble_detected
                                              │
                                              ↓
                                        phase_offset
                                    (Coarse CFO estimate)
```

---

## 🔍 DETAYLI VERİ AKIŞI - SYNC_LONG

```
sample_in (corrected from sync_short)
    │
    ↓
┌─────────────────────────────────────────────────────────────┐
│  INPUT BUFFER (256 samples circular)                        │
└─────────────────────────────────────────────────────────────┘
    │
    │ (parallel operations)
    │
    ├──────────────────────────────┬────────────────────────────┐
    │                              │                            │
    ↓                              ↓                            ↓
Cross-Correlation             Wait for                    FFT Processing
Buffer [32]                   88 samples                  (after timing found)
    │                              │                            │
    ↓                              │                            │
┌─────────────┐                    │                            │
│ Stage Mult  │ × 4 stages         │                            │
│ (8 parallel)│                    │                            │
└─────────────┘                    │                            │
    │                              │                            │
    ↓                              │                            │
Sum (I + Q)                        │                            │
    │                              │                            │
    ↓                              │                            │
Magnitude                          │                            │
(metric)                           │                            │
    │                              │                            │
    ↓                              │                            │
Find Maximum ────────> addr1       │                            │
(metric_max1)                      │                            │
                                   │                            │
                                   ↓                            │
                         [num_sample >= 88]                     │
                                   │                            │
                                   ↓                            │
                         long_preamble_detected                 │
                                   │                            │
                                   ↓                            │
                         Set: in_raddr = addr1 - 32            │
                              phase_correction = 0             │
                              next_phase_correction = phase_offset
                                   │                            │
                                   ↓                            │
                              S_FFT State ─────────────────────┘
                                   │
                                   ↓
                          Read from buffer
                          (starting at addr1-32)
                                   │
                                   ↓
                          ┌────────────────┐
                          │  Rotate Module │
                          │  (Fine CFO)    │
                          └────────────────┘
                                   │
            phase_correction ──────┘
            (updated each sample)
                                   │
                                   ↓
                          ┌────────────────┐
                          │  FFT (64-pt)   │
                          │  xfft_v9       │
                          └────────────────┘
                                   │
                                   ↓
                          sample_out (freq domain)
                          (to equalizer)
```

---

## 🔍 DETAYLI VERİ AKIŞI - EQUALIZER

```
sample_in (64 subcarriers from FFT)
    │
    ↓
┌──────────────── S_FIRST_LTS ────────────────┐
│  Store 64 samples in lts_buf                │
│  LTS1(k) for k = 0..63                      │
└─────────────────────────────────────────────┘
    │
    ↓
┌──────────────── S_SECOND_LTS ───────────────┐
│                                              │
│  For each k:                                 │
│                                              │
│  Read: LTS1(k) from lts_buf                 │
│  Input: LTS2(k) from sample_in              │
│  Ref: lts_ref[k] (known LTS)                │
│                                              │
│  ┌─────────────────────────┐                │
│  │  calc_mean              │                │
│  │                         │                │
│  │  If lts_ref[k] == 1:   │                │
│  │    mean = (LTS1 + LTS2*(-1)) / 2        │
│  │  Else:                  │                │
│  │    mean = (LTS1 + LTS2) / 2             │
│  │                         │                │
│  │  Implicit:              │                │
│  │    diff = LTS2 - LTS1   │                │
│  │    noise ≈ E[|diff|²]/2 │                │
│  └─────────────────────────┘                │
│           │                                  │
│           ↓                                  │
│  H_raw(k) = mean / lts_ref[k]               │
│  (stored back in lts_buf)                   │
└─────────────────────────────────────────────┘
    │
    ↓
┌────── S_SMOOTH_CH_DC (optional) ────────────┐
│  For k near DC (0..5):                      │
│    H_smooth(k) = avg(H_raw(k-2:k+2))        │
│    (moving average, L=3,4,5)                │
└─────────────────────────────────────────────┘
    │
    ↓
┌────── S_SMOOTH_CH_LTS (optional) ───────────┐
│  For other subcarriers:                     │
│    H_smooth(k) = avg(H_raw(k-2:k+2))        │
│    (edge: L=3,4; middle: L=5)               │
└─────────────────────────────────────────────┘
    │
    │  [H(k) now in lts_buf, smoothed]
    │
    ↓
┌───────────── For Each OFDM Symbol ──────────┐
│                                              │
│  sample_in (64 subcarriers)                 │
│       │                                      │
│       ↓                                      │
│  ┌─────────── S_CPE_ESTIMATE ─────────┐    │
│  │                                      │    │
│  │  Extract 4 pilots: k = -21,-7,+7,+21│    │
│  │                                      │    │
│  │  For each pilot:                    │    │
│  │    Y_pilot * conj(polarity)         │    │
│  │    × conj(H_pilot)                  │    │
│  │                                      │    │
│  │  Sum all 4 pilots                   │    │
│  │    pilot_sum_i/q                    │    │
│  │                                      │    │
│  │  Calculate phase:                   │    │
│  │    cpe = atan2(pilot_sum_q,         │    │
│  │                pilot_sum_i)         │    │
│  └──────────────────────────────────────┘   │
│       │                                      │
│       ↓                                      │
│  ┌─────── S_PILOT_PE_CORRECTION ──────┐    │
│  │                                      │    │
│  │  For each pilot k:                  │    │
│  │    phase_err = cpe + PEG_old*k      │    │
│  │    Y'_pilot = Y_pilot * e^(-j*φ)   │    │
│  │    Y'_pilot × conj(H_pilot)         │    │
│  │    pilot_phase[k] = atan2(...)      │    │
│  └──────────────────────────────────────┘   │
│       │                                      │
│       ↓                                      │
│  ┌─────────── S_LVPE_ESTIMATE ─────────┐   │
│  │                                       │   │
│  │  Sxy = 7*φ[0] + 21*φ[1]             │   │
│  │      + (-21)*φ[2] + (-7)*φ[3]       │   │
│  │                                       │   │
│  │  Sx² = 7² + 21² + 21² + 7² = 980    │   │
│  │                                       │   │
│  │  PEG = Sxy / 980                     │   │
│  └───────────────────────────────────────┘  │
│       │                                      │
│       ↓                                      │
│  ┌────── S_ALL_SC_PE_CORRECTION ──────┐    │
│  │                                      │    │
│  │  For k = 0..63:                     │    │
│  │                                      │    │
│  │    LVPE(k) = PEG * k                │    │
│  │                                      │    │
│  │    φ_total = cpe + LVPE(k)          │    │
│  │            + PEG_prev*k              │    │
│  │                                      │    │
│  │    Y'(k) = Y(k) * e^(-j*φ_total)    │    │
│  │                                      │    │
│  │    X(k) = Y'(k) / H(k)              │    │
│  │         = (Y'_i*H_i + Y'_q*H_q)     │    │
│  │           / (H_i² + H_q²)           │    │
│  │                                      │    │
│  │  Output only data subcarriers       │    │
│  │  (mask out pilots, DC, guards)      │    │
│  └──────────────────────────────────────┘   │
│       │                                      │
│       ↓                                      │
│  sample_out (48 or 52 data subcarriers)     │
└─────────────────────────────────────────────┘
    │
    ↓
To Demodulator
```

---

## 📐 MATEMATİKSEL FORMÜLLER

### 1. Kaba CFO Tahmini (sync_short)
```
r(n) = received sample at time n
d = 16 (delay in samples)

Autocorrelation:
R(d) = Σ r(n) × r*(n-d)

Phase estimate:
φ = angle(R(d))

Frequency offset:
Δf = φ / (2π × d × T_s)
```

### 2. Sembol Zamanlaması (sync_long)
```
LTS_known = [156+0j, -5+120j, 40+111j, ...]  (32 samples)
r(n) = received sample

Cross-correlation metric:
M(d) = |Σ r(d+n) × LTS*_known(n)|²

Optimal timing:
d_opt = argmax(M(d))
```

### 3. İnce CFO Düzeltmesi (sync_long)
```
φ(0) = phase_offset (from sync_short)
φ(n) = φ(n-1) + Δφ

If φ(n) > π:    φ(n) = φ(n) - 2π
If φ(n) < -π:   φ(n) = φ(n) + 2π

Corrected sample:
r'(n) = r(n) × e^(-j×φ(n))

GI compensation:
At symbol boundary (n=63):
  φ(64) = φ(63) + Δφ + GI_offset
  GI_offset = Δφ × (8 or 16)  (for short/long GI)
```

### 4. Kanal Tahmini (equalizer)
```
Wireless channel model:
Y(k) = H(k) × X(k) + N(k)

Where:
  Y(k) = received signal at subcarrier k
  H(k) = channel frequency response
  X(k) = transmitted signal (known for LTS)
  N(k) = noise

Channel estimation:
H_raw(k) = (LTS1(k) + LTS2(k)) / 2 / X_LTS(k)

Smoothing (optional):
H_smooth(k) = (1/L) × Σ H_raw(k+i)  for i=-L/2..L/2
              where L = 3, 4, or 5

Noise power (implicit):
N_diff(k) = LTS2(k) - LTS1(k)
σ²_noise ≈ E[|N_diff(k)|²] / 2
```

### 5. CPE (Common Phase Error)
```
Pilot extraction:
Y_pilot(k) for k ∈ {-21, -7, +7, +21}

Polarity correction:
Y'_pilot(k) = Y_pilot(k) × polarity(k)

Phase estimation:
P = Σ Y'_pilot(k) × conj(H(k))
cpe = atan2(imag(P), real(P))
```

### 6. LVPE (Linear Varying Phase Error)
```
Pilot indices:
idx = [-21, -7, +7, +21]

Phase errors:
φ_pilot(k) for k = 0,1,2,3

Gradient calculation:
Sxy = Σ idx(i) × φ_pilot(i)
    = (-21)×φ[0] + (-7)×φ[1] + 7×φ[2] + 21×φ[3]

Sx² = Σ idx(i)²
    = 21² + 7² + 7² + 21² = 980

Phase Error Gradient:
PEG = Sxy / 980

LVPE for subcarrier k:
LVPE(k) = PEG × k
```

### 7. Kanal Eşitleme (Equalization)
```
Total phase correction:
φ_total(k) = cpe + LVPE(k) + PEG_prev × k

Phase-corrected signal:
Y'(k) = Y(k) × e^(-j×φ_total(k))

Equalization (zero-forcing):
X_est(k) = Y'(k) / H(k)

In practice (avoiding division):
X_est_i(k) = (Y'_i × H_i + Y'_q × H_q) / (H_i² + H_q²)
X_est_q(k) = (Y'_q × H_i - Y'_i × H_q) / (H_i² + H_q²)

Output only data subcarriers:
  Legacy (802.11a/g): 48 data (out of 52 used)
  HT (802.11n):       52 data (out of 56 used)
```

---

**Tarih**: 2026-01-24  
**Proje**: openwifi-hw/ip/openofdm_rx  
**Format**: ASCII Art + Mathematical Notation
