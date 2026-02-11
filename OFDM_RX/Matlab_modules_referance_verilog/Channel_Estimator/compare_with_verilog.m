%% COMPARE_WITH_VERILOG - Verilog Çıkışı ile Karşılaştırma
% Bu script MATLAB ve Verilog çıkışlarını karşılaştırır
%
% KULLANIM:
%   1. Verilog testbench'i çalıştır ve output'ları kaydet
%   2. verilog_output.mat dosyasına yükle
%   3. Bu scripti çalıştır
%
% GEREKLİ DOSYALAR:
%   - test_input.mat (MATLAB generate_test_data.m)
%   - verilog_output.mat (Verilog testbench)
%
% AUTHOR: Generated for Channel Estimator
% DATE: 2026-01-31

clear all;
close all;
clc;

fprintf('=== VERILOG KARŞILAŞTIRMA ===\n\n');

%% 1. Test Verisini Yükle
fprintf('1. Test verisi yukleniyor...\n');

if ~exist('test_input.mat', 'file')
    error('test_input.mat bulunamadi! Once generate_test_data.m calistirin.');
end

load('test_input.mat');
fprintf('   - test_input.mat yuklendi\n');

%% 2. Verilog Çıkışını Yükle
fprintf('\n2. Verilog cikisi yukleniyor...\n');

if ~exist('verilog_output.mat', 'file')
    warning('verilog_output.mat bulunamadi!');
    fprintf('   [UYARI] Verilog testbench cikisini verilog_output.mat olarak kaydedin.\n');
    fprintf('   Ornek format:\n');
    fprintf('   verilog_output.sample_out = [...];  %% Equalized samples\n');
    fprintf('   verilog_output.csi = [...];         %% Channel estimates\n');
    fprintf('   save(''verilog_output.mat'', ''verilog_output'');\n\n');
    
    % Demo mode - sadece MATLAB çıkışını göster
    use_demo_mode = true;
else
    load('verilog_output.mat');
    fprintf('   - verilog_output.mat yuklendi\n');
    use_demo_mode = false;
end

%% 3. MATLAB Channel Estimator Çalıştır
fprintf('\n3. MATLAB Channel Estimator calistiriliyor...\n');

% Rotation LUT
rot_lut = generate_rotation_lut();

% Çalıştır
[matlab_sample_out, matlab_strobe, matlab_csi, matlab_csi_valid, matlab_state] = ...
    channel_estimator_fixed(test_input.sample_in, test_input.sample_in_strobe, ...
                           test_input.ht_next, test_input.pkt_ht, ...
                           test_input.ht_smoothing, test_input.disable_all_smoothing, ...
                           rot_lut, []);

fprintf('   - MATLAB islemi tamamlandi\n');
fprintf('   - Output sample sayisi: %d\n', length(matlab_sample_out));
fprintf('   - CSI sample sayisi: %d\n', length(matlab_csi));

%% 4. Karşılaştırma
fprintf('\n4. Sonuclar karsilastiriliyor...\n');

if ~use_demo_mode
    %% 4a. Sample Output Karşılaştırması
    if isfield(verilog_output, 'sample_out')
        verilog_samples = verilog_output.sample_out;
        matlab_samples = matlab_sample_out;
        
        % Uzunluk kontrolü
        min_len = min(length(verilog_samples), length(matlab_samples));
        
        if length(verilog_samples) ~= length(matlab_samples)
            warning('Output uzunluklari farkli! Verilog: %d, MATLAB: %d', ...
                    length(verilog_samples), length(matlab_samples));
        end
        
        % Real kısım farkları
        diff_real = abs(real(matlab_samples(1:min_len)) - real(verilog_samples(1:min_len)));
        diff_imag = abs(imag(matlab_samples(1:min_len)) - imag(verilog_samples(1:min_len)));
        
        max_diff_real = max(diff_real);
        max_diff_imag = max(diff_imag);
        mean_diff_real = mean(diff_real);
        mean_diff_imag = mean(diff_imag);
        
        fprintf('\n   Equalized Samples Karsilastirmasi:\n');
        fprintf('   - Max Real fark: %d\n', max_diff_real);
        fprintf('   - Max Imag fark: %d\n', max_diff_imag);
        fprintf('   - Ortalama Real fark: %.2f\n', mean_diff_real);
        fprintf('   - Ortalama Imag fark: %.2f\n', mean_diff_imag);
        
        % Bit-accuracy kontrolü
        tolerance = 2;  % 2 LSB tolerans
        if max_diff_real <= tolerance && max_diff_imag <= tolerance
            fprintf('   ✓ BIT-ACCURATE! (tolerans: %d LSB)\n', tolerance);
        else
            fprintf('   ✗ FARK VAR! (tolerans: %d LSB)\n', tolerance);
        end
    else
        fprintf('   [UYARI] Verilog output''ta sample_out bulunamadi\n');
    end
    
    %% 4b. CSI Karşılaştırması
    if isfield(verilog_output, 'csi')
        verilog_csi = verilog_output.csi;
        
        min_len_csi = min(length(verilog_csi), length(matlab_csi));
        
        diff_csi_real = abs(real(matlab_csi(1:min_len_csi)) - real(verilog_csi(1:min_len_csi)));
        diff_csi_imag = abs(imag(matlab_csi(1:min_len_csi)) - imag(verilog_csi(1:min_len_csi)));
        
        max_diff_csi_real = max(diff_csi_real);
        max_diff_csi_imag = max(diff_csi_imag);
        
        fprintf('\n   CSI Karsilastirmasi:\n');
        fprintf('   - Max Real fark: %d\n', max_diff_csi_real);
        fprintf('   - Max Imag fark: %d\n', max_diff_csi_imag);
        
        if max_diff_csi_real <= tolerance && max_diff_csi_imag <= tolerance
            fprintf('   ✓ CSI BIT-ACCURATE!\n');
        else
            fprintf('   ✗ CSI FARKLI!\n');
        end
    else
        fprintf('   [UYARI] Verilog output''ta csi bulunamadi\n');
    end
    
