function [out_i, out_q] = rotate_fixed_point(in_i, in_q, phase)
% ROTATE_FIXED_POINT - Fixed-point faz rotasyon fonksiyonu
%
% AÇIKLAMA:
%   Bu fonksiyon, rotate.v Verilog modülünün birebir MATLAB 
%   implementasyonudur. Fixed-point aritmetiği ve LUT kullanır.
%
% AMAÇ:
%   - Kompleks sayıyı verilen faz kadar döndürmek
%   - Verilog donanımının davranışını tam olarak taklit etmek
%
% GİRİŞLER:
%   in_i   : 16-bit signed I bileşeni
%   in_q   : 16-bit signed Q bileşeni
%   phase  : 16-bit signed faz değeri [-PI, PI] (ölçeklenmiş)
%
% ÇIKIŞLAR:
%   out_i  : 16-bit signed döndürülmüş I bileşeni
%   out_q  : 16-bit signed döndürülmüş Q bileşeni
%
% VERILOG REFERANSI:
%   rotate.v (satır 1-164)
%
% FIXED-POINT DETAYLARI:
%   - PI = 1608 (ATAN_LUT_SCALE_SHIFT = 9 ile ölçeklenmiş)
%   - ROTATE_LUT_SCALE_SHIFT = 14
%   - LUT boyutu: 512 (ROTATE_LUT_LEN_SHIFT = 9)
%
% ÖRNEK:
%   [out_i, out_q] = rotate_fixed_point(int16(100), int16(50), int16(400));
%
% YAZAR: GitHub Copilot
% TARİH: 2026-01-31

%% SABİTLER
PI = int16(1608);
PI_2 = int16(804);
PI_4 = int16(402);
PI_3_4 = int16(1206);
ROTATE_LUT_SCALE_SHIFT = 14;

%% TİP DÖNÜŞÜMÜ
in_i = int16(in_i);
in_q = int16(in_q);
phase = int16(phase);

%% PERSISTENT ROTATE LUT (İlk çağrıda yükle, sonraki çağrılarda kullan)
persistent rot_lut;
if isempty(rot_lut)
    rot_lut = load_rotate_lut();
end

%% FAZ MUTLAK DEĞERİ (rotate.v satır 102)
if phase < 0
    phase_abs = int16(-phase);
else
    phase_abs = phase;
end

%% QUADRANT BELİRLEME (rotate.v satır 105-119)
% Phase'in işareti ve büyüklüğüne göre quadrant belirle
phase_sign = bitget(uint16(phase), 16); % En üst bit (işaret biti)

if phase_abs <= PI_4
    quadrant = phase_sign * 4 + 0;
    actual_phase = phase_abs;
elseif phase_abs <= PI_2
    quadrant = phase_sign * 4 + 1;
    actual_phase = int16(PI_2 - phase_abs);
elseif phase_abs <= PI_3_4
    quadrant = phase_sign * 4 + 2;
    actual_phase = int16(phase_abs - PI_2);
else
    quadrant = phase_sign * 4 + 3;
    actual_phase = int16(PI - phase_abs);
end

%% LUT'TAN SIN/COS DEĞERLERINI AL (rotate.v satır 46-47)
% actual_phase'in alt 9 biti LUT adresi olarak kullanılır
lut_addr = uint16(bitand(uint16(actual_phase), uint16(511))) + 1; % MATLAB 1-indexed
raw_rot_i = rot_lut(lut_addr, 1); % cos değeri
raw_rot_q = rot_lut(lut_addr, 2); % sin değeri

%% QUADRANT'A GÖRE ROT_I ve ROT_Q BELİRLE (rotate.v satır 124-162)
switch quadrant
    case 0 % 3'b000: [0, PI/4]
        rot_i = raw_rot_i;
        rot_q = raw_rot_q;
    case 1 % 3'b001: [PI/4, PI/2]
        rot_i = raw_rot_q;
        rot_q = raw_rot_i;
    case 2 % 3'b010: [PI/2, 3PI/4]
        rot_i = int16(-raw_rot_q);
        rot_q = raw_rot_i;
    case 3 % 3'b011: [3PI/4, PI]
        rot_i = int16(-raw_rot_i);
        rot_q = raw_rot_q;
    case 4 % 3'b100: [-PI/4, 0]
        rot_i = raw_rot_i;
        rot_q = int16(-raw_rot_q);
    case 5 % 3'b101: [-PI/2, -PI/4]
        rot_i = raw_rot_q;
        rot_q = int16(-raw_rot_i);
    case 6 % 3'b110: [-3PI/4, -PI/2]
        rot_i = int16(-raw_rot_q);
        rot_q = int16(-raw_rot_i);
    case 7 % 3'b111: [-PI, -3PI/4]
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

