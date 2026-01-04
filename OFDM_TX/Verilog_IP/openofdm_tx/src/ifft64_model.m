classdef ifft64_model
    % IFFT64_MODEL OpenOFDM IFFT donanımının davranışsal modelidir.
    % Verilog kodundaki 'ifftmain.v' ve alt modüllerini taklit eder.
    %
    % Mimari: Radix-2 Decimation-in-Frequency (DIF)
    % Giriş: Normal Sıralı (Natural Order)
    % Çıkış: Bit-Ters Sıralı (Bit-Reversed Order) -> bitreverse modülü ile düzeltilir.
    
    methods (Static)
        
        function output_samples = run(input_samples)
            % RUN: 64 noktalı IFFT işlemini çalıştırır.
            % input_samples: 64 elemanlı karmaşık sayı vektörü (Frequency Domain)
            
            if length(input_samples) ~= 64
                error('Giriş vektörü 64 elemanlı olmalıdır.');
            end
            
            % Verilog: ifftmain.v içindeki stage bağlantıları
            
            % Stage 64 (N=64)
            % Verilog: stage_64 (fftstage)
            data_s1 = ifft64_model.stage_dif(input_samples, 64);
            
            % Stage 32 (N=32)
            % Verilog: stage_32 (fftstage)
            data_s2 = ifft64_model.stage_dif(data_s1, 32);
            
            % Stage 16 (N=16)
            % Verilog: stage_16 (fftstage)
            data_s3 = ifft64_model.stage_dif(data_s2, 16);
            
            % Stage 8 (N=8)
            % Verilog: stage_8 (fftstage)
            data_s4 = ifft64_model.stage_dif(data_s3, 8);
            
            % Stage 4 (N=4)
            % Verilog: stage_4 (qtrstage - basitleştirilmiş stage)
            data_s5 = ifft64_model.stage_dif(data_s4, 4);
            
            % Stage 2 (N=2)
            % Verilog: stage_2 (laststage - sadece toplama/çıkarma)
            data_s6 = ifft64_model.stage_dif(data_s5, 2);
            
            % Bit Reversal
            % Verilog: revstage (bitreverse)
            % DIF algoritması çıkışı bit-reversed verir, donanım bunu düzeltir.
            output_samples = ifft64_model.bit_reverse(data_s6);
            
            % Not: Donanımda genellikle 1/N ölçeklemesi (scaling) yapılmaz veya
            % kaydırma (shift) işlemleriyle yapılır. MATLAB'ın 'ifft' fonksiyonu
            % sonucu 1/64 ile çarpar. Donanımla birebir eşleşmek için genlik
            % ölçeklemesine dikkat edilmelidir. Bu model matematiksel IFFT yapar.
        end
        
        function data_out = stage_dif(data_in, stage_size)
            % STAGE_DIF: Decimation-in-Frequency (DIF) tek bir aşaması.
            % Verilog'daki 'fftstage', 'butterfly' ve 'hwbfly' modüllerine karşılık gelir.
            %
            % data_in: Giriş verisi
            % stage_size: O anki FFT/IFFT bloğunun boyutu (64, 32, 16...)
            
            N = length(data_in);
            data_out = zeros(size(data_in));
            
            % Bu aşamada kaç tane blok işlenecek?
            % Örn: Stage 64'te 1 blok (64'lük), Stage 32'de 2 blok (32'lik) vardır.
            num_blocks = N / stage_size;
            half_size = stage_size / 2;
            
            % IFFT Twiddle Faktörleri (e^(j*2*pi*k/N))
            % Not: IFFT olduğu için üs pozitiftir.
            % Verilog'da bu katsayılar .mem dosyalarından (icmem_64.mem vb.) okunur.
            k = 0:(half_size-1);
            W = exp(1j * 2 * pi * k / stage_size); 
            
            for b = 0:(num_blocks-1)
                offset = b * stage_size;
                
                % Butterfly İşlemleri
                % Verilog: butterfly.v -> L' = L + R, R' = (L - R) * C
                for i = 1:half_size
                    idx_L = offset + i;             % Sol kol (Left)
                    idx_R = offset + i + half_size; % Sağ kol (Right)
                    
                    L = data_in(idx_L);
                    R = data_in(idx_R);
                    C = W(i); % Twiddle Factor (Coefficient)
                    
                    % Butterfly Matematiksel İşlemi
                    out_L = L + R;
                    out_R = (L - R) * C;
                    
                    data_out(idx_L) = out_L;
                    data_out(idx_R) = out_R;
                end
            end
        end
        
        function data_out = bit_reverse(data_in)
            % BIT_REVERSE: Verilog 'bitreverse.v' modülünün karşılığı.
            % 64 nokta (2^6) için indekslerin bitlerini ters çevirir.
            
            N = length(data_in);
            num_bits = log2(N);
            data_out = zeros(size(data_in));
            
            for i = 0:(N-1)
                % Sayıyı ikiliye çevir, ters çevir, tekrar ondalığa dönüştür
                bin_str = dec2bin(i, num_bits);
                rev_str = reverse(bin_str);
                rev_idx = bin2dec(rev_str);
                
                % MATLAB 1-tabanlı indeksleme kullandığı için +1 ekliyoruz
                data_out(rev_idx + 1) = data_in(i + 1);
            end
        end
        
    end
end
