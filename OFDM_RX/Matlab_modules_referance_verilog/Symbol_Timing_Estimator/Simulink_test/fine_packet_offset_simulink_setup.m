%% FINE PACKET OFFSET - SIMULINK MODEL TEST
% Simulink modelinde output'u gözlemlemek için script
% Scope, To Workspace, vb. blokları nasıl bağlayacağını gösterir

clear; close all; clc;

fprintf('========================================\n');
fprintf('Fine Packet Offset - Simulink Setup\n');
fprintf('========================================\n\n');

%% 1. INPUT'LARI HAZIRLA
fprintf('1. Input''lar hazırlanıyor...\n');

% Eğer testCases yoksa input generator çalıştır
if ~exist('testCases', 'var')
    fprintf('   Input generator çalıştırılıyor...\n');
    fine_packet_offset_input_generator;
end

%% 2. İLK TEST CASE'İNİ SIMULINK İÇİN HAZIRLA
fprintf('\n2. Simulink input''ları workspace''e kaydediliyor...\n');

test_idx = 1;
test = testCases{test_idx};

% Simulink'te "From Workspace" bloğu tarafından okunacak değişkenler
assignin('base', 'rx_signal', test.rx);
assignin('base', 'coarse_offset', test.coarsePktOffset);
assignin('base', 'channel_bw', simParams.channelBandwidth);

% Time vector (optional, bazı Simulink blokları gerektirebilir)
t_vector = (0:length(test.rx)-1)' / simParams.samplingRate;
assignin('base', 'time_vector', t_vector);

fprintf('   ✓ rx_signal: %d samples\n', length(test.rx));
fprintf('   ✓ coarse_offset: %d\n', test.coarsePktOffset);
fprintf('   ✓ channel_bw: %s\n', simParams.channelBandwidth);
fprintf('   ✓ time_vector: %d points\n', length(t_vector));

%% 3. SIMULINK MODEL TEMPLATE'İ OLUŞTUR
fprintf('\n3. Simulink model yapısı kontrol ediliyor...\n');

model_name = 'fine_packet_offset_sim';

if ~exist([model_name, '.slx'], 'file')
    fprintf('   Model dosyası bulunamadı!\n');
    fprintf('   Lütfen şu yapıyla bir Simulink model oluştur:\n\n');
    
    fprintf('   ╔════════════════════════════════════════════════════════════╗\n');
    fprintf('   ║  MODEL YAPISI: %s.slx                    ║\n', model_name);
    fprintf('   ╚════════════════════════════════════════════════════════════╝\n\n');
    
    fprintf('   BLOKLAR:\n');
    fprintf('   ─────────────────────────────────────────────────────────────\n');
    fprintf('   1. FROM WORKSPACE\n');
    fprintf('      Variable name: rx_signal\n');
    fprintf('      Sample time: -1 (aynı zamanda)\n');
    fprintf('      Interpret vector as 1-D array: ✓\n\n');
    
    fprintf('   2. SIMULINK FUNCTION / MATLAB FUNCTION\n');
    fprintf('      Adı: Fine Offset Estimator\n');
    fprintf('      Input 1: rx (complex)\n');
    fprintf('      Input 2: coarse_offset (double)\n');
    fprintf('      Input 3: channel_bw (string)\n');
    fprintf('      Output 1: estimated_offset (double)\n');
    fprintf('      Output 2: peak_metric (double)\n\n');
    
    fprintf('   3. TO WORKSPACE\n');
    fprintf('      Variable name: simout_offset\n');
    fprintf('      Save format: Array / Timeseries\n\n');
    
    fprintf('   4. SCOPE (Optional)\n');
    fprintf('      Input: estimated_offset\n');
    fprintf('      Time range otomatik\n\n');
    
    fprintf('   BAĞLANTILAR:\n');
    fprintf('   ─────────────────────────────────────────────────────────────\n');
    fprintf('   From Workspace → MATLAB Function (Input 1)\n');
    fprintf('   Coarse Offset (Constant/From Workspace) → MATLAB Function (Input 2)\n');
    fprintf('   Channel BW (Constant/From Workspace) → MATLAB Function (Input 3)\n');
    fprintf('   MATLAB Function → Scope\n');
    fprintf('   MATLAB Function → To Workspace\n\n');
    
