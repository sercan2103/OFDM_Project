%% 802.11 Preamble Karşılaştırma Scripti (FPGA vs MATLAB Reference)
clear; clc; close all;

%% 1. Veri Tanımları (Senin Verilog Hex Verilerin)
% --- L-STF ---
l_stf_hex = [
    "05E305E3"; "EF0C004D"; "FE47F5F3"; "1246FE61"; 
    "0BC70000"; "1246FE61"; "FE47F5F3"; "EF0C004D"; 
    "05E305E3"; "004DEF0C"; "F5F3FE47"; "FE611246"; 
    "00000BC7"; "FE611246"; "F5F3FE47"; "004DEF0C"
];
% --- L-LTF ---
l_ltf_hex = [
    "EC000000"; "0193F382"; "0BBDF273"; "F43DF143"; "FFA4F91E"; "099C097A"; "EFB402A0"; "F066021F";
    "FB841350"; "F8C602CA"; "F848F598"; "08E7FE31"; "0A86F42E"; "EF33F7A7"; "F8ADFAF8"; "04BAF369";
    "08000800"; "0F430086"; "FD1FEB70"; "078201EA"; "0322077E"; "EE7D0611"; "00200EB8"; "06D4FF7A";
    "0C7C0350"; "FB180D97"; "F1430710"; "07A80B3A"; "02B4FC6E"; "0C65F567"; "05170E3A"; "FF580F67";
    "14000000"; "FF58F099"; "0517F1C6"; "0C650A99"; "02B40392"; "07A8F4C6"; "F143F8F0"; "FB18F269";
    "0C7CFCB0"; "06D40086"; "0020F148"; "EE7DF9EF"; "0322F882"; "0782FE16"; "FD1F1490"; "0F43FF7A";
    "0800F800"; "04BA0C97"; "F8AD0508"; "EF330859"; "0A860BD2"; "08E701CF"; "F8480A68"; "F8C6FD36";
    "FB84ECB0"; "F066FDE1"; "EFB4FD60"; "099CF686"; "FFA406E2"; "F43D0EBD"; "0BBD0D8D"; "01930C7E";
    "EC000000"; "0193F382"; "0BBDF273"; "F43DF143"; "FFA4F91E"; "099C097A"; "EFB402A0"; "F066021F";
    "FB841350"; "F8C602CA"; "F848F598"; "08E7FE31"; "0A86F42E"; "EF33F7A7"; "F8ADFAF8"; "04BAF369";
    "08000800"; "0F430086"; "FD1FEB70"; "078201EA"; "0322077E"; "EE7D0611"; "00200EB8"; "06D4FF7A";
    "0C7C0350"; "FB180D97"; "F1430710"; "07A80B3A"; "02B4FC6E"; "0C65F567"; "05170E3A"; "FF580F67";
    "14000000"; "FF58F099"; "0517F1C6"; "0C650A99"; "02B40392"; "07A8F4C6"; "F143F8F0"; "FB18F269";
    "0C7CFCB0"; "06D40086"; "0020F148"; "EE7DF9EF"; "0322F882"; "0782FE16"; "FD1F1490"; "0F43FF7A";
    "0800F800"; "04BA0C97"; "F8AD0508"; "EF330859"; "0A860BD2"; "08E701CF"; "F8480A68"; "F8C6FD36";
    "FB84ECB0"; "F066FDE1"; "EFB4FD60"; "099CF686"; "FFA406E2"; "F43D0EBD"; "0BBD0D8D"; "01930C7E";
    "EC000000"; "0193F382"; "0BBDF273"; "F43DF143"; "FFA4F91E"; "099C097A"; "EFB402A0"; "F066021F";
    "FB841350"; "F8C602CA"; "F848F598"; "08E7FE31"; "0A86F42E"; "EF33F7A7"; "F8ADFAF8"; "04BAF369";
    "08000800"; "0F430086"; "FD1FEB70"; "078201EA"; "0322077E"; "EE7D0611"; "00200EB8"; "06D4FF7A";
    "0C7C0350"; "FB180D97"; "F1430710"; "07A80B3A"; "02B4FC6E"; "0C65F567"; "05170E3A"; "FF580F67"
];
% --- HT-STF ---
ht_stf_hex = [
    "061C061C"; "EE680050"; "FE36F592"; "12F6FE52"; 
    "0C380000"; "12F6FE52"; "FE36F592"; "EE680050"; 
    "061C061C"; "0050EE68"; "F592FE36"; "FE5212F6"; 
    "00000C38"; "FE5212F6"; "F592FE36"; "0050EE68"
];
% --- HT-LTF ---
ht_ltf_hex = [
    "08000400"; "0F430285"; "FD1FEC0B"; "0782FE9C"; "03220D06"; "EE7DFF47"; "00201579"; "06D4FA1F";
    "0C7C0624"; "FB180DF6"; "F1430374"; "07A81176"; "02B4F4BC"; "0C65FD14"; "05170813"; "FF5812D1";
    "14000000"; "FF58ED2F"; "0517F7ED"; "0C6502EC"; "02B40B44"; "07A8EE8A"; "F143FC8C"; "FB18F20A";
    "0C7CF9DC"; "06D405E1"; "0020EA87"; "EE7D00B9"; "0322F2FA"; "07820164"; "FD1F13F5"; "0F43FD7B";
    "0800FC00"; "04BA0788"; "F8AD0A15"; "EF330443"; "0A860E4A"; "08E70134"; "F848094F"; "F8C6FF82";
    "FB84E9DC"; "F0660092"; "EFB4FB54"; "099CF7AE"; "FFA40694"; "F43D0E74"; "0BBD0E0D"; "01930C23";
    "EC000000"; "0193F3DD"; "0BBDF1F3"; "F43DF18C"; "FFA4F96C"; "099C0852"; "EFB404AC"; "F066FF6E";
    "FB841624"; "F8C6007E"; "F848F6B1"; "08E7FECC"; "0A86F1B6"; "EF33FBBD"; "F8ADF5EB"; "04BAF878";
    "08000400"; "0F430285"; "FD1FEC0B"; "0782FE9C"; "03220D06"; "EE7DFF47"; "00201579"; "06D4FA1F";
    "0C7C0624"; "FB180DF6"; "F1430374"; "07A81176"; "02B4F4BC"; "0C65FD14"; "05170813"; "FF5812D1"
];

