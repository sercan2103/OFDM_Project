%% FINE PACKET OFFSET ESTIMATOR - TEST & OUTPUT ANALYZER
% Fonksiyonu test eder ve output'u ölçer
% Fonksiyon: offset = fcn(rx, coarsePktOffset, simParams)

clear all; close all; clc;

RUN_FROM_TESTER = true;

fprintf('========================================\n');
fprintf('Fine Packet Offset - Tester\n');
fprintf('========================================\n\n');

%% 1. İNPUT'LAR YÜKLESİN HAZIR MI?
fprintf('1. Input''lar kontrol ediliyor...\n');

if ~exist('testCases', 'var') || ~exist('simParams', 'var')
    fprintf('   Input''lar hazır değil, oluşturuluyor...\n');
    run('fine_packet_offset_input_generator.m');
end

if ~exist('testCases', 'var') || ~exist('simParams', 'var')
    fprintf('   HATA: Input''lar hazır değil!\n');
    fprintf('   Lütfen önce çalıştır: fine_packet_offset_input_generator\n');
    return;
end

fprintf('   ✓ Test case''leri bulundu (%d paket)\n', length(testCases));
fprintf('   ✓ Simülasyon parametreleri bulundu\n');

%% 2. FONKSİYON DOSYASINI KONTROL ET
fprintf('\n2. Fonksiyon dosyası kontrol ediliyor...\n');

% Eğer fonksiyon dosyası yoksa template oluştur
if ~isfile('fine_packet_offset_fcn.m')
    fprintf('   UYARI: fine_packet_offset_fcn.m dosyası bulunamadı.\n');
    fprintf('   Template dosyası oluşturuluyor...\n');
    create_function_template();
    fprintf('   ✓ Template oluşturuldu: fine_packet_offset_fcn.m\n');
else
    fprintf('   ✓ Fonksiyon dosyası bulundu\n');
end

%% 3. TEST'İ ÇALIŞTIR
fprintf('\n3. Test çalıştırılıyor...\n\n');

% Sonuçları saklamak için struct
results = struct('packetIdx', {}, 'estimatedOffset', {}, 'trueOffset', {}, ...
                 'error', {}, 'success', {}, 'executionTime', {});

num_tests = length(testCases);

for test_idx = 1:num_tests
    fprintf('   Test %d/%d ', test_idx, num_tests);
    
    test = testCases{test_idx};
    
    % Zamanı ölç
    tic;
    
    % Fonksiyonu çağır
    try
        offset = fine_packet_offset_fcn(test.rx, test.coarsePktOffset, test.simParams);
        exec_time = toc;
        
        % Sonuçları hesapla
        expected_offset = test.coarsePktOffset + test.trueFinePktOffset;
        error = abs(offset - expected_offset);
        success = error < 5;  % 5 sample toleransı
        
        RUN_FROM_TESTER = true;
        % Sonuçları kaydet
        results(test_idx).packetIdx = test_idx;
        results(test_idx).estimatedOffset = offset;
        results(test_idx).trueOffset = test.coarsePktOffset;
        results(test_idx).error = error;
        results(test_idx).success = success;
        results(test_idx).executionTime = exec_time;
        
        % Console output
        status_str = sprintf('[%s]', iif(success, 'PASS', 'FAIL'));
        fprintf('%s Estimated: %.2f, Error: %.2f samples, Time: %.3f ms\n', ...
            status_str, offset, error, exec_time*1000);
        
    catch ME
        fprintf('[ERROR] %s\n', ME.message);
        results(test_idx).packetIdx = test_idx;
        results(test_idx).estimatedOffset = NaN;
        results(test_idx).trueOffset = test.coarsePktOffset;
        results(test_idx).error = NaN;
        results(test_idx).success = false;
        results(test_idx).executionTime = NaN;
    end
end

%% 4. SONUÇLAR ANALİZİ
fprintf('\n========================================\n');
fprintf('SONUÇLAR ÖZETI\n');
fprintf('========================================\n\n');

% Başarılı testleri say
successful = sum([results.success]);
errors = [results.error];
valid_errors = errors(~isnan(errors));
if isempty(valid_errors)
    total_error = NaN;
else
    total_error = mean(valid_errors);
end

exec_times = [results.executionTime];
valid_exec_times = exec_times(~isnan(exec_times));
if isempty(valid_exec_times)
    avg_exec_time = NaN;
else
    avg_exec_time = mean(valid_exec_times);
end

fprintf('Başarı Oranı: %d/%d (%.1f%%)\n', successful, num_tests, 100*successful/num_tests);
fprintf('Ortalama Error: %.2f samples\n', total_error);
fprintf('Ortalama Süre: %.3f ms\n', avg_exec_time*1000);
fprintf('\n');

% Detaylı sonuçlar
fprintf('Detaylı Sonuçlar:\n');
fprintf('┌─────────┬──────────────────┬──────────────┬─────────┬────────┐\n');
fprintf('│ Paket # │ Tahmin (samples) │ Error (s.)   │ Status  │ Zaman  │\n');
fprintf('├─────────┼──────────────────┼──────────────┼─────────┼────────┤\n');

