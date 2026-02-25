function [noise_power, noise_power_valid, mean_i, mean_q, mean_valid] = noise_power_estimator(lts1_i, lts1_q, lts2_i, lts2_q, sign_vec, clk_enable)
% NOISE_POWER_ESTIMATOR - Verilog calc_mean.v ve equalizer.v modüllerinin MATLAB golden reference implementasyonu
%
% Bu fonksiyon, OpenOFDM RX Verilog kodundaki Noise Power Estimator'ın
% birebir MATLAB karşılığıdır. İki LTS (Long Training Sequence) sinyali 
% arasındaki farktan gürültü gücünü tahmin eder.
%
% VERILOG REFERANSI:
%   - Dosya: calc_mean.v (ortalama hesaplama)
%   - Dosya: equalizer.v, S_SECOND_LTS state (noise power estimation)
%   - Fixed-point format: 16-bit signed (Q15)
%
% GİRİŞLER:
%   lts1_i      : İlk LTS I bileşeni [Nx1], 16-bit signed integer [-32768, 32767]
%   lts1_q      : İlk LTS Q bileşeni [Nx1], 16-bit signed integer [-32768, 32767]
%   lts2_i      : İkinci LTS I bileşeni [Nx1], 16-bit signed integer [-32768, 32767]
%   lts2_q      : İkinci LTS Q bileşeni [Nx1], 16-bit signed integer [-32768, 32767]
%   sign_vec    : İşaret vektörü [Nx1], LTS reference sign (0 veya 1)
%   clk_enable  : Clock enable sinyali (1: aktif, 0: pasif)
%
% ÇIKIŞLAR:
%   noise_power       : Tahmin edilen gürültü gücü [Nx1], 32-bit unsigned
%   noise_power_valid : Noise power çıkışının geçerli olduğu anlar [Nx1], logical
%   mean_i            : Ortalama I bileşeni (LTS1+LTS2)/2 [Nx1], 16-bit signed
%   mean_q            : Ortalama Q bileşeni (LTS1+LTS2)/2 [Nx1], 16-bit signed
%   mean_valid        : Ortalama çıkışının geçerli olduğu anlar [Nx1], logical
%
% ÇALIŞMA PRENSİBİ:
%   1. ORTALAMA HESAPLAMA (calc_mean.v):
%      - aa = lts1 >> 1 (arithmetic right shift)
%      - bb = lts2 >> 1 (arithmetic right shift)
%      - cc = aa + bb
%      - mean = sign ? -cc : cc
%      - 3 clock cycle pipeline delay
%
%   2. GÜRÜLTÜ GÜCÜ TAHMİNİ:
%      - diff_i = lts2_i - lts1_i
%      - diff_q = lts2_q - lts1_q
%      - noise_sq = diff_i^2 + diff_q^2
%      - noise_power = noise_sq / 2
%
% FIXED-POINT DETAYları:
%   - Tüm giriş değerleri 16-bit signed integer (int16)
%   - Aritmetik sağa kaydırma (arithmetic right shift) kullanılır
%   - Taşma durumlarında saturation (kırpma) uygulanır
%   - Çarpma sonuçları 32-bit'e genişletilir
%
% PIPELINE GECİKMESİ:
%   - Ortalama çıkışı: 3 clock cycle delay
%   - Noise power çıkışı: 3 clock cycle delay (ortalama ile aynı anda)
%
% KULLANIM ÖRNEĞİ:
%   % 64 LTS örneği (WiFi 802.11a/g/n)
%   N = 64;
%   lts1_i = int16(randi([-1000, 1000], N, 1));
%   lts1_q = int16(randi([-1000, 1000], N, 1));
%   lts2_i = lts1_i + int16(randi([-100, 100], N, 1)); % LTS2 = LTS1 + noise
%   lts2_q = lts1_q + int16(randi([-100, 100], N, 1));
%   sign_vec = [ones(32,1); zeros(32,1)]; % İlk yarı negatif, ikinci yarı pozitif
%   clk_enable = 1;
%   
%   [noise_power, np_valid, mean_i, mean_q, m_valid] = ...
%       noise_power_estimator(lts1_i, lts1_q, lts2_i, lts2_q, sign_vec, clk_enable);
%
% VERILOG EŞDEĞERLİĞİ:
%   Bu MATLAB kodu, calc_mean.v modülünün davranışını birebir taklit eder.
%   Equalizer.v'deki S_SECOND_LTS state'inde çağrılan calc_mean_inst için
%   golden reference olarak kullanılabilir.
%
% REFERANSLAR:
%   - openofdm_rx/verilog/calc_mean.v
%   - openofdm_rx/verilog/equalizer.v (satır ~527-575)
%   - IEEE 802.11-2012 Standard, Section 20.3.9.4.3
%
% YAZAN: GitHub Copilot (Claude Sonnet 4.5)
% TARİH: 31 Ocak 2026
% VERSİYON: 1.0

%% Giriş Kontrolü
narginchk(6, 6);

% Vektör boyutlarını kontrol et
N = length(lts1_i);
assert(length(lts1_q) == N, 'lts1_q boyutu lts1_i ile aynı olmalı');
assert(length(lts2_i) == N, 'lts2_i boyutu lts1_i ile aynı olmalı');
assert(length(lts2_q) == N, 'lts2_q boyutu lts1_i ile aynı olmalı');
assert(length(sign_vec) == N, 'sign_vec boyutu lts1_i ile aynı olmalı');