%% ÖLÇEKLEME (rotate.v satır 42-43)
% ROTATE_LUT_SCALE_SHIFT (14 bit) kadar sağa kaydır
out_i = int16(bitshift(p_i_temp, -ROTATE_LUT_SCALE_SHIFT));
out_q = int16(bitshift(p_q_temp, -ROTATE_LUT_SCALE_SHIFT));

end

%% YARDIMCI FONKSİYON: ROTATE LUT YÜKLEME
function rot_lut = load_rotate_lut()
% LOAD_ROTATE_LUT - rot_lut.mif veya rot_lut.coe'den LUT yükle
%
% Bu fonksiyon Verilog'daki rot_lut ROM'unun MATLAB karşılığıdır.

    verilog_path = '/home/kemal/Desktop/New_Folder/openwifi-hw/ip/openofdm_rx/verilog';
    
    % Dosya yolları
    mif_file = fullfile(verilog_path, 'rot_lut.mif');
    coe_file = fullfile(verilog_path, 'rot_lut.coe');
    
    if exist(mif_file, 'file')
        rot_lut = read_mif_file(mif_file);
    elseif exist(coe_file, 'file')
        rot_lut = read_coe_file(coe_file);
    else
        warning('rot_lut.mif veya .coe bulunamadı. Analitik LUT oluşturuluyor.');
        rot_lut = generate_rotate_lut();
    end
end

function rot_lut = read_mif_file(filename)
% MIF dosyasını oku
    fid = fopen(filename, 'r');
    if fid == -1
        error('MIF dosyası açılamadı: %s', filename);
    end
    
    rot_lut = zeros(512, 2, 'int16');
    
    while ~feof(fid)
        line = fgetl(fid);
        if ischar(line)
            % Format: "address : data;"
            tokens = regexp(line, '(\d+)\s*:\s*([0-9A-Fa-f]+)\s*;', 'tokens');
            if ~isempty(tokens)
                addr_val = str2double(tokens{1}{1});
                data_hex = tokens{1}{2};
                
                % 32-bit parse: [31:16]=cos, [15:0]=sin
                data_val = uint32(hex2dec(data_hex));
                sin_val = typecast(uint16(bitand(data_val, uint32(65535))), 'int16');
                cos_val = typecast(uint16(bitshift(data_val, -16)), 'int16');
                
                rot_lut(addr_val + 1, :) = [cos_val, sin_val];
            end
        end
    end
    
    fclose(fid);
end

function rot_lut = read_coe_file(filename)
% COE dosyasını oku
    fid = fopen(filename, 'r');
    if fid == -1
        error('COE dosyası açılamadı: %s', filename);
    end
    
    rot_lut = zeros(512, 2, 'int16');
    data_values = [];
    
    while ~feof(fid)
        line = fgetl(fid);
        if ischar(line)
            line = strtrim(line);
            if ~isempty(line) && ~startsWith(line, ';')
                % Virgülle ayrılmış değerleri parse et
                values = strsplit(strrep(line, ';', ''), ',');
                for i = 1:length(values)
                    val_str = strtrim(values{i});
                    if ~isempty(val_str)
                        data_values(end+1) = hex2dec(val_str);
                    end
                end
            end
        end
    end
    
    fclose(fid);
    
    % Data değerlerini LUT'a dönüştür
    for i = 1:min(512, length(data_values))
        data_val = uint32(data_values(i));
        sin_val = typecast(uint16(bitand(data_val, uint32(65535))), 'int16');
        cos_val = typecast(uint16(bitshift(data_val, -16)), 'int16');
        
        rot_lut(i, :) = [cos_val, sin_val];
    end
end

function rot_lut = generate_rotate_lut()
% Analitik olarak LUT oluştur (eğer dosya bulunamazsa)
    
    ROTATE_LUT_SCALE = 2^14; % 16384
    rot_lut = zeros(512, 2, 'int16');
    
    for i = 0:511
        % Faz: 0 ile PI/2 arası
        phase_rad = (i / 512.0) * (pi / 2.0);
        
        cos_val = round(cos(phase_rad) * ROTATE_LUT_SCALE);
        sin_val = round(sin(phase_rad) * ROTATE_LUT_SCALE);
        
        % 16-bit signed range'e sığdır
        cos_val = max(-32768, min(32767, cos_val));
        sin_val = max(-32768, min(32767, sin_val));
        
        rot_lut(i+1, :) = [int16(cos_val), int16(sin_val)];
    end
end