for i = 1:num_tests
    status = iif(results(i).success, 'PASS', 'FAIL');
    fprintf('│ %7d │ %16.2f │ %12.2f │ %-7s │ %.2f ms│\n', ...
        results(i).packetIdx, results(i).estimatedOffset, results(i).error, status, results(i).executionTime*1000);
end

fprintf('└─────────┴──────────────────┴──────────────┴─────────┴────────┘\n');

% Workspace'e kaydet
assignin('base', 'results', results);

%% 4.1 KORELASYON METRİĞİ (Symbol Timing Estimator benzeri)
fprintf('\n4.1. Korelasyon metriği analizi...\n');

[metric_values, metric_peak, metric_avg, metric_par_db, fine_est] = compute_metric_summary(testCases{1}, simParams);

if ~isempty(fine_est)
    official_offset = testCases{1}.coarsePktOffset + fine_est(1);
else
    official_offset = NaN;
end

if isempty(metric_values)
    fprintf('   Metric bilgisi alınamadı (wlanSymbolTimingEstimate tek çıkışlı olabilir).\n');
else
    fprintf('   Peak Metric Value: %.2f\n', metric_peak);
    fprintf('   Average Metric Value: %.2f\n', metric_avg);
    fprintf('   Peak-to-Average Ratio: %.2f dB\n', metric_par_db);
    if ~isnan(official_offset)
        fprintf('   Official MATLAB Offset (wlanSymbolTimingEstimate): %.2f\n', official_offset);
    end
end

