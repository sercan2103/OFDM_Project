function offset = fine_packet_offset_fcn(rx, coarsePktOffset, simParams)
%% FINE PACKET ESTIMATOR - wlanSymbolTimingEstimate WRAPPER
% Alınan sinyalde fine timing offset'ini bulur
% 
% INPUT:
%   rx: Alınan sinyal (complex), 1D or 2D array
%   coarsePktOffset: Kaba paket offset (samples)
%   simParams: Simülasyon parametreleri struct
%       .channelBandwidth: 'CBW20', 'CBW40', vb.
% OUTPUT:
%   offset: Paket offseti (samples)

try
    % WLAN konfigürasyonu
    cfgHT = wlanHTConfig('ChannelBandwidth', simParams.channelBandwidth);
    
    % Coarse offset'ten sonrasında bulunan preamble alanını çıkart
    % wlanSymbolTimingEstimate'ye sadece L-STF + L-SIG + HT-SIG alanı ver
    
    % Get field indices for reference
    ind = wlanFieldIndices(cfgHT);
    
    % Extract LSTF + LSIG area (non-HT preamble fields)
    % These are always present before HT fields
    lstf_end = double(ind.LSIG(2));  % End of L-SIG field
    
    % Check bounds
    if coarsePktOffset + lstf_end > length(rx)
        error('Signal length insufficient for timing estimation');
    end
    
    % Extract the preamble area from coarse offset
    preamble_area = rx(coarsePktOffset+1:coarsePktOffset+lstf_end, :);
    
    % Ensure column vector if 1D
    if isrow(preamble_area)
        preamble_area = preamble_area';
    end
    
    % Call official MATLAB wlanSymbolTimingEstimate
    finePktOffset = wlanSymbolTimingEstimate(preamble_area, cfgHT.ChannelBandwidth);
    
    % Final offset: coarse + fine
    offset = coarsePktOffset + finePktOffset(1);
    
catch ME
    % If error occurs, return coarse offset
    offset = coarsePktOffset;
end

end
