function [metric, phase, state_out, sto_out] = sync_short(sample_i, sample_q, enable, min_plateau, reset)
% SYNC_SHORT Short preamble synchronization
%
% IEEE 802.11 short preamble detection using delay-and-correlate method
% Detects repeating pattern (16 samples) to find STO and estimate CFO
%
% Inputs:
%   sample_i, sample_q: 16-bit signed I/Q samples
%   enable: Start processing (from power trigger)
%   min_plateau: Minimum plateau length for detection
%   reset: Reset state
%
% Outputs:
%   metric: Correlation metric (normalized)
%   phase: CFO estimate (phase accumulation)
%   state_out: State machine state
%   sto_out: Sample timing offset (STO) estimate
%
% States: 0=IDLE, 1=SYNC, 2=DONE
%
% Method:
%   P = sum(s[n] * conj(s[n-16])) over window
%   R = sum(|s[n]|^2) over window
%   metric = |P|^2 / (R * R_delayed)

    persistent state;
    persistent sample_delay; % 16-sample delay line
    persistent corr_i corr_q; % Correlation accumulator
    persistent power_current power_delayed; % Power accumulators
    persistent metric_history; % For plateau detection
    persistent plateau_count sto;
    persistent phase_accum;
    
    if isempty(state) || reset
        state = 0;
        sample_delay = zeros(16, 2); % [I, Q] pairs
        corr_i = 0;
        corr_q = 0;
        power_current = 0;
        power_delayed = 0;
        metric_history = zeros(16, 1);
        plateau_count = 0;
        sto = 0;
        phase_accum = 0;
    end
    
    % Default outputs
    metric = 0;
    phase = phase_accum;
    state_out = state;
    sto_out = sto;
    
    % State machine
    switch state
        case 0 % IDLE
            if enable
                state = 1;
                plateau_count = 0;
            end
            
        case 1 % SYNC - Looking for short preamble
            % Get delayed sample (16 samples ago)
            delayed_i = sample_delay(1, 1);
            delayed_q = sample_delay(1, 2);
            
            % Compute correlation: s[n] * conj(s[n-16])
            % Complex multiply: (a+jb)*(c-jd) = (ac+bd) + j(bc-ad)
            corr_i_new = int32(sample_i) * int32(delayed_i) + int32(sample_q) * int32(delayed_q);
            corr_q_new = int32(sample_q) * int32(delayed_i) - int32(sample_i) * int32(delayed_q);
            
            % Accumulate over window (16 samples)
            corr_i = corr_i + double(corr_i_new) / 2^15; % Scale down
            corr_q = corr_q + double(corr_q_new) / 2^15;
            
            % Compute power
            power_sample = int32(sample_i)^2 + int32(sample_q)^2;
            power_delayed_sample = int32(delayed_i)^2 + int32(delayed_q)^2;
            
            power_current = power_current + double(power_sample);
            power_delayed = power_delayed + double(power_delayed_sample);
            
            % Update delay line (shift register)
            sample_delay = [sample_delay(2:end, :); double(sample_i), double(sample_q)];
            
            % Compute metric: |P|^2 / (R1 * R2)
            corr_mag_sq = corr_i^2 + corr_q^2;
            if power_current > 0 && power_delayed > 0
                metric = corr_mag_sq / (power_current * power_delayed);
            else
                metric = 0;
            end
            
            % Clamp metric to [0, 1]
            if metric > 1
                metric = 1;
            elseif metric < 0
                metric = 0;
            end
            
            % Update metric history for plateau detection
            metric_history = [metric_history(2:end); metric];
            
            % Detect plateau (high correlation for multiple samples)
            if metric > 0.75 % Threshold
                plateau_count = plateau_count + 1;
            else
                if plateau_count >= min_plateau
                    % End of plateau detected - this is the STO
                    state = 2;
                    sto = sto + plateau_count; % Record timing offset
                    
                    % Estimate CFO from correlation phase
                    phase_accum = atan2(corr_q, corr_i);
                end
                plateau_count = 0;
            end
            
            sto = sto + 1; % Count samples
            
            % Subtract oldest values from accumulators (sliding window)
            if sto > 16
                oldest_idx = mod(sto - 17, 16) + 1;
                % Note: This is simplified; full implementation needs proper windowing
            end
            
        case 2 % DONE
            % Hold outputs
            metric = 0;
            phase = phase_accum;
    end
    
    state_out = state;
    sto_out = sto;
end
