function lts_samples = generate_lts_sequence()
% GENERATE_LTS_SEQUENCE - IEEE 802.11 Long Training Sequence (LTS) üretir
%
% OUTPUTS:
%   lts_samples - 64-sample LTS sequence (complex, normalized)
%
% REFERENCE: 
%   IEEE 802.11-2012 Standard, Section 18.3.3
%   Frequency domain: L_{-26,26} subcarriers
%
% LTS frekans domaininde tanımlı, IFFT ile time domain'e çevrilir

% LTS subcarrier values (frequency domain)
% Index mapping: -26 to +26, DC (0) is null
% Format: [L_{-26}, L_{-25}, ..., L_{-1}, 0, L_{1}, ..., L_{26}]

LTS_freq = [0, 0, 0, 0, 0, 0, 1, 1, -1, -1, 1, 1, -1, 1, -1, 1, 1, 1, 1, 1, 1, -1, -1, 1, 1, -1, 1, -1, 1, 1, 1, 1, 0, 1, -1, -1, 1, 1, -1, 1, -1, 1, -1, -1, -1, -1, -1, 1, 1, -1, -1, 1, -1, 1, -1, 1, 1, 1, 1, 0, 0, 0, 0, 0];

% 64-point IFFT (Time domain)
lts_time = ifft(ifftshift(LTS_freq), 64);

% 802.11 LTS: İki tam LTS kopyası + Cyclic prefix
% Cyclic prefix: Son 32 sample (GI2)
% Format: [GI2 | LTS1 | LTS2]
cp = lts_time(end-31:end);
lts_samples = [cp, lts_time, lts_time];

% Normalize (peak-to-average power)
lts_samples = lts_samples / max(abs(lts_samples));

end