%% 2. MATLAB Referans Sinyallerini Oluşturma (WLAN Toolbox)
% Standart 20MHz konfigürasyonu
cfg = wlanHTConfig('ChannelBandwidth', 'CBW20');

% MATLAB Sinyallerini Üret (Zaman domeninde)
ref_lstf  = wlanLSTF(cfg);
ref_lltf  = wlanLLTF(cfg);
ref_htstf = wlanHTSTF(cfg);
ref_htltf = wlanHTLTF(cfg);

%% 3. FPGA Verilerini İşleme (Hex -> Complex)
l_stf_fpga  = repmat(hex2iq(l_stf_hex), 10, 1);
l_ltf_fpga  = hex2iq(l_ltf_hex);
ht_stf_fpga = repmat(hex2iq(ht_stf_hex), 5, 1);
ht_ltf_fpga = hex2iq(ht_ltf_hex);

%% 4. Karşılaştırma ve Normalizasyon Fonksiyonu
% Bu fonksiyon her iki sinyali de Max genliğe göre 1'e eşitler.
compare_signals(l_stf_fpga, ref_lstf, 'L-STF Comparison');
compare_signals(l_ltf_fpga, ref_lltf, 'L-LTF Comparison');
compare_signals(ht_stf_fpga, ref_htstf, 'HT-STF Comparison');
compare_signals(ht_ltf_fpga, ref_htltf, 'HT-LTF Comparison');

%% YARDIMCI FONKSİYONLAR %%

function compare_signals(fpga_sig, matlab_sig, fig_title)
    % Uzunluk Kontrolü
    len = min(length(fpga_sig), length(matlab_sig));
    fpga_sig = fpga_sig(1:len);
    matlab_sig = matlab_sig(1:len);
    
    % Normalizasyon (ÖNEMLİ: Hardware integer, Matlab float olduğu için)
    % Her ikisini de maksimum mutlak değeri 1 olacak şekilde ölçekle.
    fpga_norm = fpga_sig / max(abs(fpga_sig));
    matlab_norm = matlab_sig / max(abs(matlab_sig));
    
    % Hata Hesabı (Magnitude farkı)
    error_sig = abs(fpga_norm - matlab_norm);
    
    figure('Name', fig_title, 'Position', [100, 100, 1000, 600]);
    
    % Subplot 1: Real Part (In-Phase) Comparison
    subplot(2,1,1);
    plot(real(fpga_norm), 'b', 'LineWidth', 1.5); hold on;
    plot(real(matlab_norm), 'r--', 'LineWidth', 1.5);
    title([fig_title ' - Real Part (Normalized)']);
    legend('FPGA (User HEX)', 'MATLAB Reference');
    xlabel('Sample Index'); ylabel('Normalized Amplitude');
    grid on;
    
    % Subplot 2: Imaginary Part Comparison
    subplot(2,1,2);
    plot(imag(fpga_norm), 'b', 'LineWidth', 1.5); hold on;
    plot(imag(matlab_norm), 'r--', 'LineWidth', 1.5);
    title([fig_title ' - Imaginary Part (Normalized)']);
    legend('FPGA (User HEX)', 'MATLAB Reference');
    xlabel('Sample Index'); ylabel('Normalized Amplitude');
    grid on;
    
    % Konsola MSE (Mean Squared Error) yazdır
    mse_val = mean(abs(fpga_norm - matlab_norm).^2);
    fprintf('%s -> MSE: %.6f\n', fig_title, mse_val);
end

function complex_data = hex2iq(hex_array)
    hex_char = char(hex_array);
    i_hex = hex_char(:, 1:4);
    q_hex = hex_char(:, 5:8);
    i_val = typecast(uint16(hex2dec(i_hex)), 'int16');
    q_val = typecast(uint16(hex2dec(q_hex)), 'int16');
    complex_data = double(i_val) + 1j * double(q_val);
end