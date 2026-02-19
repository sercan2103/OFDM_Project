function y = coarseCFOcorrection(u, foffset, simParams)
%   Girişler:
%   u        : Giriş sinyali (Vektör veya Matris)
%   foffset  : Uygulanacak frekans sapması (Hz). 
%              (Not: Orijinal fcn içinde bu değer negatiflenerek kullanılıyordu,
%               burada da aynı mantık korundu: -foffset uygulanır.)
%   simParams: 'sampleRate' alanına sahip yapı (struct).

%#codegen

    % Simulink/Modelden gelen parametreyi al
    % Orijinal fcn bloğundaki mantık: y = frequencyOffset(u, fs, -foffset)
    y = localFrequencyOffset(u, simParams.sampleRate, -foffset);

end

% =========================================================================
% YEREL FONKSİYON (Orijinal frequencyOffset mantığı)
% =========================================================================

function y = localFrequencyOffset(x, sampleRate, offset)
% LOCALFREQUENCYOFFSET Giriş sinyaline frekans ofseti uygular.
%   Orijinal MathWorks frequencyOffset fonksiyonunun bağımsızlaştırılmış halidir.

    % Argüman sayısını doğrula
    narginchk(3,3);

    % Nitelikleri doğrula (Standart MATLAB fonksiyonlarıdır, toolbox gerektirmez)
    validateattributes(x, {'double','single'}, ...
        {'2d','nonnan','finite'}, 'frequencyOffset', 'X');
    validateattributes(sampleRate, {'double','single'}, ...
        {'scalar','real','nonnan','finite','>',0}, 'frequencyOffset', 'SampleRate');
    validateattributes(offset, {'double','single'}, ...
        {'row','real','nonnan','finite'}, 'frequencyOffset', 'OFFSET');

    % Boyut uyuşmazlığını kontrol et
    % Orijinal kodda: coder.internal.error(...) kullanılıyordu.
    % Yerine standart error(...) kullanıldı.
    if ~isscalar(offset) && (size(x,2) ~= size(offset,2))
        error('FrequencyOffset:DimensionMismatch', ...
              'Offset vektörünün sütun sayısı, giriş sinyalinin (X) sütun sayısına eşit olmalıdır.');
    end

    % Veri tiplerini eşle (Single veya Double hassasiyet koruması)
    % cast(..., 'like', x) yapısı korunmuştur.
    fs = cast(sampleRate, 'like', x);
    freqOffset = cast(offset, 'like', x);
    piVal = cast(pi, 'like', x);

    % Zaman vektörünü oluştur
    % Sütun bazlı işlem için transpoze (.) alınır.
    t = ((0:size(x,1)-1) ./ fs).';

    % Her sütun için frekans ofsetini uygula
    % Matematiksel işlem: y = x * e^(j*2*pi*f_offset*t)
    y = x .* exp(1i * 2 * piVal * freqOffset .* t);

end