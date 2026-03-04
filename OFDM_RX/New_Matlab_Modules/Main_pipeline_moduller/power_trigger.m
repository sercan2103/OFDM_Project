function [trigger, state] = power_trigger(sample_i, sample_q, sample_in_strobe, ...
                                                    power_thres, power_window, skip_sample, ...
                                                    reset)
% POWER_TRIGGER Packet power detection
%
% Verilog equivalent: power_trigger.v
%
% Inputs:
%   sample_i, sample_q: I/Q samples (16-bit signed, Q0.15)
%   sample_in_strobe: Valid signal
%   power_thres: Power threshold
%   power_window: Window size for moving average
%   skip_sample: Number of samples to skip initially
%   reset: Reset signal (optional)
%
% Outputs:
%   trigger: 1 when packet detected
%   state: Internal state for debugging

    persistent mag_sq_state moving_avg_state skip_count trigger_state sample_count
    
    if nargin < 7
        reset = 0;
    end
    
    % Initialize
    if isempty(skip_count) || reset
        skip_count = 0;
        trigger_state = 0; % 0=idle, 1=triggered, 2=gap_detection
        sample_count = 0;
        mag_sq_state = struct();
        moving_avg_state = struct();
    end
    
    % Default output
    trigger = 0;
    state = trigger_state;
    
    if ~sample_in_strobe
        return;
    end
    
    % Skip initial samples if configured
    if skip_count < skip_sample
        skip_count = skip_count + 1;
        return;
    end
    
    % Calculate magnitude squared
    [mag_sq, mag_sq_stb] = complex_to_mag_sq(sample_i, sample_q, 1, reset);
    
    if ~mag_sq_stb
        return;
    end
    
    % Moving average of power
    [mag_sq_avg, mag_sq_avg_stb] = moving_avg(mag_sq, 1, log2(power_window), reset);
    
    if ~mag_sq_avg_stb
        return;
    end
    
    % State machine
    switch trigger_state
        case 0  % IDLE - waiting for power increase
            if mag_sq_avg > power_thres
                trigger_state = 1;
                trigger = 1;
                sample_count = 0;
            end
            
        case 1  % TRIGGERED - power is above threshold
            trigger = 1;
            if mag_sq_avg < power_thres
                % Power dropped, start gap detection
                trigger_state = 2;
                sample_count = 0;
            end
            
        case 2  % GAP_DETECTION - checking if it's end of packet
            sample_count = sample_count + 1;
            if mag_sq_avg > power_thres
                % Power came back, still in packet
                trigger_state = 1;
                trigger = 1;
            elseif sample_count >= power_window
                % Gap too long, packet ended
                trigger_state = 0;
                trigger = 0;
            else
                % Still in gap, keep trigger high
                trigger = 1;
            end
    end
end
