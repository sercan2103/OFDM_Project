clear; clc; close all;

% Test edilecek modülasyon tipleri (N_BPSC değerleri)
% 1: BPSK, 2: QPSK, 4: 16-QAM, 6: 64-QAM
mod_types = [1, 2, 4, 6];
mod_names = {'BPSK', 'QPSK', '16-QAM', '64-QAM'};

figure('Name', 'Modülasyon Takımyıldız Diyagramları', 'Color', 'w');

for m = 1:length(mod_types)
    n_bpsc = mod_types(m);
    num_symbols = 2^n_bpsc; % Olası tüm sembol sayısı
    
    % Verileri saklamak için diziler
    I_data = zeros(1, num_symbols);
    Q_data = zeros(1, num_symbols);
    bit_labels = cell(1, num_symbols);
    
    fprintf('Test ediliyor: %s (N_BPSC = %d)...\n', mod_names{m}, n_bpsc);
    
    % Tüm olası giriş değerlerini döngüye al
    for k = 0:num_symbols-1
        % Fonksiyonu çağır
        [I_out, Q_out] = modulation_model(n_bpsc, k);
        
        % int16 tipini çizim için double'a çeviriyoruz
        I_data(k+1) = double(I_out);
        Q_data(k+1) = double(Q_out);
        
        % Etiketleme için bit gösterimi (örneğin: '1011')
        bit_labels{k+1} = dec2bin(k, n_bpsc);
        
        % Veri tipi kontrolü (Assertion)
        if ~isa(I_out, 'int16') || ~isa(Q_out, 'int16')
            error('Hata: Çıktı veri tipi int16 olmalıdır!');
        end
    end
    
    % --- Çizim (Plotting) ---
    subplot(2, 2, m);
    scatter(I_data, Q_data, 'filled', 'b');
    grid on;
    axis square; % Kare eksen, takımyıldızın düzgün görünmesi için
    title([mod_names{m} ' Constellation']);
    xlabel('I (In-Phase)');
    ylabel('Q (Quadrature)');
    
    % Eksen limitlerini biraz genişlet ki yazılar sığsın
    max_val = max(abs([I_data, Q_data]));
    xlim([-max_val*1.3, max_val*1.3]);
    ylim([-max_val*1.3, max_val*1.3]);
    
    % Noktaların üzerine hangi bitlerin denk geldiğini yaz
    % (64-QAM'de çok kalabalık olacağı için sadece diğerlerinde yazalım)
    if n_bpsc < 6
        text(I_data, Q_data, bit_labels, 'VerticalAlignment', 'bottom', 'HorizontalAlignment', 'right', 'FontSize', 8);
    end
end

fprintf('Test tamamlandı. Grafikler oluşturuldu.\n');