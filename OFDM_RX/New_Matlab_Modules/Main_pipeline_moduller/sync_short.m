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
%   metric: Correlation metric (normalized, per sample)
%   phase: CFO estimate (phase accumulation)
%   state_out: State machine state
%   sto_out: Sample timing offset (STO) estimate
%
% States: 0=IDLE, 1=SYNC, 2=DONE
%
% Method (sample-by-sample):
%   P[n] = s[n] * conj(s[n-16])
%   R1[n] = |s[n]|^2
%   R2[n] = |s[n-16]|^2
%   metric[n] = |P[n]|^2 / (R1[n] * R2[n])
%   Detect when metric > threshold for min_plateau consecutive samples

    persistent state;
    persistent sample_delay;      % 16-sample delay line [I, Q] pairs
    persistent metric_history;    % History for plateau detection
    persistent plateau_count;     % Count of consecutive high metrics
    persistent sto;
    persistent phase_accum;
    persistent sample_count;      % Total samples processed
    
    if isempty(state) || reset
        state = 0;
        sample_delay = zeros(16, 2);
        metric_history = zeros(16, 1);
        plateau_count = 0;
        sto = 0;
        phase_accum = 0;
        sample_count = 0;
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
                sample_count = 0;
            end
            
        case 1 % SYNC - Looking for short preamble
            % Get delayed sample (16 samples ago) BEFORE updating delay line
            delayed_i = sample_delay(1, 1);
            delayed_q = sample_delay(1, 2);
            
            % Update delay line (shift register, FIFO)
            sample_delay = [sample_delay(2:end, :); double(sample_i), double(sample_q)];
            sample_count = sample_count + 1;
            
            % Skip first 16 samples (delay line not filled with real signal yet)
            if sample_count <= 16
                metric = 0;
            else
                % Compute single-sample correlation: P[n] = s[n] * conj(s[n-16])
                % Complex multiply: (a+jb)*(c-jd) = (ac+bd) + j(bc-ad)
                corr_i = double(sample_i) * delayed_i + double(sample_q) * delayed_q;
                corr_q = double(sample_q) * delayed_i - double(sample_i) * delayed_q;
                
                % Power: R1 = |s[n]|^2, R2 = |s[n-16]|^2
                power_current = double(sample_i)^2 + double(sample_q)^2;
                power_delayed = delayed_i^2 + delayed_q^2;
                
                % Compute metric: |P|^2 / (R1 * R2)
                corr_mag_sq = corr_i^2 + corr_q^2;
                if power_current > 0 && power_delayed > 0
                    metric = corr_mag_sq / (power_current * power_delayed);
                else
                    metric = 0;
                end
                
                % Clamp metric to [0, 1]
                metric = max(0, min(1, metric));
                
                % Update metric history
                metric_history = [metric_history(2:end); metric];
                
                % Detect plateau (high correlation for consecutive samples)
                if metric > 0.60 % Threshold for short preamble detection
                    plateau_count = plateau_count + 1;
                else
                    if plateau_count >= min_plateau
                        % End of plateau detected - transition to DONE
                        state = 2;
                        sto = sample_count - plateau_count; % STO is where plateau started
                        
                        % Estimate CFO from last correlation phase
                        phase_accum = atan2(corr_q, corr_i);
                    end
                    plateau_count = 0;
                end
            end
            
        case 2 % DONE
            % Hold last outputs
            metric = 0;
            phase = phase_accum;
    end
    
    state_out = state;
    sto_out = sto;
end
