clc; clear; close all;

%% 1. PARAMETRELER VE VERİ OLUŞTURMA
% Verilog'daki 'init_data_scram_state' (Başlangıç Tohumu - 7 bit)
% Not: Hepsi sıfır olmamalıdır.
init_seed = [1 0 1 1 1 0 1]; 

% Daha fazla veri biti (Örneğin 64 bitlik rastgele veri)
packet_length = 64; 
input_data = randi([0 1], 1, packet_length);

% Verilog'daki 'S11_SERVICE' durumu: 16 adet '0' biti
service_field = zeros(1, 16);

% Toplam İşlenecek Paket: [Service Field (16 bit)] + [Data (64 bit)]
full_payload = [service_field, input_data];

%% 2. TX SCRAMBLER SİMÜLASYONU
% Polinom: x^7 + x^4 + 1
% Mantık: Feedback = State[6] ^ State[3]

current_state = init_seed;
tx_output = zeros(1, length(full_payload));

% Sonuçları görselleştirmek için string değişkenler
str_input = '';
str_scrambled = '';

fprintf('--- TX SCRAMBLER BAŞLIYOR ---\n');
fprintf('Başlangıç State (Seed): %s\n\n', num2str(init_seed));

for k = 1:length(full_payload)
    % Verilog: data_scram_state[6] (Matlab index 1) ve [3] (Matlab index 4)
    b6 = current_state(1); 
    b3 = current_state(4);
    
    % Feedback (XOR İşlemi)
    feedback = xor(b6, b3);
    
    % Çıkış Biti Hesaplama
    % Verilog: bit_scram = state[6] ^ state[3] ^ input
    % Not: Service kısmında input zaten 0 olduğu için sadece feedback çıkar.
    input_bit = full_payload(k);
    scrambled_bit = xor(input_bit, feedback);
    
    % Sonucu kaydet
    tx_output(k) = scrambled_bit;
    
    % Debug Çıktısı (İsteğe bağlı, her adımı görmek için)
    % if k <= 20 % İlk 20 biti detaylı yazdır
    %    fprintf('Bit %d: In=%d | State=%s | Out=%d\n', ...
    %        k, input_bit, num2str(current_state), scrambled_bit);
    % end
    
    % State Güncelleme (Shift Register - Sola Kaydır)
    % Verilog: {data_scram_state[5:0], feedback}
    current_state = [current_state(2:end), feedback];
end

%% 3. SONUÇLARI GÖSTER
% Verileri gruplayarak gösterelim

scrambled_service = tx_output(1:16);
scrambled_data    = tx_output(17:end);

disp('-------------------------------------------------------------');
disp('GİRİŞ VERİSİ (INPUT DATA - İlk 64 Bit):');
disp(num2str(input_data));
disp('-------------------------------------------------------------');
disp(' ');
disp('ÇIKIŞ - BÖLÜM 1: SERVICE FIELD (İlk 16 Bit - Input hep 0 idi):');
disp(num2str(scrambled_service));
disp(' ');
disp('ÇIKIŞ - BÖLÜM 2: SCRAMBLED DATA (Karıştırılmış Veri):');
disp(num2str(scrambled_data));
disp('-------------------------------------------------------------');

% Grafiksel Gösterim (Bitlerin dağılımını görmek için)
figure;
subplot(2,1,1);
stem(input_data, 'filled');
title('Orijinal Veri Girişi');
ylim([-0.5 1.5]); xlim([0 packet_length]);
grid on;

subplot(2,1,2);
stem(scrambled_data, 'filled', 'r');
title('Scramble Edilmiş Veri Çıkışı');
ylim([-0.5 1.5]); xlim([0 packet_length]);
grid on;