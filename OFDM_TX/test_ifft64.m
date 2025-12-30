% -------------------------------------------------------------------------
% 1. 802.11 Uyumlu Input Oluşturma
% -------------------------------------------------------------------------
N_FFT = 64;
pilot_indices = [-21, -7, 7, 21];
used_indices = [-26:-1, 1:26]; 

freq_domain_data = zeros(1, N_FFT);

% Rastgele veri (Data)
random_data = (randi([0 1], 1, length(used_indices)) * 2 - 1) + ...
              1j * (randi([0 1], 1, length(used_indices)) * 2 - 1);

center_idx = N_FFT/2 + 1;

for k = 1:length(used_indices)
    idx = used_indices(k);
    if ismember(idx, pilot_indices)
        freq_domain_data(center_idx + idx) = 1 + 0j; % Pilot
    else
        freq_domain_data(center_idx + idx) = random_data(k); % Data
    end
end

% Donanım sırasına çevir
input_data = ifftshift(freq_domain_data);

% -------------------------------------------------------------------------
% 2. Modelleri Çalıştır
% -------------------------------------------------------------------------
% Senin Modelin:
model_output = ifft64_model.run(input_data);

% MATLAB Referansı (x64 ölçekli):
matlab_output = ifft(input_data) * 64;

% Hatayı hesapla ve yazdır
error = max(abs(model_output - matlab_output));
fprintf('Maksimum Hata: %e\n', error);

% -------------------------------------------------------------------------
% 3. Çizim (Reel ve İmajiner Ayrılmış)
% -------------------------------------------------------------------------
figure('Name', 'IFFT Karşılaştırması: Real & Imag', 'Color', 'w');

% --- Üst Grafik: Senin Modelin ---
subplot(2,1,1); 
plot(real(model_output), 'b', 'LineWidth', 1.5); hold on;
plot(imag(model_output), 'r--', 'LineWidth', 1.5);
title('1. Verilog IFFT Model (Model Output)');
ylabel('Genlik');
legend('Reel (I)', 'İmajiner (Q)', 'Location', 'best');
grid on;

% --- Alt Grafik: MATLAB Referansı ---
subplot(2,1,2); 
plot(real(matlab_output), 'b', 'LineWidth', 1.5); hold on;
plot(imag(matlab_output), 'r--', 'LineWidth', 1.5);
title('2. MATLAB Referans Çıkışı (Reference)');
xlabel('Zaman (Örnek İndeksi)');
ylabel('Genlik');
legend('Reel (I)', 'İmajiner (Q)', 'Location', 'best');
grid on;