else
    fprintf('   ✓ Model bulundu: %s.slx\n', model_name);
end

%% 4. MATLAB FUNCTION KODU
fprintf('\n4. MATLAB Function kodu:\n');
fprintf('   ─────────────────────────────────────────────────────────────\n\n');

matlab_fcn_code = [
    "function [offset, peak_metric] = fine_offset_est(rx, coarse_offset, channel_bw)\n"
    "    % Fine Packet Offset Estimator - Simulink MATLAB Function\n"
    "    \n"
    "    % WLAN config\n"
    "    cfgHT = wlanHTConfig('ChannelBandwidth', channel_bw);\n"
    "    ind = wlanFieldIndices(cfgHT);\n"
    "    \n"
    "    % Ensure 2D\n"
    "    if iscolumn(rx)\n"
    "        rx = rx(:, :);\n"
    "    end\n"
    "    \n"
    "    try\n"
    "        % Non-HT fields çıkart\n"
    "        idx_start = coarse_offset + double(ind.LSTF(1));\n"
    "        idx_end = coarse_offset + double(ind.LSIG(2));\n"
    "        \n"
    "        % Sınırlar kontrol et\n"
    "        if idx_end > length(rx)\n"
    "            idx_end = length(rx);\n"
    "        end\n"
    "        if idx_start < 1\n"
    "            idx_start = 1;\n"
    "        end\n"
    "        \n"
    "        nonhtfields = rx(idx_start:idx_end, :);\n"
    "        \n"
    "        % Fine timing estimate\n"
    "        fine_est = wlanSymbolTimingEstimate(nonhtfields, channel_bw);\n"
    "        \n"
    "        offset = coarse_offset + fine_est(1);\n"
    "        peak_metric = max(abs(fine_est));\n"
    "        \n"
    "    catch\n"
    "        offset = coarse_offset;\n"
    "        peak_metric = 0;\n"
    "    end\n"
    "end\n"
];

fprintf(matlab_fcn_code);

%% 5. OUTPUT GÖZLEMLEME YÖNTEMLERİ
fprintf('\n5. Output Gözlemleme Yöntemleri:\n');
fprintf('   ─────────────────────────────────────────────────────────────\n\n');

fprintf('   YÖNTEMİ 1: SCOPE BLOK (Gerçek-zamanlı)\n');
fprintf('   ──────────────────────────────────────\n');
fprintf('   ✓ Model''da Scope bloğu ekle\n');
fprintf('   ✓ Estimated_offset çıkışını bağla\n');
fprintf('   ✓ Simulasyon sırasında gerçek-zamanlı görüntüleme\n\n');

