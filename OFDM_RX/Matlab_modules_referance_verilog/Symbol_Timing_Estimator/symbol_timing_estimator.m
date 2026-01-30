function [detected, timing_offset, metric_out] = symbol_timing_estimator(samples_in, fft_win_shift)
% SYMBOL_TIMING_ESTIMATOR - Verilog sync_long.v modülünün MATLAB referans implementasyonu
%
% Bu fonksiyon, WiFi OFDM alıcısında sembol zamanlaması tahminini gerçekleştirir.
% Long Training Sequence (LTS) ile çapraz korelasyon kullanarak FFT penceresinin
% başlangıç noktasını belirler.
%
% INPUTS:
%   samples_in      - Complex IQ samples (16-bit fixed-point, I:Q format)
%                     Her sample: int16 I + 1i*int16 Q
%   fft_win_shift   - FFT window shift parameter (0-15, typically 0)
%
% OUTPUTS:
%   detected        - Boolean, Long preamble detected flag
%   timing_offset   - Integer, Best timing offset (FFT window start)
%   metric_out      - Vector of correlation metrics (for debugging)
%
% ALGORITHM:
%   1. Gelen örnekleri 32 örneklik buffer'da tutar
%   2. Bilinen LTS değerleri ile çapraz korelasyon hesaplar
%   3. Maksimum korelasyon noktasını bulur (symbol timing)
%   4. 88 örnek boyunca correlation hesaplar
%
% REFERENCE: sync_long.v, lines 100-650 (do_mult task)
%
% Yazar: MATLAB Referans Model Generator
% Tarih: 2026-01-29

% Varsayılan parametreler
if nargin < 2 || isempty(fft_win_shift)
    fft_win_shift = 0;
end

% Fixed-point parametreleri (Verilog ile uyumlu)
WORD_WIDTH = 16;            % Her I ve Q component 16-bit
CROSS_CORR_BUF_SIZE = 32;   % Buffer size
NUM_SAMPLES_TO_PROCESS = 88; % Long preamble processing window

% LTS Reference Values (bilinen Long Training Sequence değerleri)
% sync_long.v do_mult task'inden alınmıştır (lines 520-600)
LTS_ref = [
    % Stage 0 (indices 0-7)
     156 + 1i*0,    -5 + 1i*120,   40 + 1i*111,    97 - 1i*83,
      21 - 1i*28,   60 + 1i*88,  -115 + 1i*55,   -38 + 1i*106,
    % Stage 1 (indices 8-15)
      98 + 1i*26,   53 - 1i*4,      1 + 1i*115,  -137 + 1i*47,
      24 + 1i*59,   59 + 1i*15,   -22 - 1i*161,  119 + 1i*4,
    % Stage 2 (indices 16-23)
      62 + 1i*62,   37 - 1i*98,   -57 - 1i*39,  -131 - 1i*65,
      82 - 1i*92,   70 - 1i*14,   -60 - 1i*81,   -56 + 1i*22,
    % Stage 3 (indices 24-31)
     -35 + 1i*151, -122 + 1i*17, -127 + 1i*21,    75 + 1i*74,
      -3 - 1i*54,  -92 - 1i*115,  92 - 1i*106,    12 - 1i*98
];

% LTS reference'i fixed-point int16 olarak sakla
LTS_ref_i = int16(real(LTS_ref));
LTS_ref_q = int16(imag(LTS_ref));

% Input samples'ı fixed-point'e çevir
if ~isa(samples_in, 'int16')
    % Eğer complex double ise, fixed-point int16'ya çevir
    samples_i = int16(real(samples_in));
    samples_q = int16(imag(samples_in));
else
    % Zaten int16 complex ise ayır
    samples_i = int16(real(samples_in));
    samples_q = int16(imag(samples_in));
end

num_samples = length(samples_in);

% Output initialization
detected = false;
timing_offset = 0;
metric_len = max(0, min(num_samples - CROSS_CORR_BUF_SIZE, NUM_SAMPLES_TO_PROCESS));
metric_out = zeros(1, metric_len);

% Cross-correlation buffer (32 complex samples)
cross_corr_buf_i = zeros(1, CROSS_CORR_BUF_SIZE, 'int16');
cross_corr_buf_q = zeros(1, CROSS_CORR_BUF_SIZE, 'int16');

% Metric tracking
metric_max = 0;
best_addr = 0;

% Process samples
sample_idx = 1;
metric_idx = 1;

while sample_idx <= num_samples && metric_idx <= NUM_SAMPLES_TO_PROCESS
    % Buffer'ı güncelle (shift register gibi)
    if sample_idx <= num_samples
        % Yeni sample ekle
        cross_corr_buf_i(2:end) = cross_corr_buf_i(1:end-1);
        cross_corr_buf_q(2:end) = cross_corr_buf_q(1:end-1);
        cross_corr_buf_i(1) = samples_i(sample_idx);
        cross_corr_buf_q(1) = samples_q(sample_idx);
        sample_idx = sample_idx + 1;
    end
    
    % Buffer dolduysa cross-correlation hesapla
    if sample_idx > CROSS_CORR_BUF_SIZE
        % do_mult task implementation (4 stage parallel multiplication)
        % Stage 0-3: Her stage 8 complex multiplication yapar
        
        % Complex multiplication ve accumulation (fixed-point)
        sum_i_total = int32(0);
        sum_q_total = int32(0);
        
        % 32 LTS sample ile cross-correlation
        for k = 1:CROSS_CORR_BUF_SIZE
            % Buffer'dan sample al (reverse order, çünkü shift register)
            buf_i = int32(cross_corr_buf_i(k));
            buf_q = int32(cross_corr_buf_q(k));
            
            % LTS reference
            ref_i = int32(LTS_ref_i(k));
            ref_q = int32(LTS_ref_q(k));
            
            % Complex multiplication: (a+jb) * (c+jd) = (ac-bd) + j(ad+bc)
            prod_i = buf_i * ref_i - buf_q * ref_q;
            prod_q = buf_i * ref_q + buf_q * ref_i;
            
            sum_i_total = sum_i_total + prod_i;
            sum_q_total = sum_q_total + prod_q;
        end
        
        % Magnitude hesapla (complex_to_mag.v ile uyumlu)
        metric = calculate_magnitude_fixed(sum_i_total, sum_q_total);
        metric_out(metric_idx) = double(metric);
        
        % Maximum metric tracking
        if metric > metric_max
            metric_max = metric;
            best_addr = metric_idx - 1 - fft_win_shift; % FFT window shift uygula
        end
        
        metric_idx = metric_idx + 1;
    end
end

% Long preamble detection
if metric_idx >= NUM_SAMPLES_TO_PROCESS
    detected = true;
    % Offset'i cross-correlation buffer size kadar geri al
    timing_offset = best_addr - CROSS_CORR_BUF_SIZE;
    if timing_offset < 0
        timing_offset = 0;
    end
else
    detected = false;
    timing_offset = 0;
end

end


function mag = calculate_magnitude_fixed(sum_i, sum_q)
% CALCULATE_MAGNITUDE_FIXED - Fixed-point magnitude hesaplama
% complex_to_mag.v modülünün MATLAB karşılığı
%
% CORDIC veya approximation yerine, basit sqrt(i^2 + q^2) kullanır
% Verilog implementasyonu CORDIC kullanır ama bu referans model

% int32'den double'a çevir, magnitude hesapla
i_dbl = double(sum_i);
q_dbl = double(sum_q);

mag = sqrt(i_dbl^2 + q_dbl^2);
mag = int32(mag);

end
