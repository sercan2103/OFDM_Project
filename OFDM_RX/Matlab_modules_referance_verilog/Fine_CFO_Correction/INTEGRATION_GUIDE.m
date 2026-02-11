%% INTEGRATION_GUIDE - Fine CFO Estimator Entegrasyon Kılavuzu
%
% Bu belge, fine_cfo_correction fonksiyonunun diğer OFDM RX modülleri
% ile nasıl entegre edileceğini açıklar.
%
% YAZAR: GitHub Copilot
% TARİH: 2026-01-31

%% GİRİŞ/ÇIKIŞ ARAYÜZÜ
%
% Fine CFO Estimator, OFDM alıcı zincirinde şu konumda yer alır:
%
% [Power Trigger] -> [Sync Short] -> [Sync Long] -> [FFT] -> [Equalizer] -> ...
%                                        |
%                                 Fine CFO Estimator
%                                 (rotate modülü)
%
% GİRİŞLER:
%   1. samples_in            : Sync Short'tan gelen örnekler
%   2. phase_offset          : Sync Short'tan hesaplanan coarse CFO
%   3. short_gi              : PHY header'dan gelen GI bilgisi
%   4. num_ofdm_symbol_in    : Mevcut state (sembol sayacı)
%   5. phase_correction_in   : Mevcut state (faz düzeltme)
%
% ÇIKIŞLAR:
%   1. samples_out           : FFT'ye giden düzeltilmiş örnekler
%   2. phase_correction_out  : Güncellenmiş state (sonraki çağrı için)
%   3. num_ofdm_symbol_out   : Güncellenmiş state (sonraki çağrı için)

%% SYNC SHORT MODÜLÜ İLE ENTEGRASYON
%
% Sync Short modülü coarse CFO tahminini yapar ve phase_offset çıkışını verir.
% Bu değer Fine CFO Estimator'a doğrudan giriş olarak verilir.
%
% Örnek Akış:
%
% function [samples_corrected] = ofdm_receiver_chain(samples_in)
%     % 1. Sync Short: Coarse CFO tahmini
%     [short_preamble_detected, phase_offset] = sync_short(samples_in);
%     
%     if ~short_preamble_detected
%         return;
%     end
%     
%     % 2. Sync Long: LTS algılama + Fine CFO başlangıç
%     persistent phase_correction num_ofdm_symbol;
%     if isempty(phase_correction)
%         phase_correction = int32(0);
%         num_ofdm_symbol = uint16(0);
%     end
%     
%     % 3. Fine CFO düzeltme (her örnek için)
%     [samples_corrected, phase_correction, num_ofdm_symbol] = ...
%         fine_cfo_correction(samples_in, phase_offset, short_gi, ...
%                            num_ofdm_symbol, phase_correction);
%     
%     % 4. FFT ve sonraki işlemler...
% end

%% STATE YÖNETİMİ
%
% Fine CFO Estimator, iki state değişkenini korur:
%   - phase_correction : Akkümüle edilen faz düzeltme değeri
%   - num_ofdm_symbol  : İşlenen OFDM sembol sayısı
%
% Bu state değerlerinin paket başında sıfırlanması ve her çağrıda
% güncellenmesi gerekir.
%
% PERSISTENT DEĞIŞKEN KULLANIMI:
%
% function main_receiver()
%     persistent phase_corr num_sym;
%     
%     if packet_start
%         phase_corr = int32(0);
%         num_sym = uint16(0);
%     end
%     
%     [samples_out, phase_corr, num_sym] = fine_cfo_correction(...
%         samples_in, phase_offset, short_gi, num_sym, phase_corr);
% end

