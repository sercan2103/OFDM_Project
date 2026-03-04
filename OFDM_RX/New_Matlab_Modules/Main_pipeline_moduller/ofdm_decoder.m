function [byte_out, byte_valid, demod_debug, deinter_debug, vit_debug, descram_debug] = ...
    ofdm_decoder(eq_i, eq_q, eq_strobe, rate, do_descramble, reset)
% OFDM_DECODER OFDM decoder pipeline wrapper
%
% Wrapper for decoder pipeline (NOT full receiver):
%   Demodulate → Deinterleave → Viterbi → Descramble → Bits to bytes
%
% Inputs:
%   eq_i, eq_q: Equalized symbols (48 for Legacy, 52 for HT), int16
%   eq_strobe: Valid signal for equalized symbols
%   rate: Modulation rate (8-bit: bit[7]=HT flag, bits[6:0]=MCS or rate)
%   do_descramble: Enable descrambling (1=enable, 0=bypass)
%   reset: Reset all decoder modules
%
% Outputs:
%   byte_out: Decoded bytes (8-bit)
%   byte_valid: Valid signal for byte output
%   demod_debug, deinter_debug, vit_debug, descram_debug: Debug signals
%
% This module wraps the 5 decoder sub-modules for convenience

    % Add module paths
    addpath('../BasicModules');
    addpath('../LUTs');
    
    % Default outputs
    byte_out = uint8(0);
    byte_valid = 0;
    demod_debug = struct();
    deinter_debug = struct();
    vit_debug = struct();
    descram_debug = struct();
    
    % Reset decoder modules if requested
    if reset
        demodulate(zeros(48,1,'int16'), zeros(48,1,'int16'), 0, 0, 1);
        deinterleave(0, 0, 0, 1);
        viterbi_decode(0, 0, 0, 0, 1);
        descramble(0, 0, 1);
        bits_to_bytes(0, 0, 1);
        return;
    end
    
    % Only process if valid equalizer output
    if ~eq_strobe
        return;
    end
    
    % Stage 1: Demodulate
    [soft_bits, demod_strobe] = demodulate(eq_i, eq_q, rate, eq_strobe, 0);
    demod_debug.soft_bits = soft_bits;
    demod_debug.strobe = demod_strobe;
    
    if ~demod_strobe
        return;
    end
    
    % Stage 2: Deinterleave
    % Process all soft bits from demodulator
    [deinter_bits, erase_flags, deinter_strobe] = deinterleave(soft_bits, rate, demod_strobe, 0);
    deinter_debug.bits = deinter_bits;
    deinter_debug.erase = erase_flags;
    deinter_debug.strobe = deinter_strobe;
    
    if ~deinter_strobe
        return;
    end
    
    % Stage 3: Viterbi decode
    % deinter_bits is [2 x 1] array (2 parallel streams)
    % erase_flags is [2 x 1] array
    [decoded_bit, viterbi_strobe] = viterbi_decode(deinter_bits(1), deinter_bits(2), ...
                                                     erase_flags, deinter_strobe, 0);
    vit_debug.bit = decoded_bit;
    vit_debug.strobe = viterbi_strobe;
    
    if ~viterbi_strobe
        return;
    end
    
    % Stage 4: Descramble
    if do_descramble
        [descram_bit, descram_strobe] = descramble(decoded_bit, viterbi_strobe, 0);
    else
        descram_bit = decoded_bit;
        descram_strobe = viterbi_strobe;
    end
    descram_debug.bit = descram_bit;
    descram_debug.strobe = descram_strobe;
    
    if ~descram_strobe
        return;
    end
    
    % Stage 5: Bits to bytes
    [byte, byte_strobe] = bits_to_bytes(descram_bit, descram_strobe, 0);
    
    if byte_strobe
        byte_out = byte;
        byte_valid = 1;
    end
end
