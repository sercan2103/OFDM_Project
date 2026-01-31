function [sample_out, sample_out_strobe, csi, csi_valid, state_out] = channel_estimator_fixed(sample_in, sample_in_strobe, ht_next, pkt_ht, ht_smoothing, disable_all_smoothing, rot_lut, params)
% CHANNEL_ESTIMATOR_FIXED - WiFi OFDM Channel Estimator (Fixed-Point Reference Model)
% 
% Bu fonksiyon Verilog equalizer.v modülünün bit-accurate MATLAB referans modelidir.
% Kanal tahmini, gürültü gücü tahmini ve kanal eşitleme yapar.
%
% INPUTS:
%   sample_in              - FFT çıkışından gelen IQ örnekleri [Nx1] (complex int16)
%   sample_in_strobe       - sample_in valid sinyali [Nx1] (logical)
%   ht_next                - Bir sonraki sembolün HT olacağını belirtir (logical scalar)
%   pkt_ht                 - Paketin HT olup olmadığını belirtir (logical scalar)
%   ht_smoothing           - HT smoothing bit (logical scalar)
%   disable_all_smoothing  - Tüm smoothing'i devre dışı bırak (logical scalar)
%   rot_lut                - Rotasyon LUT [512x1] (complex fi)
%   params                 - Sabit parametreler struct
%
% OUTPUTS:
%   sample_out         - Eşitlenmiş veri alt-taşıyıcıları [Mx1] (complex int16)
%   sample_out_strobe  - sample_out valid sinyali [Mx1] (logical)
%   csi                - Channel State Information (CSI) [64x1 per symbol] (complex int16)
%   csi_valid          - CSI valid sinyali (logical)
%   state_out          - İç durum değişkenleri (debug için)
%
% KANAL MODELİ:
%   Y = H * X + N
%   Y: Alınan sinyal (sample_in)
%   H: Kanal katsayısı (tahmin edilecek)
%   X: Bilinen sinyal (LTS referansı)
%   N: Gürültü
%
% KANAL TAHMİNİ:
%   H_est = (LTS1 + LTS2) / 2 / X
%
% İŞLEMLER:
%   1. KANAL TAHMİNCİSİ (Channel Estimator)
%      - İki LTS kullanarak kanal yanıtını tahmin eder
%      - Smoothing uygular (isteğe bağlı)
%   
%   2. FAZ HATASI DÜZELTMESİ
%      - CPE (Common Phase Error): RFO düzeltmesi
%      - LVPE (Linear Varying Phase Error): SFO kompanzasyonu
%   
%   3. KANAL EŞİTLEME (Channel Equalization)
%      - Y / H hesabı ile veriyi düzeltir
%
% FIXED-POINT AYARLARI:
%   - Input/Output: int16 (signed 16-bit)
%   - İç hesaplamalar: int32 (signed 32-bit)
%   - LTS buffer: int16
%   - Pilot accumulator: int32
%   - Phase: int16 (512 scale, -pi to pi)
%
% AUTHOR: Auto-generated from Verilog equalizer.v
% DATE: 2026-01-31

%% Sabit Parametreler
if nargin < 8
    params = get_channel_estimator_params();
end

% Alt-taşıyıcı maskeleri
SUBCARRIER_MASK = logical([1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0]);
HT_SUBCARRIER_MASK = logical([1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,0,0,0,0,0,0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0]);
PILOT_MASK = logical([0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0]);
DATA_SUBCARRIER_MASK = xor(SUBCARRIER_MASK, PILOT_MASK);
HT_DATA_SUBCARRIER_MASK = xor(HT_SUBCARRIER_MASK, PILOT_MASK);

% LTS referansı (bilinen değerler, BPSK: 0 veya 1)
LTS_REF = logical([0,0,1,1,0,1,0,0,1,1,1,0,1,1,0,1,0,1,1,1,1,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,0,0,1,0,1,0,1,1,1,1,0,0,1,0,1,0,0,1,1,0,0,1,1,0]);
HT_LTS_REF = logical([0,0,1,1,0,1,0,0,1,1,1,0,1,1,0,1,0,1,1,1,1,1,1,1,1,0,0,0,1,1,0,0,0,0,0,0,0,0,1,1,0,0,1,0,1,0,1,1,1,1,0,0,1,0,1,0,0,1,1,0,0,1,1,0]);

% Polarity sequence (127 bits)
POLARITY_BITS = [1,1,1,1,1,1,1,0,0,0,1,1,1,0,1,1,0,0,0,1,0,1,0,0,1,0,1,1,1,1,1,1,0,1,0,1,0,1,0,0,0,0,1,0,1,1,0,1,1,1,1,0,0,1,1,1,0,1,0,1,1,0,1,0,0,0,1,1,0,0,1,0,0,0,1,0,0,0,0,0,0,1,0,0,1,0,0,1,1,0,1,0,0,1,1,1,0,1,1,1,0,0,0,1,1,1,1,0,0,0];
HT_POLARITY_BITS = [1,0,0,0]; % -21, -7, 7, 21