%% GUARD INTERVAL YÖNETİMİ
%
% OFDM sembollerinde Guard Interval (GI) atlanır. Fine CFO Estimator
% bu durumu otomatik olarak yönetir:
%
% - İlk sembol (LTS): GI yok, 64 örnek işlenir
% - Sonraki semboller: GI atlanır
%   * Long GI (802.11a/g): 16 örnek atlanır
%   * Short GI (802.11n/ac): 8 örnek atlanır
%
% short_gi parametresi PHY header'dan (SIGNAL veya HT-SIG) okunmalıdır.

%% PERFORMANS OPTİMİZASYONU
%
% 1. BATCH PROCESSING:
%    Tek örnek yerine tüm OFDM sembolünü bir kerede işleyin:
%
%    % İyi: Tüm sembol bir kerede
%    [samples_out, phase_corr, num_sym] = fine_cfo_correction(...
%        samples_64x1, phase_offset, short_gi, num_sym, phase_corr);
%
%    % Kötü: Her örneği ayrı ayrı
%    for i = 1:64
%        [sample_out(i), phase_corr, num_sym] = fine_cfo_correction(...
%            samples(i), phase_offset, short_gi, num_sym, phase_corr);
%    end
%
% 2. FIXED-POINT ARITMETIK:
%    Tüm işlemler integer tiplerle yapılır, float'a dönüşüm minimize edilir.
%
% 3. LUT CACHING:
%    rotate_fixed_point fonksiyonu LUT'u persistent değişkende tutar,
%    her çağrıda yeniden yüklemez.

%% HATA YÖNETİMİ
%
% 1. PHASE OVERFLOW KONTROLÜ:
%    phase_correction değeri otomatik olarak [-PI, PI] aralığında tutulur.
%    Manual overflow kontrolü gerekmez.
%
% 2. SAMPLE FORMAT KONTROLÜ:
%    Giriş örnekleri 16-bit signed olmalıdır:
%
%    assert(isa(samples_in, 'int16') || ...
%           (isinteger(samples_in(:,1)) && isinteger(samples_in(:,2))), ...
%           'Samples must be 16-bit signed integers');
%
% 3. LUT DOSYA KONTROLÜ:
%    Eğer rot_lut.mif veya .coe dosyaları bulunamazsa, fonksiyon
%    otomatik olarak analitik LUT oluşturur ve warning verir.

%% VERİLOG SİMÜLASYONU İLE DOĞRULAMA
%
% MATLAB modeli Verilog kodunun golden reference'ı olarak kullanılabilir:
%
% 1. Verilog testbench'ten giriş vektörlerini kaydet
% 2. MATLAB modelini aynı giriş ile çalıştır
% 3. Çıkışları karşılaştır
%
% Örnek:
%
% % Verilog'dan gelen test vektörleri
% verilog_in = readtable('sync_long_input.csv');
% verilog_out = readtable('sync_long_output.csv');
%
% % MATLAB modelini çalıştır
% [matlab_out, ~, ~] = fine_cfo_correction(...
%     complex(verilog_in.I, verilog_in.Q), ...
%     int16(verilog_in.phase_offset(1)), ...
%     logical(verilog_in.short_gi(1)), 0, 0);
%
% % Karşılaştır (max 1-2 LSB hata beklenir)
% error_i = abs(matlab_out(:,1) - verilog_out.I);
% error_q = abs(matlab_out(:,2) - verilog_out.Q);
% max_error = max([error_i; error_q]);
%
% fprintf('Maksimum hata: %d LSB\n', max_error);
% assert(max_error <= 2, 'Verilog ile uyumsuzluk!');

%% MODÜLER KULLANIM
%
% Fine CFO Estimator, bağımsız bir modül olarak tasarlanmıştır.
% Diğer modüllerle minimum bağımlılık vardır:
%
% BAĞIMLILIKLAR:
%   - rotate_fixed_point.m : Faz rotasyon fonksiyonu
%   - rot_lut.mif veya .coe : Rotasyon LUT (opsiyonel)
%
% BAĞIMLI OLMAYAN:
%   - Sync Short modülü (sadece phase_offset değerini alır)
%   - FFT modülü (çıkış olarak samples_out verir)
%   - Equalizer modülü (CFO düzeltmeden sonra çalışır)

