%% FINE PACKET OFFSET - SIMULINK OUTPUT ANALYZER
% Simulink çıkışını analiz eder ve görselleştirir

clear; close all; clc;

fprintf('========================================\n');
fprintf('Fine Packet Offset - Simulink Output Analyzer\n');
fprintf('========================================\n\n');

%% 1. ÇIKIŞLARI KONTROLLa
fprintf('1. Simulink çıkışları kontrol ediliyor...\n');

if ~exist('simout_offset', 'var')
    fprintf('   HATA: simout_offset variable''ı bulunamadı!\n');
    fprintf('   Lütfen önce çalıştır: sim(''fine_packet_offset_sim'')\n');
    return;
else
    fprintf('   ✓ simout_offset bulundu\n');
end

%% 2. ÇIKIŞI ÇIKART VE NORMALIZE ET
fprintf('\n2. Output verisi çıkartılıyor...\n');

if istimeseries(simout_offset)
    % Timeseries format
    output_data = simout_offset.Data;
    output_time = simout_offset.Time;
    is_timeseries = true;
    fprintf('   Format: Timeseries\n');
else
    % Array format
    output_data = simout_offset;
    output_time = (1:length(output_data))';
    is_timeseries = false;
    fprintf('   Format: Array\n');
end

% 2D array ise 1D yap
if ismatrix(output_data) && size(output_data, 2) > 1
    output_data = output_data(:, 1);
end

fprintf('   Veri noktası sayısı: %d\n', length(output_data));
fprintf('   Zaman aralığı: %.4f - %.4f\n', output_time(1), output_time(end));

%% 3. İSTATİSTİKLER HESAPLA
fprintf('\n3. İstatistikler hesaplanıyor...\n');

% Temel istatistikler
mean_val = mean(output_data);
std_val = std(output_data);
min_val = min(output_data);
max_val = max(output_data);
median_val = median(output_data);

fprintf('   ┌─────────────────────────────────┐\n');
fprintf('   │ İSTATİSTİKLER                  │\n');
fprintf('   ├─────────────────────────────────┤\n');
fprintf('   │ Ortalama (Mean):    %.4f        │\n', mean_val);
fprintf('   │ Std Dev:            %.4f        │\n', std_val);
fprintf('   │ Ortanca (Median):   %.4f        │\n', median_val);
fprintf('   │ Minimum:            %.4f        │\n', min_val);
fprintf('   │ Maximum:            %.4f        │\n', max_val);
fprintf('   │ Aralık (Range):     %.4f        │\n', max_val - min_val);
fprintf('   └─────────────────────────────────┘\n');

%% 4. KARARLILIĞI KONTROL ET
fprintf('\n4. Kararlılık analizi yapılıyor...\n');

% Ardışık fark (derivative)
if length(output_data) > 1
    diff_data = diff(output_data);
    var_change = mean(abs(diff_data));
    fprintf('   Ortalama değişim (Variability): %.6f\n', var_change);
    
    if var_change < 0.1
        fprintf('   Status: ✓ STABLE (Kararlı)\n');
        stability = 'Kararlı';
    elseif var_change < 0.5
        fprintf('   Status: ⚠ MODERATE (Orta düzey)\n');
        stability = 'Orta düzey';
    else
        fprintf('   Status: ✗ UNSTABLE (Kararsız)\n');
        stability = 'Kararsız';
    end
end

%% 5. HATALI DEĞERLERI KONTROL ET
fprintf('\n5. Anomali tespit ediliyor...\n');

% NaN, Inf kontrol
num_nan = sum(isnan(output_data));
num_inf = sum(isinf(output_data));
num_valid = sum(~isnan(output_data) & ~isinf(output_data));

fprintf('   Geçerli değerler: %d (%.1f%%)\n', num_valid, 100*num_valid/length(output_data));
fprintf('   NaN değerler: %d\n', num_nan);
fprintf('   Inf değerler: %d\n', num_inf);