fprintf('   YÖNTEMİ 2: TO WORKSPACE (Simulasyondan sonra analiz)\n');
fprintf('   ──────────────────────────────────────────────────\n');
fprintf('   ✓ "To Workspace" bloğu ekle\n');
fprintf('   ✓ Variable name: simout_offset\n');
fprintf('   ✓ Simulasyon çalıştır\n');
fprintf('   ✓ Script'le analiz et (aşağıya bak)\n\n');

fprintf('   YÖNTEMİ 3: SIGNAL LOGGING (Blok arası sinyaller)\n');
fprintf('   ──────────────────────────────────────────────\n');
fprintf('   >> set_param(gcs, ''SignalLogging'', ''on'')\n');
fprintf('   >> sim(''%s'')\n', model_name);
fprintf('   >> logsout.get(''signal_name'').Values\n\n');

fprintf('   YÖNTEMİ 4: DEBUGGER (Hata ayıklama)\n');
fprintf('   ──────────────────────────────────────\n');
fprintf('   ✓ MATLAB Function bloğunun Debug sekmesini aç\n');
fprintf('   ✓ Breakpoints ekle\n');
fprintf('   ✓ Model''i debug modunda çalıştır\n\n');

%% 6. SIMULINK MODEL ÇIKMASI İÇİN ANALIZ SCRIPTI
fprintf('\n6. Simulink çıkışını analiz etme scripti:\n');
fprintf('   ─────────────────────────────────────────────────────────────\n\n');

analysis_script = [
    "%% SIMULINK OUTPUT ANALİZİ\n"
    "if exist('simout_offset', 'var')\n"
    "    % Sonuçları çıkart\n"
    "    if istimeseries(simout_offset)\n"
    "        output_data = simout_offset.Data;\n"
    "        output_time = simout_offset.Time;\n"
    "    else\n"
    "        output_data = simout_offset;\n"
    "        output_time = 1:length(output_data);\n"
    "    end\n"
    "\n"
    "    % Analiz\n"
    "    fprintf('Simulink Output Analizi:\\n');\n"
    "    fprintf('  Min: %.2f\\n', min(output_data));\n"
    "    fprintf('  Max: %.2f\\n', max(output_data));\n"
    "    fprintf('  Mean: %.2f\\n', mean(output_data));\n"
    "    fprintf('  Std: %.2f\\n', std(output_data));\n"
    "\n"
    "    % Grafik\n"
    "    figure;\n"
    "    plot(output_time, output_data, 'b-o');\n"
    "    grid on;\n"
    "    xlabel('Time');\n"
    "    ylabel('Estimated Offset (samples)');\n"
    "    title('Fine Packet Offset - Simulink Output');\n"
    "else\n"
    "    fprintf('HATA: simout_offset variable''ı bulunamadı!\\n');\n"
    "end\n"
];

fprintf(analysis_script);

%% 7. SIMULINK MODEL OLUŞTURMA (OTOMATİK)
fprintf('\n7. Otomatik model oluşturma seçeneği:\n');
fprintf('   ─────────────────────────────────────────────────────────────\n\n');

prompt = input('   Simulink model otomatik olarak oluşturulsun mu? (y/n): ', 's');

if strcmpi(prompt, 'y') || strcmpi(prompt, 'Y')
    fprintf('   Model oluşturuluyor...\n');
    create_simulink_model(model_name);
    fprintf('   ✓ Model oluşturuldu: %s.slx\n', model_name);
else
    fprintf('   Model manuel olarak oluştur.\n');
end

%% 8. TEST KOMUTU
fprintf('\n8. Test komutunu çalıştır:\n');
fprintf('   ─────────────────────────────────────────────────────────────\n\n');
fprintf('   >> sim(''%s'')\n', model_name);
fprintf('   >> fine_packet_offset_analyze_simulink_output\n\n');

fprintf('========================================\n');

%% YARDIMCI FONKSİYON
function create_simulink_model(model_name)
    % Simulink model template'i oluştur
    
    new_system(model_name);
    open_system(model_name);
    
    % Blokları ekle
    add_block('simulink/Sources/From Workspace', ...
        [model_name '/From Workspace'], 'VariableName', 'rx_signal');
    
    add_block('simulink/User-Defined Functions/MATLAB Function', ...
        [model_name '/Fine Offset Est']);
    
    add_block('simulink/Sinks/Scope', [model_name '/Scope']);
    add_block('simulink/Sinks/To Workspace', ...
        [model_name '/To Workspace'], 'VariableName', 'simout_offset');
    
    % Blokları konumlandır
    set_param([model_name '/From Workspace'], 'Position', [50, 50, 150, 100]);
    set_param([model_name '/Fine Offset Est'], 'Position', [250, 50, 350, 150]);
    set_param([model_name '/Scope'], 'Position', [450, 50, 550, 150]);
    set_param([model_name '/To Workspace'], 'Position', [450, 200, 550, 250]);
    
    % Bağlantıları yap
    add_line(model_name, 'From Workspace/1', 'Fine Offset Est/1');
    add_line(model_name, 'Fine Offset Est/1', 'Scope/1');
    add_line(model_name, 'Fine Offset Est/1', 'To Workspace/1');
    
    save_system(model_name);
end
