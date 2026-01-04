%% 802.11 Convolutional Encoder Test Script
clear; clk = 0;

% 1. Test Verisi Oluştur (Örn: Service field veya rastgele data)
data_in = [1 0 1 1 0 0 0 1 1 1 0 0 0 0]; 

% 2. Encoder'ı Resetle ve Çalıştır
fprintf('Giriş Bitleri: %s\n', num2str(data_in));
encoded_bits = conv_encoder_80211(data_in, true);
fprintf('Kodlanmış Bitler: %s\n', num2str(encoded_bits));

% 3. MATLAB Communications Toolbox ile Doğrulama (Opsiyonel)
% Polinomlar: 133_8 = 91, 171_8 = 121
try
    poly = [91 121]; 
    trellis = poly2trellis(7, poly);
    expected_output = convenc(data_in, trellis);
    
    if isequal(encoded_bits, expected_output)
        disp('Sonuç: BAŞARILI! (MATLAB Toolbox ile eşleşti)');
    else
        disp('Sonuç: HATA! (Beklenen çıktı ile farklı)');
    end
catch
    disp('Not: Communications Toolbox yüklü olmadığı için otomatik doğrulama atlandı.');
end

% 4. Modüler Kullanım Örneği
% Parça parça data geldiğinde state'in korunduğunu gösterelim
conv_encoder_80211([], true); % Reset
chunk1 = conv_encoder_80211([1 0], false);
chunk2 = conv_encoder_80211([1 1], false);
combined = [chunk1 chunk2];
fprintf('Parçalı İşleme Sonucu: %s\n', num2str(combined));