%% 6. GÖRSELLEŞTİRME
fprintf('\n6. Grafikleri oluşturuluyor...\n');

figure('Name', 'Simulink Output Analysis', 'NumberTitle', 'off', 'Position', [100, 100, 1400, 900]);

% Plot 1: Time Series
subplot(3, 3, 1);
plot(output_time, output_data, 'b-', 'LineWidth', 1.5);
hold on;
yline(mean_val, 'r--', sprintf('Mean: %.2f', mean_val), 'LineWidth', 2);
yline(mean_val + std_val, 'g:', 'Mean ± Std', 'LineWidth', 1.5);
yline(mean_val - std_val, 'g:', '', 'LineWidth', 1.5);
grid on;
xlabel('Time');
ylabel('Offset (samples)');
title('Fine Packet Offset - Zaman Serileri');
legend('Output', 'Mean', 'Std Dev');

% Plot 2: Histogram
subplot(3, 3, 2);
histogram(output_data, 30, 'Normalization', 'probability');
grid on;
xlabel('Offset (samples)');
ylabel('Probability');
title('Offset Dağılımı');

% Plot 3: Box Plot
subplot(3, 3, 3);
boxplot(output_data, 'Labels', {'Fine Offset'});
grid on;
ylabel('Offset (samples)');
title('Box Plot');

% Plot 4: Ardışık Fark (Variability)
subplot(3, 3, 4);
if length(diff_data) > 0
    plot(output_time(2:end), diff_data, 'r-', 'LineWidth', 1);
    grid on;
    xlabel('Time');
    ylabel('Δ Offset (samples)');
    title('Offset Değişimi (First Derivative)');
    yline(0, 'k--', 'LineWidth', 0.5);
end

% Plot 5: Cumulative Distribution
subplot(3, 3, 5);
[cumsum_hist, edges] = histcounts(output_data, 30, 'Normalization', 'cumulative');
centers = (edges(1:end-1) + edges(2:end)) / 2;
plot(centers, cumsum_hist, 'g-', 'LineWidth', 2);
grid on;
xlabel('Offset (samples)');
ylabel('Cumulative Probability');
title('Kümülatif Dağılım');

% Plot 6: Autocorrelation
subplot(3, 3, 6);
% NaN'ları kaldır
valid_data = output_data(~isnan(output_data));
if length(valid_data) > 1
    acf = autocorr(valid_data, min(30, length(valid_data)-1));
    stem(acf, 'b', 'LineWidth', 1);
    grid on;
    xlabel('Lag');
    ylabel('Autocorrelation');
    title('Oto-Korelasyon');
    yline(0, 'k--', 'LineWidth', 0.5);
end

% Plot 7: Deviation from Mean
subplot(3, 3, 7);
deviation = output_data - mean_val;
plot(output_time, deviation, 'm-', 'LineWidth', 1);
hold on;
yline(std_val, 'r--', 'Std Dev', 'LineWidth', 1.5);
yline(-std_val, 'r--', '', 'LineWidth', 1.5);
grid on;
xlabel('Time');
ylabel('Deviation (samples)');
title('Ortalamadan Sapma');

% Plot 8: 2-D Scatter (Time vs Value)
subplot(3, 3, 8);
scatter(output_time, output_data, 30, 1:length(output_data), 'filled');
colorbar('Label', 'Sequence Index');
grid on;
xlabel('Time');
ylabel('Offset (samples)');
title('Zaman-Değer Dağılımı');

% Plot 9: Statistical Summary
subplot(3, 3, 9);
axis off;
stats_text = sprintf([...
    'İSTATİSTİKLER\n'...
    '─────────────────\n'...
    'N: %d\n'...
    'Mean: %.4f\n'...
    'Std: %.4f\n'...
    'Min: %.4f\n'...
    'Max: %.4f\n'...
    'Median: %.4f\n'...
    'Stability: %s\n'...
    'Valid: %.1f%%'], ...
    length(output_data), mean_val, std_val, min_val, max_val, median_val, stability, 100*num_valid/length(output_data));

