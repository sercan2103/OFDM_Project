function [phase_offset_fine] = fine_cfo_estimator(lts1_samples, lts2_samples)
% FINE_CFO_ESTIMATOR - Fine Carrier Frequency Offset Estimation
%
% AÇIKLAMA:
%   Bu fonksiyon, iki ardışık Long Training Symbol (LTS) arasındaki
%   faz farkından fine CFO tahminini yapar. Verilog sync_long.v 
%   modülünün channel estimation kısmının referansıdır.
%
% AMAÇ:
%   - İnce (fine) frekans ofset tahmini (ESTIMATION - tahmn yapma)
%   - İki LTS sembolü arası faz kaymasını ölçme
%   - Coarse CFO sonrası kalan ofseti bulma
%
% GİRİŞLER:
%   lts1_samples : İlk LTS sembolü (64x1 kompleks veya 64x2 [I,Q] matris)
%   lts2_samples : İkinci LTS sembolü (64x1 kompleks veya 64x2 [I,Q] matris)
%
% ÇIKIŞLAR:
%   phase_offset_fine : Fine CFO tahmini (16-bit signed, ölçeklenmiş)
%                       Birim: radyan/sample (ölçeklenmiş PI=1608)
%                       Bu değer fine_cfo_correction.m'e girdi olur
%
% ALGORİTMA:
%   1. İki LTS sembolünü konjugat çarpım: prod = LTS2 * conj(LTS1)
%   2. Tüm subcarrier'lar üzerinde ortalama faz açısı hesapla
%   3. 64 sample'a böl (LTS arası mesafe)
%   4. Ölçeklendir ve 16-bit signed'a dönüştür
%
% VERILOG REFERANSI:
%   sync_long.v - İki LTS arası korelasyon analizi
%   equalizer.v - Pilot phase tracking (residual CFO)
%
% FIXED-POINT DETAYLARI:
%   - PI = 1608 (ATAN_LUT_SCALE_SHIFT = 9)
%   - phase_offset: 16-bit signed [-PI, PI]
%   - LTS samples: 16-bit signed I/Q veya kompleks
%
% MODÜL İLİŞKİSİ:
%   Bu modül SADECE TAHMİN yapar, düzeltme yapmaz!
%   
%   ESTIMATOR (bu modül) -> CORRECTION modülü
%   
%   Kullanım sırası:
%   1. phase_offset = fine_cfo_estimator(lts1, lts2);  % TAHMİN
%   2. samples_out = fine_cfo_correction(samples, phase_offset, ...); % DÜZELTME
%
% ÖRNEK KULLANIM:
%   % LTS sembolleri (FFT çıkışı)
%   lts1 = complex(randn(64,1)*1000, randn(64,1)*1000);
%   
%   % Simüle edilmiş CFO ekle (0.01 rad/sample)
%   lts2 = lts1 .* exp(1i*0.01*(0:63)');
%   
%   % CFO tahmin et
%   phase_offset = fine_cfo_estimator(lts1, lts2);
%   
%   fprintf('Tahmin edilen CFO: %d (%.6f rad/sample)\n', ...
%           phase_offset, double(phase_offset)*pi/1608);
%
% YAZAR: GitHub Copilot
% TARİH: 2026-01-31
% VERSİYON: 1.0

%% GİRİŞ FORMATI KONTROLÜ VE DÖNÜŞÜM
% LTS samples kompleks vektor veya [I,Q] matris formatında olabilir
if size(lts1_samples, 2) == 2
    % [I, Q] formatı -> kompleks
    lts1 = complex(double(lts1_samples(:,1)), double(lts1_samples(:,2)));
    lts2 = complex(double(lts2_samples(:,1)), double(lts2_samples(:,2)));
elseif isnumeric(lts1_samples) && ~isreal(lts1_samples)
    % Zaten kompleks
    lts1 = lts1_samples(:);
    lts2 = lts2_samples(:);
else
    error('LTS samples kompleks vektor veya [I,Q] matris formatında olmalı');
end

% Boyut kontrolü
assert(length(lts1) == 64, 'LTS1 64 sample olmalı (FFT boyutu)');
assert(length(lts2) == 64, 'LTS2 64 sample olmalı (FFT boyutu)');

%% SABİTLER
PI = 1608;  % PI * (1 << ATAN_LUT_SCALE_SHIFT=9)

%% FINE CFO TAHMİNİ - ANA ALGORİTMA
% IEEE 802.11 standardında, iki ardışık LTS sembolü arasındaki
% faz farkı frekans ofsetini verir:
% Δf = Δφ / (2π * T_symbol)
% 
% OFDM'de T_symbol = 64 sample süresi (FFT boyutu)

% 1. KONJUGAT ÇARPIM
% Her subcarrier için faz farkını hesapla
% prod[k] = LTS2[k] * conj(LTS1[k])
% Faz: angle(prod[k]) = angle(LTS2[k]) - angle(LTS1[k])
conjugate_product = lts2 .* conj(lts1);

% 2. COHERENT INTEGRATION
% Tüm subcarrier'ları topla (SNR iyileştirme)
% DC ve guard subcarrier'lar otomatik filtrelenir
sum_product = sum(conjugate_product);

% 3. ORTALAMA FAZ AÇISI
% Toplam faz farkı (64 subcarrier üzerinden)
phase_diff_total = angle(sum_product);  % [-π, π] aralığında

% 4. SAMPLE BAŞINA FAZ KAYMA
% LTS1 ve LTS2 arasında 64 sample var
% phase_offset = Δφ / 64
phase_offset_per_sample = phase_diff_total / 64.0;

%% ÖLÇEKLEME VE FIXED-POINT DÖNÜŞÜM
% Verilog'daki format: 16-bit signed, PI=1608 ölçekli
% Dönüşüm: radyan -> ölçeklenmiş değer
% scaled = phase * (PI / π) = phase * (1608 / π)
phase_offset_scaled = phase_offset_per_sample * (PI / pi);

% Yuvarlama ve 16-bit signed sınırlama
phase_offset_scaled = round(phase_offset_scaled);
phase_offset_scaled = max(-32768, min(32767, phase_offset_scaled));

% Final çıkış: 16-bit signed integer
phase_offset_fine = int16(phase_offset_scaled);

%% DEBUG BİLGİSİ (opsiyonel)
% Açıklama modunda detaylı bilgi
if nargout == 0
    fprintf('===== Fine CFO Estimator Sonuçları =====\n');
    fprintf('Toplam faz farkı: %.6f radyan\n', phase_diff_total);
    fprintf('Sample başına faz: %.6f rad/sample\n', phase_offset_per_sample);
    fprintf('Ölçeklenmiş değer: %d (PI=1608)\n', phase_offset_fine);
    fprintf('Frekans ofseti: %.3f kHz (20MHz sampling varsayımı)\n', ...
            phase_offset_per_sample * 20e6 / (2*pi) / 1000);
    fprintf('========================================\n');
end

end
