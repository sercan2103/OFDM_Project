function [out_i, out_q, debug_info] = fine_cfo_correction(in_i, in_q, phase_correction, rot_lut)
% FINE_CFO_CORRECTION - Verilog rotate.v modülünün MATLAB referans implementasyonu
%
% Bu fonksiyon Fine CFO (Carrier Frequency Offset) düzeltmesi yapar.
% Gelen I/Q örneklerine faz rotasyonu uygulayarak frekans ofsetini kompanze eder.
%
% INPUTS:
%   in_i             - Input I samples (16-bit signed integer array veya fi objesi)
%   in_q             - Input Q samples (16-bit signed integer array veya fi objesi)
%   phase_correction - Phase correction değeri array (16-bit signed, [-π,π] scaled)
%                      Her örnek için phase_correction değeri olmalı
%   rot_lut          - Rotasyon LUT tablosu (struct)
%                      rot_lut.sin_lut: Sine LUT (16-bit signed, 512 entry)
%                      rot_lut.cos_lut: Cosine LUT (16-bit signed, 512 entry)
%
% OUTPUTS:
%   out_i       - Output I samples (16-bit signed integer array veya fi objesi)
%   out_q       - Output Q samples (16-bit signed integer array veya fi objesi)
%   debug_info  - Debug bilgileri içeren struct
%
% ÖRNEK KULLANIM:
%   % LUT'u yükle
%   rot_lut = load_rotation_lut();
%   
%   % Örnek veriler (16-bit signed integer olarak)
%   in_i = fi([1000, 2000, 3000], 1, 16, 0);
%   in_q = fi([500, 1000, 1500], 1, 16, 0);
%   phase = fi([100, 200, 300], 1, 16, 0);
%   
%   % Fine CFO Correction uygula
%   [out_i, out_q, debug] = fine_cfo_correction(in_i, in_q, phase, rot_lut);
%
% VERILOG REFERANSI:
%   rotate.v - Faz rotasyon modülü
%   complex_mult.v - Kompleks çarpım modülü
%
% SABIT PARAMETRELER (Verilog common_defs.v'den):
%   ATAN_LUT_SCALE_SHIFT = 9
%   ROTATE_LUT_SCALE_SHIFT = 11
%   PI = 1608 (π * 2^9)
%
% Author: MATLAB Reference Model Generator
% Date: 2026-02-19
% Version: 1.0

%% Sabitler (Verilog common_params.v ve common_defs.v'den)
ATAN_LUT_SCALE_SHIFT = 9;
ROTATE_LUT_SCALE_SHIFT = 11;
ROTATE_LUT_LEN_SHIFT = ATAN_LUT_SCALE_SHIFT; % 9

PI = 1608;           % π * 2^ATAN_LUT_SCALE_SHIFT
PI_2 = bitshift(PI, -1);      % π/2
PI_4 = bitshift(PI, -2);      % π/4
PI_3_4 = PI_2 + PI_4;         % 3π/4

%% Giriş validasyonu
num_samples = length(in_i);
if length(in_q) ~= num_samples
    error('in_i ve in_q aynı uzunlukta olmalı');
end
if length(phase_correction) ~= num_samples
    error('phase_correction in_i ile aynı uzunlukta olmalı');
end

%% Fixed-point tip tanımlamaları (Verilog ile aynı)
% 16-bit signed input/output
T_16bit = numerictype(1, 16, 0);
% 32-bit signed intermediate
T_32bit = numerictype(1, 32, 0);
% LUT değerleri için 16-bit signed
T_lut = numerictype(1, 16, 0);

%% Giriş verilerini fixed-point'e dönüştür (eğer değilse)
if ~isa(in_i, 'fi')
    in_i_fi = fi(in_i, T_16bit);
else
    in_i_fi = in_i;
end

if ~isa(in_q, 'fi')
    in_q_fi = fi(in_q, T_16bit);
else
    in_q_fi = in_q;
end

if ~isa(phase_correction, 'fi')
    phase_fi = fi(phase_correction, T_16bit);
else
    phase_fi = phase_correction;
end

%% Çıkış arraylerini hazırla
out_i = fi(zeros(num_samples, 1), T_16bit);
out_q = fi(zeros(num_samples, 1), T_16bit);

%% Debug bilgileri için yapı
debug_info.phase_abs = zeros(num_samples, 1);
debug_info.quadrant = zeros(num_samples, 1);
debug_info.actual_phase = zeros(num_samples, 1);
debug_info.rot_i = zeros(num_samples, 1);
debug_info.rot_q = zeros(num_samples, 1);
debug_info.lut_addr = zeros(num_samples, 1);

%% Her örnek için işlem yap (Verilog rotate.v pipeline'ını taklit eder)
for idx = 1:num_samples
    phase = phase_fi(idx);
    
    % CYCLE 1: Phase absolute değerini hesapla
    % Verilog: phase_abs <= phase[15]? ~phase+1: phase;
    if phase < 0
        phase_abs = -phase;
    else
        phase_abs = phase;
    end
    phase_abs = fi(phase_abs, T_16bit);
    
    % CYCLE 2: Quadrant belirleme ve actual_phase hesaplama
    % Verilog'daki quadrant belirleme mantığı
    if phase_abs <= PI_4
        quadrant = 0;
        if phase < 0
            quadrant = quadrant + 4;  % Negatif faz
        end
        actual_phase = phase_abs;
        
    elseif phase_abs <= PI_2
        quadrant = 1;
        if phase < 0
            quadrant = quadrant + 4;
        end
        actual_phase = PI_2 - phase_abs;
        
    elseif phase_abs <= PI_3_4
        quadrant = 2;
        if phase < 0
            quadrant = quadrant + 4;
        end
        actual_phase = phase_abs - PI_2;
        
    else  % phase_abs > PI_3_4
        quadrant = 3;
        if phase < 0
            quadrant = quadrant + 4;
        end
        actual_phase = PI - phase_abs;
    end
    
    actual_phase = fi(actual_phase, T_16bit);
    
    % CYCLE 3: LUT'tan sin/cos değerlerini oku
    % LUT adresi: actual_phase'in düşük ROTATE_LUT_LEN_SHIFT biti
    % Verilog: rot_addr = actual_phase[ROTATE_LUT_LEN_SHIFT-1:0];
    lut_addr = bitand(double(actual_phase), 2^ROTATE_LUT_LEN_SHIFT - 1);
    lut_addr = lut_addr + 1;  % MATLAB indexing (1-based)
    
    % LUT'tan cos ve sin değerlerini al
    % Verilog'da rot_data = {cos, sin} formatında (32-bit: [31:16]=cos, [15:0]=sin)
    raw_rot_i = fi(rot_lut.cos_lut(lut_addr), T_lut);
    raw_rot_q = fi(rot_lut.sin_lut(lut_addr), T_lut);
    
    % CYCLE 4: Quadrant'a göre düzeltme yap
    % Verilog'daki case statement
    switch quadrant
        case 0  % 0-45 derece (pozitif)
            rot_i = raw_rot_i;
            rot_q = raw_rot_q;
        case 1  % 45-90 derece (pozitif)
            rot_i = raw_rot_q;
            rot_q = raw_rot_i;
        case 2  % 90-135 derece (pozitif)
            rot_i = -raw_rot_q;
            rot_q = raw_rot_i;
        case 3  % 135-180 derece (pozitif)
            rot_i = -raw_rot_i;
            rot_q = raw_rot_q;
        case 4  % 0-45 derece (negatif)
            rot_i = raw_rot_i;
            rot_q = -raw_rot_q;
        case 5  % 45-90 derece (negatif)
            rot_i = raw_rot_q;
            rot_q = -raw_rot_i;
        case 6  % 90-135 derece (negatif)
            rot_i = -raw_rot_q;
            rot_q = -raw_rot_i;
        case 7  % 135-180 derece (negatif)
            rot_i = -raw_rot_i;
            rot_q = -raw_rot_q;
        otherwise
            error('Invalid quadrant: %d', quadrant);
    end
    
    rot_i = fi(rot_i, T_lut);
    rot_q = fi(rot_q, T_lut);
    
    % COMPLEX MULTIPLICATION
    % Verilog complex_mult.v: (a_i + j*a_q) * (b_i + j*b_q)
    % p_i = a_i*b_i - a_q*b_q
    % p_q = a_i*b_q + a_q*b_i
    
    % 32-bit signed çarpım sonuçları
    p_i_full = fi(double(in_i_fi(idx)) * double(rot_i) - double(in_q_fi(idx)) * double(rot_q), T_32bit);
    p_q_full = fi(double(in_i_fi(idx)) * double(rot_q) + double(in_q_fi(idx)) * double(rot_i), T_32bit);
    
    % Ölçekleme: ROTATE_LUT_SCALE_SHIFT kadar sağa kaydır
    % Verilog: out_i = p_i[ROTATE_LUT_SCALE_SHIFT+15:ROTATE_LUT_SCALE_SHIFT];
    % Bu 32-bit'ten 16-bit'e dönüşüm yapıyor
    % FIXED: Cast to int64 for bitshift compatibility
    out_i(idx) = fi(bitshift(int64(round(double(p_i_full))), -ROTATE_LUT_SCALE_SHIFT), T_16bit);
    out_q(idx) = fi(bitshift(int64(round(double(p_q_full))), -ROTATE_LUT_SCALE_SHIFT), T_16bit);
    
    % Debug bilgilerini kaydet
    debug_info.phase_abs(idx) = double(phase_abs);
    debug_info.quadrant(idx) = quadrant;
    debug_info.actual_phase(idx) = double(actual_phase);
    debug_info.rot_i(idx) = double(rot_i);
    debug_info.rot_q(idx) = double(rot_q);
    debug_info.lut_addr(idx) = lut_addr;
end

end
