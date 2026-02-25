%% Example Usage Script for HT-DATA Recover
% Bu script, ht_data_recover_fixed fonksiyonunun nasıl kullanılacağını
% gösteren pratik örnekler içerir.

clear; clc;

fprintf('=== HT-DATA Recover - Örnek Kullanımlar ===\n\n');

%% Örnek 1: Basit BPSK Test (Legacy Mode)
fprintf('Örnek 1: Legacy 6 Mbps BPSK Decoding\n');
fprintf('-------------------------------------------\n');

% Test parametreleri
Nsc = 48;  % Legacy mode: 48 subcarriers
Nsym = 5;  % 5 OFDM symbols
rate = hex2dec('0B');  % BPSK 1/2 6 Mbps
num_bits = 240;  % 48 bits/symbol * 5 symbols
do_descramble = 1;
soft_decoding = 0;

% Basit test verisi oluştur: BPSK constellation (+/- 512)
SCALE = 512;
test_bits = randi([0, 1], Nsc, Nsym);
eq_sym_1 = complex(int16((2*test_bits - 1) * SCALE), int16(zeros(Nsc, Nsym)));

% Decode et
[bytes_1, count_1] = ht_data_recover_fixed(eq_sym_1, rate, num_bits, ...
    do_descramble, soft_decoding);

fprintf('Input: %d symbols x %d subcarriers\n', Nsym, Nsc);
fprintf('Output: %d bytes\n', count_1);
if count_1 > 0
    fprintf('İlk 5 byte (hex): ');
    for i = 1:min(5, count_1)
        fprintf('%02X ', bytes_1(i));
    end
    fprintf('\n');
end
fprintf('\n');

%% Örnek 2: QPSK with Soft Decoding (HT Mode)
fprintf('Örnek 2: HT-MCS 1 QPSK with Soft Decoding\n');
fprintf('-------------------------------------------\n');

% Test parametreleri
Nsc = 52;  % HT mode: 52 subcarriers
Nsym = 10;  % 10 OFDM symbols
rate = hex2dec('91');  % HT-MCS 1: QPSK 1/2
num_bits = 1040;  % 52*2 bits/symbol * 10 symbols
do_descramble = 1;
soft_decoding = 1;  % Enable soft decoding

% QPSK constellation oluştur
SCALE = 512;
bits_i = randi([0, 1], Nsc, Nsym);
bits_q = randi([0, 1], Nsc, Nsym);
eq_sym_2 = complex(int16((2*bits_i - 1) * SCALE), ...
                   int16((2*bits_q - 1) * SCALE));

% Gürültü ekle (SNR ~15 dB)
noise = complex(int16(randn(Nsc, Nsym) * 100), ...
                int16(randn(Nsc, Nsym) * 100));
eq_sym_2 = eq_sym_2 + noise;

% Decode et
[bytes_2, count_2] = ht_data_recover_fixed(eq_sym_2, rate, num_bits, ...
    do_descramble, soft_decoding);

fprintf('Input: %d symbols x %d subcarriers (with noise)\n', Nsym, Nsc);
fprintf('Output: %d bytes\n', count_2);
if count_2 > 0
    fprintf('İlk 5 byte (hex): ');
    for i = 1:min(5, count_2)
        fprintf('%02X ', bytes_2(i));
    end
    fprintf('\n');
end
fprintf('\n');

%% Örnek 3: QAM-16 Higher Rate (HT-MCS 3)
fprintf('Örnek 3: HT-MCS 3 QAM-16 Higher Rate\n');
fprintf('-------------------------------------------\n');

% Test parametreleri
Nsc = 52;
Nsym = 15;
rate = hex2dec('93');  % HT-MCS 3: QAM-16 1/2
num_bits = 3120;  % 52*4 bits/symbol * 15 symbols
do_descramble = 1;
soft_decoding = 1;

% QAM-16 constellation: {-3, -1, +1, +3} * scale
SCALE = 340;  % 1024/3
qam16_levels = [-3, -1, 1, 3];
idx_i = randi([1, 4], Nsc, Nsym);
idx_q = randi([1, 4], Nsc, Nsym);
sym_i = qam16_levels(idx_i) * SCALE;
sym_q = qam16_levels(idx_q) * SCALE;
eq_sym_3 = complex(int16(sym_i), int16(sym_q));

% Decode et
[bytes_3, count_3] = ht_data_recover_fixed(eq_sym_3, rate, num_bits, ...
    do_descramble, soft_decoding);

fprintf('Input: %d symbols x %d subcarriers\n', Nsym, Nsc);
fprintf('Output: %d bytes\n', count_3);
if count_3 > 0
    fprintf('İlk 5 byte (hex): ');
    for i = 1:min(5, count_3)
        fprintf('%02X ', bytes_3(i));
    end
    fprintf('\n');
    fprintf('Son 5 byte (hex): ');
    for i = max(1, count_3-4):count_3
        fprintf('%02X ', bytes_3(i));
    end
    fprintf('\n');
end
fprintf('\n');

%% Örnek 4: QAM-64 Maximum Rate (HT-MCS 7)
fprintf('Örnek 4: HT-MCS 7 QAM-64 Maximum Rate\n');
fprintf('-------------------------------------------\n');

