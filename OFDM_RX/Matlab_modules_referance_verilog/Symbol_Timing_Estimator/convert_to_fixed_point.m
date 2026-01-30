function samples_fp = convert_to_fixed_point(samples_float, word_width)
% CONVERT_TO_FIXED_POINT - Floating-point complex samples'ı fixed-point'e çevirir
%
% INPUTS:
%   samples_float - Complex floating-point samples (double)
%   word_width    - Bit genişliği (default: 16)
%
% OUTPUTS:
%   samples_fp    - Fixed-point int16 complex samples
%
% ALGORITHM:
%   1. Real ve imaginary kısımları ayır
%   2. [-1, 1] aralığından [-2^(word_width-1), 2^(word_width-1)-1] aralığına scale et
%   3. int16'ya çevir ve saturate et

if nargin < 2
    word_width = 16;
end

% Scaling factor
max_val = 2^(word_width-1) - 1;
min_val = -2^(word_width-1);

% Real ve imaginary kısımları ayır
real_part = real(samples_float);
imag_part = imag(samples_float);

% Scale ve quantize
real_scaled = round(real_part * max_val);
imag_scaled = round(imag_part * max_val);

% Saturate
real_saturated = max(min(real_scaled, max_val), min_val);
imag_saturated = max(min(imag_scaled, max_val), min_val);

% int16'ya çevir ve complex olarak birleştir
samples_fp = int16(real_saturated) + 1i * int16(imag_saturated);

end
