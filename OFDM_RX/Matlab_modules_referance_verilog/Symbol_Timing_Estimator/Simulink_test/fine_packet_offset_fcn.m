function offset = fine_packet_offset_fcn(rx, coarsePktOffset, simParams)
%% CUSTOM FINE PACKET OFFSET ESTIMATOR
% Your custom implementation for fine timing offset
% 
% INPUT:
%   rx: Alınan sinyal (complex), 1D or 2D array
%   coarsePktOffset: Kaba paket offset (samples)
%   simParams: Simülasyon parametreleri struct
%       .channelBandwidth: 'CBW20', 'CBW40', vb.
% OUTPUT:
%   offset: Paket offseti (samples)
%
% NOT: Bu dosya sizin custom implementasyonunuz içindir.
%      MATLAB reference implementasyonu için:
%      fine_packet_offset_fcn_matlab_reference.m dosyasını kullanın

% TODO: Kendi custom fine timing estimation algoritmanızı buraya ekleyin
% Şimdilik MATLAB referansını çağırıyor:
offset = fine_packet_offset_fcn_matlab_reference(rx, coarsePktOffset, simParams);

end
