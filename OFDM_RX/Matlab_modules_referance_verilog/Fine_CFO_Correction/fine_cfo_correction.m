function [samples_out, phase_correction_out, num_ofdm_symbol_out] = fine_cfo_correction(...
    samples_in, phase_offset, short_gi, num_ofdm_symbol_in, phase_correction_in)
% FINE_CFO_CORRECTION - Fine Carrier Frequency Offset Correction
%
% AÇIKLAMA:
%   Bu fonksiyon, sync_long.v Verilog modülündeki Fine CFO düzeltme 
%   algoritmasının birebir MATLAB referans implementasyonudur.
%   Fixed-point aritmetiği kullanır ve Verilog kodunun davranışını
%   tam olarak taklit eder.
%
% AMAÇ:
%   - İnce (fine) frekans ofset düzeltmesi
%   - Her örnek için faz rotasyonu uygulama
%   - Guard Interval sonrası ekstra faz düzeltmesi
%
% GİRİŞLER:
%   samples_in            : Kompleks örnekler [I, Q] formatında (Nx2 matris)
%                          Her satır: [16-bit I, 16-bit Q]
%   phase_offset          : sync_short'tan gelen faz ofseti (16-bit signed)
%   short_gi              : Guard Interval tipi (0=Long GI:16, 1=Short GI:8)
%   num_ofdm_symbol_in    : Mevcut OFDM sembol sayısı (16-bit)
%   phase_correction_in   : Başlangıç faz düzeltme değeri (32-bit signed)
%
% ÇIKIŞLAR:
%   samples_out           : Faz düzeltilmiş kompleks örnekler (Nx2 matris)
%   phase_correction_out  : Güncellenmiş faz düzeltme değeri (32-bit signed)
%   num_ofdm_symbol_out   : Güncellenmiş OFDM sembol sayısı (16-bit)
%
% VERILOG REFERANSI:
%   sync_long.v - S_FFT state, İnce CFO düzeltmesi bölümü (satır 382-427)
%
% FIXED-POINT DETAYLARI:
%   - PI = 1608 (scaled by ATAN_LUT_SCALE_SHIFT = 9)
%   - DOUBLE_PI = 3216
%   - phase_offset: 16-bit signed
%   - phase_correction: 32-bit signed
%   - Faz wrapping: [-PI, PI] aralığında
%
% ÖRNEK KULLANIM:
%   samples = [100+50i; 200-30i; ...];
%   phase_offset = int16(100);
%   short_gi = false;
%   [samples_corrected, phase_corr, sym_count] = ...
%       fine_cfo_correction(samples, phase_offset, short_gi, 0, 0);
%
% YAZAR: GitHub Copilot
% TARİH: 2026-01-31
% VERSİYON: 1.0 - Verilog sync_long.v referansından oluşturuldu

%% SABİTLER - Verilog common_params.v ile aynı
PI = int32(1608);           % PI * (1 << ATAN_LUT_SCALE_SHIFT)
DOUBLE_PI = int32(3216);    % 2 * PI

%% GİRİŞ TİP DÖNÜŞÜMÜ
% Verilog'daki signed/unsigned tipleri taklit et
phase_offset = int16(phase_offset);
phase_correction = int32(phase_correction_in);
num_ofdm_symbol = uint16(num_ofdm_symbol_in);

%% ÖRNEKLEME VE FIXED-POINT HAZIRLIK
num_samples = size(samples_in, 1);
samples_out = zeros(num_samples, 2, 'int16');

% Rotate LUT'u yükle (sin/cos değerleri)
rot_lut = load_rotate_lut();

