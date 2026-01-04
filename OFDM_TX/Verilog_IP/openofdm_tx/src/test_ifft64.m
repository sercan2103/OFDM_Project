% Test Vektörü Oluştur (Örneğin 64 adet rastgele karmaşık sayı)
input_data = randn(1, 64) + 1j*randn(1, 64);

% 1. Bizim Modelimizi Çalıştır
model_output = ifft64_model.run(input_data);

% 2. MATLAB'ın Hazır IFFT Fonksiyonunu Çalıştır
% Not: MATLAB ifft sonucu 1/N ile çarpar, bizim model (ve genelde donanım)
% ara aşamalarda shift yapmıyorsa toplam (sum) mantığıyla büyür.
% Karşılaştırmak için MATLAB sonucunu 64 ile çarpıyoruz.
matlab_output = ifft(input_data) * 64;

% 3. Hatayı Kontrol Et
error = max(abs(model_output - matlab_output));
fprintf('Maksimum Hata: %e\n', error);

% Sonuçları Çizdir
figure;
subplot(2,1,1); plot(abs(model_output)); title('Model Çıkışı');
subplot(2,1,2); plot(abs(matlab_output)); title('MATLAB IFFT * 64');
