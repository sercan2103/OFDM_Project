function [tx_output, scrambled_service, scrambled_data] = Scrambler(init_seed, input_data, doPlot)
% Scrambler 802.11 TX
% Usage:
%   [tx_output, scrambled_service, scrambled_data] = Scrambler()
%   [tx_output, scrambled_service, scrambled_data] = Scrambler(init_seed, input_data)
%   [tx_output, scrambled_service, scrambled_data] = Scrambler(init_seed, input_data, doPlot)
%
% If called with no arguments, the function uses default seed and a
% random 64-bit payload (same behavior as the original script).

if nargin < 1 || isempty(init_seed)
    init_seed = [1 0 1 1 1 0 1];
end

if nargin < 2 || isempty(input_data)
    packet_length = 64;
    input_data = randi([0 1], 1, packet_length);
else
    packet_length = length(input_data);
end

if nargin < 3 || isempty(doPlot)
    doPlot = true;
end

service_field = zeros(1, 16);
full_payload = [service_field, input_data];

% TX SCRAMBLER SIMULATION
current_state = init_seed;
tx_output = zeros(1, length(full_payload));

fprintf('--- TX SCRAMBLER BAŞLIYOR ---\n');
fprintf('Başlangıç State (Seed): %s\n\n', num2str(init_seed));

for k = 1:length(full_payload)
    b6 = current_state(1);
    b3 = current_state(4);
    feedback = xor(b6, b3);
    input_bit = full_payload(k);
    scrambled_bit = xor(input_bit, feedback);
    tx_output(k) = scrambled_bit;
    current_state = [current_state(2:end), feedback];
end

% Split outputs
scrambled_service = tx_output(1:16);
scrambled_data    = tx_output(17:end);

% Display when outputs are not captured or when plotting requested
if nargout == 0 || doPlot
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
end

if doPlot
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
end

end