%% HER ÖRNEK İÇİN FAZ DÜZELTME
for idx = 1:num_samples
    % Mevcut örneği al (16-bit signed)
    raw_i = int16(real(samples_in(idx)));
    raw_q = int16(imag(samples_in(idx)));
    
    % in_offset hesapla (0-63 arası, her OFDM sembolü için)
    in_offset = uint8(mod(idx - 1, 64));
    
    %% FAZ ROTASYONU UYGULA
    % rotate.v modülünü taklit et
    [corrected_i, corrected_q] = apply_phase_rotation(raw_i, raw_q, phase_correction, rot_lut);
    
    % Çıkışı kaydet
    samples_out(idx, 1) = corrected_i;
    samples_out(idx, 2) = corrected_q;
    
    %% FAZ DÜZELTME DEĞERİNİ GÜNCELLE
    % Verilog satır 398-425: Phase Update Per Sample
    next_phase_correction = phase_correction + int32(phase_offset);
    
    % Guard Interval sonrası ekstra düzeltme (in_offset == 63 ve num_ofdm_symbol > 0)
    if (in_offset == 63) && (num_ofdm_symbol > 0)
        if short_gi
            % Short GI: 8 sample ekstra düzeltme (phase_offset << 3)
            next_phase_correction = next_phase_correction + int32(bitshift(int32(phase_offset), 3));
        else
            % Long GI: 16 sample ekstra düzeltme (phase_offset << 4)
            next_phase_correction = next_phase_correction + int32(bitshift(int32(phase_offset), 4));
        end
    end
    
    % Faz wrapping: [-PI, PI] aralığında tut
    if phase_offset > 0
        if next_phase_correction > PI
            phase_correction = next_phase_correction - DOUBLE_PI;
        else
            phase_correction = next_phase_correction;
        end
    else
        if next_phase_correction < -PI
            phase_correction = next_phase_correction + DOUBLE_PI;
        else
            phase_correction = next_phase_correction;
        end
    end
    
    % OFDM sembol sayacını güncelle (her 64 örnekte bir)
    if in_offset == 63
        num_ofdm_symbol = num_ofdm_symbol + uint16(1);
    end
end

%% ÇIKIŞ ATAMA
phase_correction_out = phase_correction;
num_ofdm_symbol_out = num_ofdm_symbol;

end