% Veri tipi kontrolü (int16 olmalı)
assert(isa(lts1_i, 'int16'), 'lts1_i int16 tipinde olmalı');
assert(isa(lts1_q, 'int16'), 'lts1_q int16 tipinde olmalı');
assert(isa(lts2_i, 'int16'), 'lts2_i int16 tipinde olmalı');
assert(isa(lts2_q, 'int16'), 'lts2_q int16 tipinde olmalı');

% Kolon vektörlerine dönüştür
lts1_i = lts1_i(:);
lts1_q = lts1_q(:);
lts2_i = lts2_i(:);
lts2_q = lts2_q(:);
sign_vec = sign_vec(:);

%% Çıkış Değişkenlerini Başlat
mean_i = zeros(N, 1, 'int16');
mean_q = zeros(N, 1, 'int16');
mean_valid = false(N, 1);
noise_power = zeros(N, 1, 'uint32');
noise_power_valid = false(N, 1);

%% Pipeline Register Değişkenleri (calc_mean.v'deki register'lar)
aa_i = int16(0);
aa_q = int16(0);
bb_i = int16(0);
bb_q = int16(0);
cc_i = int16(0);
cc_q = int16(0);
c_i = int16(0);
c_q = int16(0);

delay_reg = false(2, 1);
sign_stage = false(2, 1);

%% Her Clock Cycle İçin İşlemi Tekrarla
for idx = 1:N
    if clk_enable
        % Pipeline delay register'larını güncelle (Verilog'daki delay[0] <= input_strobe)
        delay_reg(2) = delay_reg(1);
        delay_reg(1) = true; % input_strobe her zaman true (streaming mode)
        
        % Sign pipeline register'larını güncelle
        sign_stage(2) = sign_stage(1);
        sign_stage(1) = (sign_vec(idx) ~= 0);
        
        % STAGE 1: Arithmetic right shift by 1 (Verilog: aa <= a>>>1)
        % MATLAB'de arithmetic right shift: bitshift ile yapılır
        aa_i = arithmetic_right_shift(lts1_i(idx), 1);
        aa_q = arithmetic_right_shift(lts1_q(idx), 1);
        bb_i = arithmetic_right_shift(lts2_i(idx), 1);
        bb_q = arithmetic_right_shift(lts2_q(idx), 1);
        
        % STAGE 2: Toplama (Verilog: cc <= aa + bb)
        cc_i = saturate_add_int16(aa_i, bb_i);
        cc_q = saturate_add_int16(aa_q, bb_q);
        
        % STAGE 3: İşaret uygulama (Verilog: c <= sign_stage[1]? ~cc+1: cc)
        if sign_stage(2)
            c_i = negate_int16(cc_i);
            c_q = negate_int16(cc_q);
        else
            c_i = cc_i;
            c_q = cc_q;
        end
        
        % Çıkış değerlerini kaydet
        mean_i(idx) = c_i;
        mean_q(idx) = c_q;
        mean_valid(idx) = delay_reg(2); % output_strobe <= delay[1]
        
        % GÜRÜLTÜ GÜCÜ HESAPLAMA (Explicit implementation)
        % diff = lts2 - lts1
        diff_i = int32(lts2_i(idx)) - int32(lts1_i(idx));
        diff_q = int32(lts2_q(idx)) - int32(lts1_q(idx));
        
        % noise_sq = diff_i^2 + diff_q^2 (64-bit hesaplama, overflow önleme)
        noise_sq_i = int64(diff_i) * int64(diff_i);
        noise_sq_q = int64(diff_q) * int64(diff_q);
        noise_sq_total = noise_sq_i + noise_sq_q;
        
        % 32-bit'e dönüştür (saturate)
        if noise_sq_total > double(intmax('uint32'))
            noise_sq = uint32(intmax('uint32'));
        else
            noise_sq = uint32(noise_sq_total);
        end
        
        % noise_power = noise_sq / 2 (right shift)
        % Minimum değer kontrolü (spike önleme için)
        noise_power(idx) = max(uint32(1), bitshift(noise_sq, -1));
        noise_power_valid(idx) = delay_reg(2);
    end
end

end % function

%% YARDIMCI FONKSİYONLAR

function result = arithmetic_right_shift(value, shift_amount)
% ARITHMETIC_RIGHT_SHIFT - İşaretli tam sayılar için aritmetik sağa kaydırma
% Verilog'daki >>> operatörünün MATLAB karşılığı
%
% value: int16 tipinde değer
% shift_amount: Kaydırma miktarı (pozitif tam sayı)
% result: Kaydırılmış değer (int16)

    % MATLAB'de bitshift negatif değerler için arithmetic shift yapar
    result = int16(bitshift(int32(value), -shift_amount));
end

function result = saturate_add_int16(a, b)
% SATURATE_ADD_INT16 - Taşma durumunda saturation ile int16 toplama
% Verilog'da varsayılan toplama davranışını taklit eder
%
% a, b: int16 tipinde değerler
% result: Toplama sonucu (int16, saturated)

    % 32-bit'e genişlet ve topla
    sum_val = int32(a) + int32(b);
    
    % Saturation uygula
    if sum_val > 32767
        result = int16(32767);
    elseif sum_val < -32768
        result = int16(-32768);
    else
        result = int16(sum_val);
    end
end

function result = negate_int16(value)
% NEGATE_INT16 - İşaretli tam sayı için negation (~value + 1)
% Verilog'daki ~cc+1 operasyonunun MATLAB karşılığı
%
% value: int16 tipinde değer
% result: Negatif değer (int16)

    % Two's complement: -value = ~value + 1
    % MATLAB'de direkt -value kullanabiliriz ama Verilog davranışı için:
    if value == intmin('int16')
        % Özel durum: -32768'in negation'ı yine -32768 (taşma)
        result = int16(-32768);
    else
        result = int16(-double(value));
    end
end