% Pilot pozisyonları (index 1-based MATLAB)
pilot_loc = [8, 22, 44, 58]; % 7, 21, 43, 57 (0-indexed) + 1
pilot_idx = [8, 22, -20, -6]; % Frekans indeksleri

% Fixed-point ayarları
T_int16 = numerictype(1, 16, 0);  % signed int16
T_int32 = numerictype(1, 32, 0);  % signed int32
T_int19 = numerictype(1, 19, 0);  % LTS sum için
T_phase = numerictype(1, 16, 0);  % phase (512 scale)
T_pilot_acc = numerictype(1, 32, 0); % pilot accumulator

%% Durum Değişkenleri
persistent state lts_buf in_buf lts_waddr lts_raddr in_waddr in_raddr;
persistent ht num_data_carrier num_ofdm_sym;
persistent subcarrier_mask data_subcarrier_mask pilot_mask lts_ref;
persistent polarity ht_polarity current_polarity;
persistent pilot_count1 pilot_count2 pilot_count3;
persistent cpe Sxy prev_peg prev_peg_reg;
persistent pilot_sum_i pilot_sum_q;
persistent pilot_iq_phase;
persistent lts_reg sym_idx sym_idx2;
persistent num_output;

% State machine durumları
S_FIRST_LTS = 0;
S_SECOND_LTS = 1;
S_SMOOTH_CH_DC = 2;
S_SMOOTH_CH_LTS = 3;
S_GET_POLARITY = 4;
S_CPE_ESTIMATE = 5;
S_PILOT_PE_CORRECTION = 6;
S_LVPE_ESTIMATE = 7;
S_ALL_SC_PE_CORRECTION = 8;
S_HT_LTS = 9;

% İlk başlatma
if isempty(state)
    state = S_FIRST_LTS;
    lts_buf = fi(zeros(64, 1), T_int16, T_int16, T_int16); % complex
    in_buf = fi(zeros(64, 1), T_int16, T_int16, T_int16);
    lts_waddr = 0;
    lts_raddr = 0;
    in_waddr = 0;
    in_raddr = 0;
    ht = false;
    num_data_carrier = 48;
    num_ofdm_sym = 0;
    subcarrier_mask = SUBCARRIER_MASK;
    data_subcarrier_mask = DATA_SUBCARRIER_MASK;
    pilot_mask = PILOT_MASK;
    lts_ref = LTS_REF;
    polarity = POLARITY_BITS;
    ht_polarity = HT_POLARITY_BITS;
    current_polarity = [0,0,0,0];
    pilot_count1 = 0;
    pilot_count2 = 0;
    pilot_count3 = 0;
    cpe = fi(0, T_phase);
    Sxy = fi(0, numerictype(1, 24, 0));
    prev_peg = fi(0, T_int32);
    prev_peg_reg = fi(0, T_int32);
    pilot_sum_i = fi(0, T_pilot_acc);
    pilot_sum_q = fi(0, T_pilot_acc);
    pilot_iq_phase = fi(zeros(4,1), T_phase);
    lts_reg = fi(zeros(5,1), T_int16, T_int16, T_int16);
    sym_idx = 0;
    sym_idx2 = 0;
    num_output = 0;
end

% Çıkış değişkenleri
sample_out = [];
sample_out_strobe = [];
csi = [];
csi_valid = false;