%% 5. GÖRSELLEŞTİRME (Symbol Timing Estimator'a benzer)
fprintf('\n5. Sonuçlar görselleştiriliyot...\n');

first_rx = testCases{1}.rx;
coarse_offset_ref = testCases{1}.coarsePktOffset;

% Figure 1: Correlation Metric (Symbol Timing Estimator tarzı)
figure('Name', 'Fine Packet Offset - Correlation Metric', 'Position', [100 100 1200 600]);

subplot(2,2,1);
plot(metric_values, 'b-', 'LineWidth', 2);
hold on;
if ~isempty(metric_values)
    [~, peak_idx] = max(metric_values);
    plot(peak_idx, metric_values(peak_idx), 'ro', 'MarkerSize', 12, 'LineWidth', 2);
end
grid on;
xlabel('Sample Index');
ylabel('Correlation Metric');
title('Cross-Correlation Metric vs. Sample Index');
legend('Metric', 'Detected Peak', 'Location', 'best');

subplot(2,2,2);
plot(real(first_rx), 'b-', 'LineWidth', 1);
hold on;
plot(imag(first_rx), 'r-', 'LineWidth', 1);
grid on;
xlabel('Sample Index');
ylabel('Amplitude');
title('Test Signal (Real and Imaginary)');
legend('Real', 'Imag', 'Location', 'best');

subplot(2,2,3);
stem(abs(first_rx), 'b', 'LineWidth', 1.5);
hold on;
% Coarse offset referans
xline(coarse_offset_ref, 'r--', 'LineWidth', 2, 'Label', 'Coarse Offset (Actual)');
% Official MATLAB offset
if ~isnan(official_offset)
    xline(official_offset, 'g--', 'LineWidth', 2, 'Label', 'Fine Offset (Detected)');
end
grid on;
xlabel('Sample Index');
ylabel('Magnitude');
title('Test Signal Magnitude');

subplot(2,2,4);
% Metric'in normalize edilmiş versiyonu
if ~isempty(metric_values) && max(metric_values) > 0
    metric_normalized = metric_values / max(metric_values);
    plot(metric_normalized, 'b-', 'LineWidth', 2);
    hold on;
    yline(0.8, 'r--', 'LineWidth', 2, 'Label', 'Threshold (0.8)');
    grid on;
    xlabel('Sample Index');
    ylabel('Normalized Metric');
    title('Normalized Correlation Metric');
    ylim([0 1.1]);
end

%% 6. DETAYLI SONUÇLAR DOSYAYA KAYDET
fprintf('\n6. Sonuçlar dosyaya kaydediliyor...\n');

results_table = table([results.packetIdx]', [results.estimatedOffset]', ...
                      [results.trueOffset]', [results.error]', ...
                      [results.success]', [results.executionTime]'*1000, ...
                      'VariableNames', ...
                      {'PacketIndex', 'EstimatedOffset', 'TrueCoarseOffset', 'Error', 'Success', 'ExecutionTimeMs'});

% CSV dosyası olarak kaydet
writetable(results_table, 'fine_packet_offset_results.csv');
fprintf('   ✓ Sonuçlar: fine_packet_offset_results.csv\n');

% MAT dosyası olarak kaydet
save('fine_packet_offset_results.mat', 'results', 'testCases', 'simParams');
fprintf('   ✓ MAT dosyası: fine_packet_offset_results.mat\n');

%% 7. RAPOR ÖZETİ
fprintf('\n========================================\n');
fprintf('TEST RAPORU\n');
fprintf('========================================\n');
fprintf('Tarih: %s\n', datetime('now'));
fprintf('Channel Bandwidth: %s\n', simParams.channelBandwidth);
fprintf('SNR: %.1f dB\n', simParams.SNR_dB);
fprintf('Paket Sayısı: %d\n', num_tests);
fprintf('Başarı Oranı: %.1f%%\n', 100*successful/num_tests);
if isempty(valid_errors)
    fprintf('Ortalama Error: N/A\n');
    fprintf('Max Error: N/A\n');
else
    fprintf('Ortalama Error: %.2f ± %.2f samples\n', mean(valid_errors), std(valid_errors));
    fprintf('Max Error: %.2f samples\n', max(valid_errors));
end
fprintf('Ortalama Süre: %.3f ms\n', mean(exec_times_ms));
fprintf('========================================\n');

%% PERFORMANCE ÖZETİ (Symbol Timing Estimator ile benzer)
fprintf('========================================\n');
fprintf('PERFORMANCE ÖZETİ\n');
fprintf('========================================\n');
fprintf('Detection Success: %s\n', iif(successful > 0, 'YES', 'NO'));
fprintf('Timing Accuracy: %s\n', iif(~isnan(total_error) && total_error <= 2, 'GOOD', 'NEEDS IMPROVEMENT'));
if ~isnan(metric_peak)
    fprintf('Peak Metric Value: %.2f\n', metric_peak);
    fprintf('Average Metric Value: %.2f\n', metric_avg);
    fprintf('Peak-to-Average Ratio: %.2f dB\n', metric_par_db);
else
    fprintf('Peak Metric Value: N/A\n');
    fprintf('Average Metric Value: N/A\n');
    fprintf('Peak-to-Average Ratio: N/A\n');
end
fprintf('========================================\n');

%% YARDIMCI FONKSİYONLAR
function result = iif(condition, true_val, false_val)
    if condition
        result = true_val;
    else
        result = false_val;
    end
end

function [metric_values, metric_peak, metric_avg, metric_par_db, fine_est] = compute_metric_summary(test, simParams)
    metric_values = [];
    metric_peak = NaN;
    metric_avg = NaN;
    metric_par_db = NaN;
    fine_est = [];

    try
        cfgHT = wlanHTConfig('ChannelBandwidth', simParams.channelBandwidth);
        ind = wlanFieldIndices(cfgHT);

        idx_start = test.coarsePktOffset + double(ind.LSTF(1));
        idx_end = test.coarsePktOffset + double(ind.LSIG(2));

        idx_start = max(1, idx_start);
        idx_end = min(length(test.rx), idx_end);

        nonhtfields = test.rx(idx_start:idx_end, :);

        try
            [fine_est, metric_values] = wlanSymbolTimingEstimate(nonhtfields, cfgHT.ChannelBandwidth);
        catch
            metric_values = [];
            fine_est = [];
        end

        if ~isempty(metric_values)
            metric_peak = max(metric_values);
            metric_avg = mean(metric_values);
            metric_par_db = 10*log10(metric_peak / metric_avg);
        end
    catch
        metric_values = [];
        metric_peak = NaN;
        metric_avg = NaN;
        metric_par_db = NaN;
        fine_est = [];
    end
end

function create_function_template()
    % Eğer fonksiyon dosyası yoksa template oluştur
    
    template = [
        "function offset = fine_packet_offset_fcn(rx, coarsePktOffset, simParams)\n"
        "%% FINE PACKET OFFSET ESTIMATOR\n"
        "% Alınan sinyalde fine timing offset'ini bulur\n"
        "% \n"
        "% INPUT:\n"
        "%   rx: Alınan sinyal (complex)\n"
        "%   coarsePktOffset: Kaba paket offset (samples)\n"
        "%   simParams: Simülasyon parametreleri struct\n"
        "%       .channelBandwidth: 'CBW20', 'CBW40', vb.\n"
        "% OUTPUT:\n"
        "%   offset: Paket offseti (samples)\n"
        "\n"
        "% WLAN konfigürasyonu\n"
        "cfgHT = wlanHTConfig('ChannelBandwidth', simParams.channelBandwidth);\n"
        "ind = wlanFieldIndices(cfgHT);\n"
        "\n"
        "% Non-HT fields (LSTF + LSIG) çıkart\n"
        "try\n"
        "    nonhtfields = rx((coarsePktOffset+double(ind.LSTF(1)): ...\n"
        "                      coarsePktOffset+double(ind.LSIG(2))), :);\n"
        "    \n"
        "    % Fine packet offset hesapla\n"
        "    finePktOffset = wlanSymbolTimingEstimate(nonhtfields, cfgHT.ChannelBandwidth);\n"
        "    \n"
        "    % Final offset\n"
        "    pktOffset = coarsePktOffset + finePktOffset;\n"
        "    offset = pktOffset(1);\n"
        "    \n"
        "catch\n"
        "    % Hata durumunda coarse offset'i return et\n"
        "    offset = coarsePktOffset;\n"
        "end\n"
        "\n"
        "end\n"
    ];
    
    writelines(template, 'fine_packet_offset_fcn.m');
end