%% DİĞER MODÜLLERLE VERİ FORMATI
%
% SYNC SHORT ÇIKIŞI -> FINE CFO GİRİŞİ:
%   phase_offset: int16 scalar
%   Aralık: [-PI, PI] (ölçeklenmiş)
%   PI = 1608 (ATAN_LUT_SCALE_SHIFT = 9)
%
% FINE CFO ÇIKIŞI -> FFT GİRİŞİ:
%   samples_out: Nx2 int16 matris
%   [I, Q] formatında
%   N = FFT boyutu (genellikle 64)
%
% PHY HEADER -> FINE CFO GİRİŞİ:
%   short_gi: logical scalar
%   false = Long GI (802.11a/g)
%   true = Short GI (802.11n/ac)

%% ÖRNEK ENTEGRASYON KOD PARÇASI
%
% function [demodulated_data] = ofdm_rx_complete(samples_rf)
%     %% 1. Power Trigger
%     [trigger_detected, trigger_idx] = power_trigger(samples_rf);
%     if ~trigger_detected, return; end
%     
%     samples = samples_rf(trigger_idx:end);
%     
%     %% 2. Sync Short
%     [preamble_detected, phase_offset] = sync_short(samples);
%     if ~preamble_detected, return; end
%     
%     %% 3. Sync Long + Fine CFO (ilk LTS)
%     persistent phase_corr num_sym;
%     if isempty(phase_corr)
%         phase_corr = int32(0);
%         num_sym = uint16(0);
%     end
%     
%     % LTS sample'larını işle (128 örnek = 2 LTS)
%     lts_samples = samples(1:128);
%     [lts_corrected, phase_corr, num_sym] = fine_cfo_correction(...
%         lts_samples, phase_offset, false, num_sym, phase_corr);
%     
%     %% 4. FFT (channel estimation için LTS)
%     H_est = estimate_channel_from_lts(lts_corrected);
%     
%     %% 5. SIGNAL field decode
%     signal_samples = samples(129:192);
%     [signal_corrected, phase_corr, num_sym] = fine_cfo_correction(...
%         signal_samples, phase_offset, false, num_sym, phase_corr);
%     
%     [rate, length, short_gi] = decode_signal_field(signal_corrected, H_est);
%     
%     %% 6. DATA field decode (CFO düzeltme devam eder)
%     num_data_symbols = calculate_num_symbols(length, rate);
%     demodulated_data = [];
%     
%     for i = 1:num_data_symbols
%         % Her OFDM sembolü için
%         start_idx = 193 + (i-1)*80;  % 64 + 16 (Long GI)
%         data_samples = samples(start_idx:start_idx+63);
%         
%         % Fine CFO düzeltme
%         [data_corrected, phase_corr, num_sym] = fine_cfo_correction(...
%             data_samples, phase_offset, short_gi, num_sym, phase_corr);
%         
%         % FFT + Equalize + Demodulate
%         data_fft = fft(data_corrected, 64);
%         data_eq = equalizer(data_fft, H_est);
%         bits = demodulate(data_eq, rate);
%         
%         demodulated_data = [demodulated_data; bits];
%     end
% end

%% SONUÇ
%
% Bu entegrasyon kılavuzu, Fine CFO Estimator modülünün OFDM alıcı
% zincirine nasıl dahil edileceğini göstermektedir.
%
% Önemli noktalar:
%   1. State yönetimi (phase_correction ve num_ofdm_symbol)
%   2. Sync Short modülü ile etkileşim (phase_offset)
%   3. PHY header ile etkileşim (short_gi)
%   4. FFT modülü ile etkileşim (samples_out)
%   5. Fixed-point aritmetik (int16, int32 tipleri)
%
% Daha fazla bilgi için README.md dosyasına bakınız.