% Test parametreleri
Nsc = 52;
Nsym = 20;
rate = hex2dec('97');  % HT-MCS 7: QAM-64 5/6
num_bits = 6240;  % 52*6 bits/symbol * 20 symbols
do_descramble = 1;
soft_decoding = 1;

% QAM-64 constellation: {-7, -5, -3, -1, +1, +3, +5, +7} * scale
SCALE = 146;  % 1024/7
qam64_levels = [-7, -5, -3, -1, 1, 3, 5, 7];
idx_i = randi([1, 8], Nsc, Nsym);
idx_q = randi([1, 8], Nsc, Nsym);
sym_i = qam64_levels(idx_i) * SCALE;
sym_q = qam64_levels(idx_q) * SCALE;
eq_sym_4 = complex(int16(sym_i), int16(sym_q));

% Küçük gürültü ekle
noise = complex(int16(randn(Nsc, Nsym) * 30), ...
                int16(randn(Nsc, Nsym) * 30));
eq_sym_4 = eq_sym_4 + noise;

% Decode et
tic;
[bytes_4, count_4] = ht_data_recover_fixed(eq_sym_4, rate, num_bits, ...
    do_descramble, soft_decoding);
elapsed = toc;

fprintf('Input: %d symbols x %d subcarriers\n', Nsym, Nsc);
fprintf('Output: %d bytes in %.3f ms\n', count_4, elapsed*1000);
if count_4 > 0
    fprintf('İlk 10 byte (hex): ');
    for i = 1:min(10, count_4)
        fprintf('%02X ', bytes_4(i));
    end
    fprintf('\n');
    fprintf('Throughput: %.2f Mbps (processing)\n', ...
        count_4 * 8 / elapsed / 1e6);
end
fprintf('\n');

%% Örnek 5: Rate Comparison
fprintf('Örnek 5: Farklı Rate\'lerde Karşılaştırma\n');
fprintf('-------------------------------------------\n');

rates_to_test = [
    hex2dec('0B'), 'BPSK Legacy';
    hex2dec('90'), 'HT-MCS0 BPSK';
    hex2dec('91'), 'HT-MCS1 QPSK';
    hex2dec('93'), 'HT-MCS3 QAM16';
    hex2dec('95'), 'HT-MCS5 QAM64';
];

fprintf('%-15s %10s %15s\n', 'Rate', 'Bytes', 'Time (ms)');
fprintf('%s\n', repmat('-', 1, 45));

for i = 1:size(rates_to_test, 1)
    rate_val = rates_to_test(i, 1);
    rate_name = rates_to_test{i, 2};
    
    % Basit test data
    if rate_val >= 128  % HT
        test_sym = complex(int16(randn(52, 10) * 500), ...
                          int16(randn(52, 10) * 500));
        nbits = 1000;
    else  % Legacy
        test_sym = complex(int16(randn(48, 10) * 500), ...
                          int16(randn(48, 10) * 500));
        nbits = 480;
    end
    
    % Decode
    tic;
    [test_bytes, test_count] = ht_data_recover_fixed(test_sym, ...
        rate_val, nbits, 1, 1);
    t = toc * 1000;
    
    fprintf('%-15s %10d %15.3f\n', rate_name, test_count, t);
end
fprintf('\n');

%% Örnek 6: Signal vs Data Decoding
fprintf('Örnek 6: SIGNAL Field vs DATA Field\n');
fprintf('-------------------------------------------\n');

% SIGNAL field: no descrambling
fprintf('SIGNAL field decode (no descramble):\n');
sig_sym = complex(int16(randn(48, 1) * 512), int16(randn(48, 1) * 512));
[sig_bytes, sig_count] = ht_data_recover_fixed(sig_sym, ...
    hex2dec('0B'), 24, 0, 0);  % do_descramble = 0
fprintf('  Output: %d bytes\n', sig_count);

% DATA field: with descrambling
fprintf('DATA field decode (with descramble):\n');
data_sym = complex(int16(randn(48, 10) * 512), int16(randn(48, 10) * 512));
[data_bytes, data_count] = ht_data_recover_fixed(data_sym, ...
    hex2dec('0B'), 480, 1, 0);  % do_descramble = 1
fprintf('  Output: %d bytes\n', data_count);

fprintf('\n');

%% Örnek 7: Performance Profiling
fprintf('Örnek 7: Performance Profiling\n');
fprintf('-------------------------------------------\n');

profile on;

% 100 decode işlemi
N_iters = 100;
test_sym = complex(int16(randn(52, 10) * 512), int16(randn(52, 10) * 512));

tic;
for i = 1:N_iters
    [~, ~] = ht_data_recover_fixed(test_sym, hex2dec('91'), 1040, 1, 1);
end
total_time = toc;

profile off;

fprintf('100 decode iteration: %.3f s\n', total_time);
fprintf('Average per decode: %.3f ms\n', total_time / N_iters * 1000);
fprintf('Throughput: ~%.2f decodes/sec\n', N_iters / total_time);

% Profile sonuçlarını göster
% profile viewer;

fprintf('\n');
fprintf('=== Örnekler Tamamlandı ===\n');
fprintf('Daha fazla bilgi için: help ht_data_recover_fixed\n');
fprintf('Test suite için: test_ht_data_recover\n');