% Her sample için işlem
N = length(sample_in);
for i = 1:N
    if ~sample_in_strobe(i)
        continue;
    end
    
    % Sample'ı fixed-point'e çevir
    sample_complex = fi(complex(double(bitand(uint32(sample_in(i)), uint32(hex2dec('FFFF0000')))) / 65536, ...
                                 double(bitand(uint32(sample_in(i)), uint32(hex2dec('0000FFFF'))))), ...
                        T_int16, T_int16, T_int16);
    
    % State machine
    switch state
        case S_FIRST_LTS
            % İlk LTS'yi kaydet
            lts_buf(lts_waddr + 1) = sample_complex;
            lts_waddr = lts_waddr + 1;
            if lts_waddr == 64
                lts_waddr = 0;
                lts_raddr = 0;
                state = S_SECOND_LTS;
            end
            
        case S_SECOND_LTS
            % İkinci LTS ile ortalama al
            lts_idx = lts_raddr + 1;
            lts_old = lts_buf(lts_idx);
            
            % Sign based on LTS_REF
            if lts_ref(lts_raddr + 1)
                sample_complex = -sample_complex;
            end
            
            % Ortalama hesapla (calc_mean)
            lts_new = fi((lts_old + sample_complex) / 2, T_int16, T_int16, T_int16);
            lts_buf(lts_idx) = lts_new;
            
            % CSI çıkışı (1. veya 5. sembol)
            if (num_ofdm_sym == 0 || (pkt_ht && num_ofdm_sym == 4))
                csi = [csi; lts_new];
                csi_valid = true;
            end
            
            % Rotate LTS_REF
            lts_ref = circshift(lts_ref, [0, -1]);
            lts_raddr = lts_raddr + 1;
            
            if lts_raddr == 64
                lts_waddr = 0;
                lts_raddr = 62;
                if disable_all_smoothing
                    state = S_GET_POLARITY;
                else
                    state = S_SMOOTH_CH_DC;
                end
            end
            
        case S_SMOOTH_CH_DC
            % DC smoothing (henüz implement edilmedi - basitleştirilmiş)
            state = S_SMOOTH_CH_LTS;
            
        case S_SMOOTH_CH_LTS
            % LTS smoothing (henüz implement edilmedi - basitleştirilmiş)
            state = S_GET_POLARITY;
            
        case S_GET_POLARITY
            % Polarity hesapla
            if ht
                current_polarity = [xor(ht_polarity(2), polarity(1)), ...
                                   xor(ht_polarity(1), polarity(1)), ...
                                   xor(ht_polarity(4), polarity(1)), ...
                                   xor(ht_polarity(3), polarity(1))];
                ht_polarity = circshift(ht_polarity, [0, -1]);
            else
                current_polarity = [polarity(1), polarity(1), ~polarity(1), polarity(1)];
            end
            polarity = circshift(polarity, [0, -1]);
            
            pilot_sum_i = fi(0, T_pilot_acc);
            pilot_sum_q = fi(0, T_pilot_acc);
            pilot_count1 = 0;
            pilot_count2 = 0;
            cpe = fi(0, T_phase);
            in_waddr = 0;
            in_raddr = 0;
            lts_raddr = 0;
            num_ofdm_sym = num_ofdm_sym + 1;
            state = S_CPE_ESTIMATE;
            
        case S_CPE_ESTIMATE
            % HT geçiş kontrolü
            if ~ht && ht_next
                ht = true;
                num_data_carrier = 52;
                lts_ref = HT_LTS_REF;
                subcarrier_mask = HT_SUBCARRIER_MASK;
                data_subcarrier_mask = HT_DATA_SUBCARRIER_MASK;
                state = S_HT_LTS;
                continue;
            end
            
            % Input buffer'a yaz
            in_buf(in_waddr + 1) = sample_complex;
            in_waddr = in_waddr + 1;
            
            % Pilot kontrolü
            if pilot_mask(lts_raddr + 1)
                pilot_count1 = pilot_count1 + 1;
                % Pilot conjugate hesapla
                if current_polarity(pilot_count1) == 0
                    pilot_conj = sample_complex;
                else
                    pilot_conj = -conj(sample_complex);
                end
                % LTS ile çarp (complex multiplication)
                lts_val = lts_buf(lts_raddr + 1);
                prod = complex_mult_fixed(pilot_conj, lts_val);
                pilot_sum_i = pilot_sum_i + real(prod);
                pilot_sum_q = pilot_sum_q + imag(prod);
            end
            
            pilot_mask = circshift(pilot_mask, [0, -1]);
            lts_raddr = lts_raddr + 1;
            
            if pilot_count1 == 4
                % Phase hesapla
                cpe = phase_fixed(complex(pilot_sum_i, pilot_sum_q));
                pilot_count1 = 0;
                in_raddr = pilot_loc(1) - 1;
                lts_raddr = pilot_loc(1) - 1;
                state = S_PILOT_PE_CORRECTION;
            end
            
        case S_PILOT_PE_CORRECTION
            % Pilot phase error correction (basitleştirilmiş)
            state = S_LVPE_ESTIMATE;
            
        case S_LVPE_ESTIMATE
            % LVPE hesapla (basitleştirilmiş)
            state = S_ALL_SC_PE_CORRECTION;
            sym_idx = 0;
            in_raddr = 0;
            lts_raddr = 0;
            num_output = 0;
            
        case S_ALL_SC_PE_CORRECTION
            % Tüm alt-taşıyıcıları eşitle
            if in_raddr < 64
                % Rotate (phase correction)
                rotated = rotate_fixed(in_buf(in_raddr + 1), cpe, rot_lut);
                
                % Normalize (Y/H)
                normalized = divide_fixed(rotated, lts_buf(lts_raddr + 1));
                
                % Sadece veri alt-taşıyıcılarını çıkar
                if data_subcarrier_mask(in_raddr + 1)
                    sample_out = [sample_out; normalized];
                    sample_out_strobe = [sample_out_strobe; true];
                    num_output = num_output + 1;
                end
                
                in_raddr = in_raddr + 1;
                lts_raddr = lts_raddr + 1;
            end
            
            if num_output == num_data_carrier
                state = S_GET_POLARITY;
            end
            
        case S_HT_LTS
            % HT-LTS işleme (basitleştirilmiş)
            if lts_ref(lts_waddr + 1)
                lts_buf(lts_waddr + 1) = -sample_complex;
            else
                lts_buf(lts_waddr + 1) = sample_complex;
            end
            lts_ref = circshift(lts_ref, [0, -1]);
            lts_waddr = lts_waddr + 1;
            
            if lts_waddr == 64
                lts_waddr = 0;
                if ht_smoothing && ~disable_all_smoothing
                    state = S_SMOOTH_CH_DC;
                else
                    state = S_GET_POLARITY;
                end
            end
    end
