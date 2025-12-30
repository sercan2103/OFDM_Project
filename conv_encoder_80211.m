function [bits_out] = conv_encoder_80211(bit_in, reset)
    % persistent değişkenler donanımdaki 'reg' (state) yapısını korur
    persistent state;
    
    % Reset durumunda veya ilk çalıştırmada register'ı sıfırla
    if nargin > 1 && reset || isempty(state)
        state = zeros(1, 6); % 6-bit memory (K=7 için)
    end
    
    % Çıkış dizisini önceden tanımla (Her giriş için 2 çıkış)
    bits_out = zeros(1, length(bit_in) * 2);
    
    for i = 1:length(bit_in)
        curr_bit = bit_in(i);
        
        % Verilog logic:
        % g0 = 133 (oktal) -> 1 0 1 1 0 1 1 (Binary)
        % g1 = 171 (oktal) -> 1 1 1 1 0 0 1 (Binary)
        % Donanımdaki state[5:0] yapısına göre XOR işlemleri:
        
        out0 = mod(curr_bit + state(1) + state(2) + state(3) + state(6), 2);
        out1 = mod(curr_bit + state(2) + state(3) + state(5) + state(6), 2);
        
        % Çıkışları ata
        bits_out(2*i - 1) = out0;
        bits_out(2*i)     = out1;
        
        % Kaydırmalı Kaydediciyi Güncelle (state <= {state[4:0], bit_in})
        state = [state(2:end), curr_bit];
    end
end