%% YARDIMCI FONKSİYON: FAZ ROTASYONU
function [out_i, out_q] = apply_phase_rotation(in_i, in_q, phase, rot_lut)
% APPLY_PHASE_ROTATION - rotate.v modülünün MATLAB implementasyonu
%
% GİRİŞLER:
%   in_i, in_q : 16-bit signed kompleks örnek
%   phase      : 32-bit signed faz değeri [-PI, PI]
%   rot_lut    : Rotasyon LUT (sin/cos değerleri)
%
% ÇIKIŞLAR:
%   out_i, out_q : Faz döndürülmüş 16-bit signed kompleks örnek

    % Sabitler
    PI = int32(1608);
    PI_2 = int32(804);
    PI_4 = int32(402);
    PI_3_4 = int32(1206);
    ROTATE_LUT_SCALE_SHIFT = 14;
    
    % Phase'i 16-bit signed'a dönüştür (rotate.v'de phase input 16-bit)
    phase = int16(phase);
    
    % Faz mutlak değeri
    if phase < 0
        phase_abs = int16(-phase);
    else
        phase_abs = phase;
    end
    
    %% QUADRANT BELİRLEME (rotate.v satır 103-119)
    % 8 quadrant'a böl
    if phase_abs <= PI_4
        quadrant = uint8(bitand(bitshift(uint16(phase), -15), 1)) * 4 + 0;
        actual_phase = phase_abs;
    elseif phase_abs <= PI_2
        quadrant = uint8(bitand(bitshift(uint16(phase), -15), 1)) * 4 + 1;
        actual_phase = int16(PI_2 - phase_abs);
    elseif phase_abs <= PI_3_4
        quadrant = uint8(bitand(bitshift(uint16(phase), -15), 1)) * 4 + 2;
        actual_phase = int16(phase_abs - PI_2);
    else
        quadrant = uint8(bitand(bitshift(uint16(phase), -15), 1)) * 4 + 3;
        actual_phase = int16(PI - phase_abs);
    end
    
    % LUT'tan sin/cos değerlerini al
    % actual_phase'in alt 9 biti adres olarak kullanılır (ROTATE_LUT_LEN_SHIFT = 9)
    lut_addr = uint16(bitand(uint16(actual_phase), uint16(511))) + 1; % MATLAB 1-indexed
    raw_rot_i = rot_lut(lut_addr, 1); % cos değeri
    raw_rot_q = rot_lut(lut_addr, 2); % sin değeri
    
    %% QUADRANT'A GÖRE ROT_I ve ROT_Q BELİRLE (rotate.v satır 124-162)
    switch quadrant
        case 0 % 3'b000
            rot_i = raw_rot_i;
            rot_q = raw_rot_q;
        case 1 % 3'b001
            rot_i = raw_rot_q;
            rot_q = raw_rot_i;
        case 2 % 3'b010
            rot_i = int16(-raw_rot_q);
            rot_q = raw_rot_i;
        case 3 % 3'b011
            rot_i = int16(-raw_rot_i);
            rot_q = raw_rot_q;
        case 4 % 3'b100
            rot_i = raw_rot_i;
            rot_q = int16(-raw_rot_q);
        case 5 % 3'b101
            rot_i = raw_rot_q;
            rot_q = int16(-raw_rot_i);
        case 6 % 3'b110
            rot_i = int16(-raw_rot_q);
            rot_q = int16(-raw_rot_i);
        case 7 % 3'b111
            rot_i = int16(-raw_rot_i);
            rot_q = int16(-raw_rot_q);
        otherwise
            rot_i = raw_rot_i;
            rot_q = raw_rot_q;
    end
    
    %% KOMPLEKS ÇARPIM (complex_mult.v)
    % (in_i + j*in_q) * (rot_i + j*rot_q)
    % = (in_i*rot_i - in_q*rot_q) + j*(in_i*rot_q + in_q*rot_i)
    
    % 32-bit signed çarpımlar
    p_i_temp = int32(in_i) * int32(rot_i) - int32(in_q) * int32(rot_q);
    p_q_temp = int32(in_i) * int32(rot_q) + int32(in_q) * int32(rot_i);
    
    % ROTATE_LUT_SCALE_SHIFT kadar sağa kaydır (14 bit)
    % rotate.v satır 42-43
    out_i = int16(bitshift(p_i_temp, -ROTATE_LUT_SCALE_SHIFT));
    out_q = int16(bitshift(p_q_temp, -ROTATE_LUT_SCALE_SHIFT));
    
end

%% YARDIMCI FONKSİYON: ROTATE LUT YÜKLEME
function rot_lut = load_rotate_lut()
% LOAD_ROTATE_LUT - rot_lut.mif veya rot_lut.coe dosyasından LUT yükle
%
% Bu fonksiyon Verilog'daki rot_lut ROM'unun MATLAB karşılığıdır.
% LUT 512 değer içerir (9-bit adres: ROTATE_LUT_LEN_SHIFT = 9)
% Her değer [cos, sin] çiftidir (16-bit signed)
%
% ÇIKIŞ:
%   rot_lut : 512x2 matris, her satır [cos, sin]

    % ROT_LUT dosya yolu
    verilog_path = '/home/kemal/Desktop/New_Folder/openwifi-hw/ip/openofdm_rx/verilog';
    
    % rot_lut.mif dosyasını okumayı dene
    mif_file = fullfile(verilog_path, 'rot_lut.mif');
    coe_file = fullfile(verilog_path, 'rot_lut.coe');
    
    if exist(mif_file, 'file')
        % MIF dosyasını oku
        rot_lut = read_mif_file(mif_file);
    elseif exist(coe_file, 'file')
        % COE dosyasını oku
        rot_lut = read_coe_file(coe_file);
    else
        % Dosya bulunamazsa, analitik olarak oluştur
        warning('rot_lut.mif veya rot_lut.coe bulunamadı. Analitik LUT oluşturuluyor.');
        rot_lut = generate_rotate_lut();
    end
    
end

function rot_lut = read_mif_file(filename)
% MIF dosyasını oku ve parse et
    fid = fopen(filename, 'r');
    if fid == -1
        error('MIF dosyası açılamadı: %s', filename);
    end
    
    rot_lut = zeros(512, 2, 'int16');
    addr = 0;
    
    while ~feof(fid)
        line = fgetl(fid);
        if ischar(line)
            % Data satırlarını bul (format: "address : data;")
            tokens = regexp(line, '(\d+)\s*:\s*([0-9A-Fa-f]+)\s*;', 'tokens');
            if ~isempty(tokens)
                addr_val = str2double(tokens{1}{1});
                data_hex = tokens{1}{2};
                
                % 32-bit hex'i parse et: [15:0]=sin, [31:16]=cos
                data_val = uint32(hex2dec(data_hex));
                sin_val = int16(bitand(data_val, uint32(65535))); % Alt 16 bit
                cos_val = int16(bitshift(data_val, -16));          % Üst 16 bit
                
                % Signed dönüşüm
                if cos_val > 32767
                    cos_val = int16(cos_val - 65536);
                end
                if sin_val > 32767
                    sin_val = int16(sin_val - 65536);
                end
                
                rot_lut(addr_val + 1, :) = [cos_val, sin_val];
            end
        end
    end
    
    fclose(fid);
end

function rot_lut = read_coe_file(filename)
% COE dosyasını oku ve parse et
    fid = fopen(filename, 'r');
    if fid == -1
        error('COE dosyası açılamadı: %s', filename);
    end
    
    rot_lut = zeros(512, 2, 'int16');
    data_values = [];
    
    while ~feof(fid)
        line = fgetl(fid);
        if ischar(line)
            % Virgülle ayrılmış hex değerleri bul
            line = strtrim(line);
            if ~isempty(line) && ~startsWith(line, ';') && contains(line, ',')
                values = strsplit(line, ',');
                for i = 1:length(values)
                    val_str = strtrim(values{i});
                    if ~isempty(val_str) && ~strcmp(val_str, ';')
                        val_str = strrep(val_str, ';', '');
                        if ~isempty(val_str)
                            data_values(end+1) = hex2dec(val_str);
                        end
                    end
                end
            end
        end
    end
    
    fclose(fid);
    
    % Data değerlerini parse et
    for i = 1:min(512, length(data_values))
        data_val = uint32(data_values(i));
        sin_val = int16(bitand(data_val, uint32(65535)));
        cos_val = int16(bitshift(data_val, -16));
        
        if cos_val > 32767
            cos_val = int16(cos_val - 65536);
        end
        if sin_val > 32767
            sin_val = int16(sin_val - 65536);
        end
        
        rot_lut(i, :) = [cos_val, sin_val];
    end
end

function rot_lut = generate_rotate_lut()
% Analitik olarak rotate LUT oluştur
% LUT 0 ile PI/2 arası faz değerleri için sin/cos içerir
    
    ROTATE_LUT_SCALE = 2^14; % 16384
    rot_lut = zeros(512, 2, 'int16');
    
    for i = 0:511
        % Faz: 0 ile PI/2 arası, 512 adımda
        phase_rad = (i / 512.0) * (pi / 2.0);
        
        % cos ve sin hesapla, ölçeklendir ve 16-bit signed'a dönüştür
        cos_val = round(cos(phase_rad) * ROTATE_LUT_SCALE);
        sin_val = round(sin(phase_rad) * ROTATE_LUT_SCALE);
        
        % 16-bit signed range'e sığdır [-32768, 32767]
        cos_val = max(-32768, min(32767, cos_val));
        sin_val = max(-32768, min(32767, sin_val));
        
        rot_lut(i+1, :) = [int16(cos_val), int16(sin_val)];
    end
end