else
    fprintf('   [DEMO MODE] Verilog cikisi yok, sadece MATLAB sonuclari gosteriliyor\n');
end

%% 5. Grafik
fprintf('\n5. Grafik ciziliyor...\n');

figure('Name', 'MATLAB vs Verilog Comparison', 'Position', [100 100 1400 900]);

if ~use_demo_mode && isfield(verilog_output, 'sample_out')
    % Subplot 1: MATLAB Constellation
    subplot(2, 3, 1);
    plot(real(matlab_sample_out), imag(matlab_sample_out), 'bo', 'MarkerSize', 6);
    grid on;
    title('MATLAB - Equalized Data');
    xlabel('Real');
    ylabel('Imaginary');
    axis equal;
    
    % Subplot 2: Verilog Constellation
    subplot(2, 3, 2);
    plot(real(verilog_samples), imag(verilog_samples), 'ro', 'MarkerSize', 6);
    grid on;
    title('Verilog - Equalized Data');
    xlabel('Real');
    ylabel('Imaginary');
    axis equal;
    
    % Subplot 3: Difference
    subplot(2, 3, 3);
    stem(diff_real, 'b', 'filled');
    hold on;
    stem(diff_imag, 'r', 'filled');
    grid on;
    title('Difference (MATLAB - Verilog)');
    xlabel('Sample Index');
    ylabel('Absolute Difference');
    legend('Real', 'Imag');
    
    % Subplot 4: Real Part Comparison
    subplot(2, 3, 4);
    plot(real(matlab_samples(1:min_len)), 'b.-', 'LineWidth', 1.5);
    hold on;
    plot(real(verilog_samples(1:min_len)), 'r--', 'LineWidth', 1.5);
    grid on;
    title('Real Part Comparison');
    xlabel('Sample Index');
    ylabel('Real Value');
    legend('MATLAB', 'Verilog');
    
    % Subplot 5: Imag Part Comparison
    subplot(2, 3, 5);
    plot(imag(matlab_samples(1:min_len)), 'b.-', 'LineWidth', 1.5);
    hold on;
    plot(imag(verilog_samples(1:min_len)), 'r--', 'LineWidth', 1.5);
    grid on;
    title('Imaginary Part Comparison');
    xlabel('Sample Index');
    ylabel('Imag Value');
    legend('MATLAB', 'Verilog');
    
    % Subplot 6: Error Distribution
    subplot(2, 3, 6);
    histogram(diff_real, 'FaceColor', 'b', 'FaceAlpha', 0.5);
    hold on;
    histogram(diff_imag, 'FaceColor', 'r', 'FaceAlpha', 0.5);
    grid on;
    title('Error Distribution');
    xlabel('Absolute Difference');
    ylabel('Count');
    legend('Real', 'Imag');
    
else
    % Demo mode - sadece MATLAB
    subplot(2, 2, 1);
    plot(real(matlab_sample_out), imag(matlab_sample_out), 'bo', 'MarkerSize', 6);
    grid on;
    title('MATLAB - Equalized Data');
    xlabel('Real');
    ylabel('Imaginary');
    axis equal;
    
    subplot(2, 2, 2);
    plot(abs(matlab_sample_out), 'b.-');
    grid on;
    title('MATLAB - Magnitude');
    xlabel('Sample Index');
    ylabel('Magnitude');
    
    subplot(2, 2, 3);
    plot(angle(matlab_sample_out)*180/pi, 'r.-');
    grid on;
    title('MATLAB - Phase');
    xlabel('Sample Index');
    ylabel('Phase (degrees)');
    
    subplot(2, 2, 4);
    stem(abs(matlab_csi), 'filled');
    grid on;
    title('MATLAB - CSI');
    xlabel('Subcarrier Index');
    ylabel('|H|');
end

fprintf('   - Grafik cizildi\n');

fprintf('\n=== KARŞILAŞTIRMA TAMAMLANDI ===\n');

%% Yardımcı Fonksiyon
function rot_lut = generate_rotation_lut()
    T_int16 = numerictype(1, 16, 0);
    LUT_SIZE = 512;
    SCALE = 2048;
    
    rot_lut = fi(zeros(LUT_SIZE, 1), T_int16, T_int16, T_int16);
    
    for i = 0:LUT_SIZE-1
        theta = 2 * pi * i / LUT_SIZE;
        rot_val = exp(1j * theta) * SCALE;
        rot_lut(i+1) = fi(rot_val, T_int16, T_int16, T_int16);
    end
end
