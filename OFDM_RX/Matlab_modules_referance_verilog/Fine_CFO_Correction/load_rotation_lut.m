function rot_lut = load_rotation_lut(lut_file_path)
% LOAD_ROTATION_LUT - Rotasyon LUT tablosunu yükler
%
% Verilog'daki rot_lut.coe veya rot_lut.mif dosyasından 
% sin/cos değerlerini okur ve MATLAB formatına dönüştürür.
%
% INPUTS:
%   lut_file_path - (Opsiyonel) LUT dosyasının yolu
%                   Varsayılan: Verilog workspace'deki rot_lut.coe
%
% OUTPUTS:
%   rot_lut - LUT yapısı
%             .sin_lut: 512 elemanlı sine LUT (16-bit signed)
%             .cos_lut: 512 elemanlı cosine LUT (16-bit signed)
%             .num_entries: Giriş sayısı (512)
%             .scale_shift: Ölçek kaydırma değeri (11)
%
% NOT: 
% - LUT formatı: Her entry 32-bit, [31:16]=cos, [15:0]=sin
% - Signed 16-bit fixed-point format
% - Scale: 2^11 = 2048
%
% ÖRNEK:
%   rot_lut = load_rotation_lut();
%   % veya
%   rot_lut = load_rotation_lut('/path/to/rot_lut.coe');

%% Parametreler
ROTATE_LUT_LEN_SHIFT = 9;
ROTATE_LUT_SCALE_SHIFT = 11;
NUM_ENTRIES = 2^ROTATE_LUT_LEN_SHIFT;  % 512

%% Varsayılan LUT dosya yolu
if nargin < 1 || isempty(lut_file_path)
    % Verilog workspace'in varsayılan yolu
    verilog_path = '/home/kemal/Desktop/New_Folder/openwifi-hw/ip/openofdm_rx/verilog';
    lut_file_path = fullfile(verilog_path, 'rot_lut.coe');
end

%% LUT dosyasını oku
if exist(lut_file_path, 'file')
    % .coe dosyası varsa oku
    rot_lut = read_coe_file(lut_file_path, NUM_ENTRIES);
else
    % Dosya yoksa, matematiksel olarak oluştur
    warning('LUT dosyası bulunamadı: %s\nMatematiksel olarak oluşturuluyor...', lut_file_path);
    rot_lut = generate_rotation_lut(NUM_ENTRIES, ROTATE_LUT_SCALE_SHIFT);
end

%% LUT bilgilerini ekle
rot_lut.num_entries = NUM_ENTRIES;
rot_lut.scale_shift = ROTATE_LUT_SCALE_SHIFT;
rot_lut.scale_factor = 2^ROTATE_LUT_SCALE_SHIFT;

end

%% Yardımcı fonksiyon: COE dosyasını oku
function rot_lut = read_coe_file(filename, num_entries)
    % Xilinx COE formatını okur
    % Format: memory_initialization_radix=16;
    %         memory_initialization_vector=
    %         value1,
    %         value2,
    %         ...
    
    fid = fopen(filename, 'r');
    if fid == -1
        error('COE dosyası açılamadı: %s', filename);
    end
    
    % Başlık satırlarını atla
    line = fgetl(fid);
    while ~contains(line, 'memory_initialization_vector')
        line = fgetl(fid);
        if ~ischar(line)
            error('COE dosyası formatı hatalı');
        end
    end
    
    % Değerleri oku
    cos_lut = zeros(num_entries, 1);
    sin_lut = zeros(num_entries, 1);
    
    for i = 1:num_entries
        line = fgetl(fid);
        if ~ischar(line)
            break;
        end
        
        % Satırı temizle (virgül, boşluk, noktalı virgül kaldır)
        line = strrep(line, ',', '');
        line = strrep(line, ';', '');
        line = strtrim(line);
        
        if isempty(line)
            continue;
        end
        
        % Hex değeri oku (32-bit)
        hex_val = hex2dec(line);
        
        % 32-bit değeri cos (üst 16-bit) ve sin (alt 16-bit) olarak ayır
        cos_val = bitshift(hex_val, -16);  % Üst 16-bit
        sin_val = bitand(hex_val, hex2dec('FFFF'));  % Alt 16-bit
        
        % Signed 16-bit'e dönüştür
        if cos_val >= 2^15
            cos_val = cos_val - 2^16;
        end
        if sin_val >= 2^15
            sin_val = sin_val - 2^16;
        end
        
        cos_lut(i) = cos_val;
        sin_lut(i) = sin_val;
    end
    
    fclose(fid);
    
    rot_lut.cos_lut = cos_lut;
    rot_lut.sin_lut = sin_lut;
end

%% Yardımcı fonksiyon: LUT'u matematiksel olarak oluştur
function rot_lut = generate_rotation_lut(num_entries, scale_shift)
    % Matematiksel olarak sin/cos LUT oluşturur
    
    ATAN_LUT_SCALE_SHIFT = 9;
    PI_scaled = 1608;  % π * 2^ATAN_LUT_SCALE_SHIFT
    
    scale_factor = 2^scale_shift;
    
    cos_lut = zeros(num_entries, 1);
    sin_lut = zeros(num_entries, 1);
    
    for i = 0:(num_entries-1)
        % Faz değeri: 0'dan π/4'e kadar
        % i değeri 0'dan 511'e kadar (512 entry)
        % Phase aralığı: [0, π/4] (actual_phase değeri)
        
        % Verilog'da: actual_phase değeri 0'dan PI_4'e kadar olabilir
        % PI_4 = 1608/4 = 402
        % LUT index'i: actual_phase[8:0] (9-bit)
        % Bu da 0-511 arası değer demek
        
        % Phase hesaplama: 
        % actual_phase maksimum PI_4 = 402 olabilir
        % Ama LUT 512 giriş var, bu yüzden tüm 0-511 için değer üret
        
        % Gerçek faz açısı (radyan)
        phase_rad = (i / num_entries) * (pi / 4);  % 0'dan π/4'e kadar
        
        % Cos ve sin değerlerini hesapla ve ölçeklendir
        cos_val = round(cos(phase_rad) * scale_factor);
        sin_val = round(sin(phase_rad) * scale_factor);
        
        % 16-bit signed sınırları içinde tut
        cos_val = max(-32768, min(32767, cos_val));
        sin_val = max(-32768, min(32767, sin_val));
        
        cos_lut(i+1) = cos_val;
        sin_lut(i+1) = sin_val;
    end
    
    rot_lut.cos_lut = cos_lut;
    rot_lut.sin_lut = sin_lut;
end
