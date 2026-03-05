function trigger_out = power_trigger(I_in, Q_in, L, threshold)
    I = double(I_in);
    Q = double(Q_in);
    inst_power = (I.^2) + (Q.^2);
    moving_sum_coeffs = ones(1, L);
    power_sum = filter(moving_sum_coeffs, 1, inst_power);
    trigger_out = power_sum > threshold;
end