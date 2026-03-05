N = 1000;
I_test = randi([-50, 50], N, 1);
Q_test = randi([-50, 50], N, 1);

stf_pattern_I = randi([-1000, 1000], 16, 1);
stf_pattern_Q = randi([-1000, 1000], 16, 1);
stf_signal_I = repmat(stf_pattern_I, 10, 1);
stf_signal_Q = repmat(stf_pattern_Q, 10, 1);

I_test(300 : 300 + 160 - 1) = stf_signal_I;
Q_test(300 : 300 + 160 - 1) = stf_signal_Q;

min_energy_threshold = 50000;
trigger_flag = power_trigger_rx(I_test, Q_test, 16, 500000);

[sync_flag, c_val, e_val] = sync_short_rx(I_test, Q_test, 16, 16, 0.5, min_energy_threshold);

figure;
plot(trigger_flag, 'b', 'LineWidth', 1.5); hold on;
plot(sync_flag, 'r', 'LineWidth', 1.2);
ylim([-0.1 1.1]);
title('Senkronizasyon Sinyalleri');
legend('Power Trigger', 'Sync Short');
grid on;

fid_i  = fopen('i_data.txt', 'w');
fid_q  = fopen('q_data.txt', 'w');
fid_pt = fopen('pt_ref.txt', 'w');
fid_ss = fopen('ss_ref.txt', 'w');

for i = 1:N
    hex_i = dec2hex(typecast(int16(I_test(i)), 'uint16'), 4);
    hex_q = dec2hex(typecast(int16(Q_test(i)), 'uint16'), 4);
    
    fprintf(fid_i, '%s\n', hex_i);
    fprintf(fid_q, '%s\n', hex_q);
    fprintf(fid_pt, '%d\n', trigger_flag(i));
    fprintf(fid_ss, '%d\n', sync_flag(i));
end

fclose(fid_i);
fclose(fid_q);
fclose(fid_pt);
fclose(fid_ss);

function trigger_out = power_trigger_rx(I_in, Q_in, L, threshold)
    I = double(I_in);
    Q = double(Q_in);
    inst_power = (I.^2) + (Q.^2);
    moving_sum_coeffs = ones(1, L);
    power_sum = filter(moving_sum_coeffs, 1, inst_power);
    trigger_out = power_sum > threshold;
end

function [sync_detected, C_mag_sq, E_sq_scaled] = sync_short_rx(I_in, Q_in, D, L, norm_factor, min_energy_threshold)
    r = complex(double(I_in), double(Q_in));
    r_delayed = [zeros(D, 1); r(1:end-D)];
    conj_prod = r .* conj(r_delayed);
    C = filter(ones(1, L), 1, conj_prod);
    C_mag_sq = real(C).^2 + imag(C).^2;
    inst_energy = abs(r_delayed).^2;
    E = filter(ones(1, L), 1, inst_energy);
    E_sq_scaled = (E.^2) * (norm_factor^2);
    
    sync_detected = (C_mag_sq > E_sq_scaled) & (E > min_energy_threshold);
end