text(0.1, 0.5, stats_text, 'FontSize', 10, 'FontFamily', 'monospace', ...
    'VerticalAlignment', 'middle');
title('Summary Statistics');

%% 7. PERFORMANS RAPORU
fprintf('\n========================================\n');
fprintf('PERFORMANS RAPORU\n');
fprintf('========================================\n');
fprintf('Tarih: %s\n', datetime('now'));
fprintf('\nVERİ ÖZETİ:\n');
fprintf('  Toplam Veri Noktası: %d\n', length(output_data));
fprintf('  Geçerli Veriler: %d (%.1f%%)\n', num_valid, 100*num_valid/length(output_data));
fprintf('  Hatalı Veriler: %d (NaN: %d, Inf: %d)\n', num_nan+num_inf, num_nan, num_inf);

fprintf('\nOFFSET DEĞERLERİ:\n');
fprintf('  Ortalama: %.4f samples\n', mean_val);
fprintf('  Std Dev: %.4f samples\n', std_val);
fprintf('  Aralık: [%.4f, %.4f]\n', min_val, max_val);
fprintf('  Genişlik: %.4f samples\n', max_val - min_val);

fprintf('\nKARASTERLILIK:\n');
fprintf('  Durum: %s\n', stability);
fprintf('  Değişkenlik: %.6f\n', var_change);

fprintf('\nDEĞERLENDİRME:\n');

% Otomatik değerlendirme
if num_valid == length(output_data) && std_val < 1
    fprintf('  ✓ Simulation başarılı\n');
    fprintf('  ✓ Output değerleri kararlı\n');
    fprintf('  ✓ Hatasız veri\n');
elseif num_valid > 0.9 * length(output_data) && std_val < 2
    fprintf('  ⚠ Simulation kısmen başarılı\n');
    fprintf('  ⚠ Bazı anomaliler var\n');
else
    fprintf('  ✗ Simulation sorunlu\n');
    fprintf('  ✗ Çok fazla hata veya sapma\n');
end

fprintf('\n========================================\n');

%% 8. KARŞILAŞTIRMA (eğer referans varsa)
fprintf('\n8. Referans karşılaştırması yapılıyor...\n');

if exist('testCases', 'var') && length(testCases) > 0
    fprintf('   Reference değerleri bulundu\n');
    
    ref_offset = testCases{1}.coarsePktOffset;
    
    % Tahmin edilen ile referans arasındaki fark
    error_from_ref = abs(output_data - ref_offset);
    mean_error = mean(error_from_ref);
    
    fprintf('   Reference Coarse Offset: %d\n', ref_offset);
    fprintf('   Ortalama Hata: %.4f samples\n', mean_error);
    
    if mean_error < 5
        fprintf('   Status: ✓ ACCEPTABLE (Kabul edilebilir)\n');
    else
        fprintf('   Status: ✗ OUT OF TOLERANCE (Tolerans dışı)\n');
    end
else
    fprintf('   Reference değerleri bulunamadı (opsiyonel)\n');
end

%% 9. SONUÇLARI DOSYAYA KAYDET
fprintf('\n9. Sonuçlar dosyaya kaydediliyor...\n');

% CSV dosyası
csv_data = table(output_time, output_data, ...
    'VariableNames', {'Time', 'EstimatedOffset'});
writetable(csv_data, 'simulink_output_analysis.csv');
fprintf('   ✓ CSV: simulink_output_analysis.csv\n');

% MAT dosyası
save('simulink_output_analysis.mat', 'output_data', 'output_time', ...
    'mean_val', 'std_val', 'min_val', 'max_val');
fprintf('   ✓ MAT: simulink_output_analysis.mat\n');

fprintf('\n========================================\n');
fprintf('ANALİZ TAMAMLANDI\n');
fprintf('========================================\n');

%% YARDIMCI FONKSİYON
function result = iif(condition, true_val, false_val)
    if condition
        result = true_val;
    else
        result = false_val;
    end
end