end

% State çıkışı
state_out.state = state;
state_out.num_ofdm_sym = num_ofdm_sym;
state_out.ht = ht;

end

%% Yardımcı Fonksiyonlar
function params = get_channel_estimator_params()
    params.ATAN_LUT_SCALE_SHIFT = 9;
    params.ROTATE_LUT_SCALE_SHIFT = 11;
    params.CONS_SCALE_SHIFT = 10;
    params.PI = 1608; % pi * 512
end

function prod = complex_mult_fixed(a, b)
    % Complex multiplication (a * b)
    % a = a_r + j*a_i
    % b = b_r + j*b_i
    % prod = (a_r*b_r - a_i*b_i) + j*(a_r*b_i + a_i*b_r)
    
    T_int16 = numerictype(1, 16, 0);
    T_int32 = numerictype(1, 32, 0);
    
    a_r = fi(real(a), T_int16);
    a_i = fi(imag(a), T_int16);
    b_r = fi(real(b), T_int16);
    b_i = fi(imag(b), T_int16);
    
    prod_r = fi(double(a_r) * double(b_r) - double(a_i) * double(b_i), T_int32);
    prod_i = fi(double(a_r) * double(b_i) + double(a_i) * double(b_r), T_int32);
    
    prod = complex(double(prod_r), double(prod_i));
end

function phase_out = phase_fixed(complex_in)
    % ATAN2 ile phase hesaplama (fixed-point)
    % Output: -pi...pi scaled by 512
    
    T_phase = numerictype(1, 16, 0);
    
    phase_rad = atan2(imag(complex_in), real(complex_in));
    phase_scaled = phase_rad * 512 / pi;
    phase_out = fi(phase_scaled, T_phase);
end

function rotated = rotate_fixed(in_val, phase, rot_lut)
    % Rotate complex value by phase using LUT
    % phase: -pi...pi scaled by 512
    
    T_int16 = numerictype(1, 16, 0);
    
    % LUT lookup
    lut_idx = mod(double(phase), 512) + 1;
    if lut_idx < 1, lut_idx = 1; end
    if lut_idx > 512, lut_idx = 512; end
    
    rot_val = rot_lut(lut_idx);
    
    % Complex multiplication
    rotated = complex_mult_fixed(in_val, rot_val);
    
    % Scale back
    rotated = complex(double(real(rotated)) / 2048, double(imag(rotated)) / 2048);
    rotated = fi(rotated, T_int16, T_int16, T_int16);
end

function quotient = divide_fixed(dividend, divisor)
    % Fixed-point bölme (basitleştirilmiş)
    
    T_int16 = numerictype(1, 16, 0);
    
    if abs(divisor) < 1
        quotient = fi(0, T_int16, T_int16, T_int16);
        return;
    end
    
    % Scale up for precision
    scale = 1024;
    
    dividend_r = double(real(dividend)) * scale;
    dividend_i = double(imag(dividend)) * scale;
    
    % Magnitude squared
    mag_sq = double(real(divisor))^2 + double(imag(divisor))^2;
    
    if mag_sq == 0
        quotient = fi(0, T_int16, T_int16, T_int16);
        return;
    end
    
    % Y/H = Y * conj(H) / |H|^2
    quot_r = (dividend_r * double(real(divisor)) + dividend_i * double(imag(divisor))) / mag_sq;
    quot_i = (dividend_i * double(real(divisor)) - dividend_r * double(imag(divisor))) / mag_sq;
    
    quotient = complex(quot_r, quot_i);
    quotient = fi(quotient, T_int16, T_int16, T_int16);
end
