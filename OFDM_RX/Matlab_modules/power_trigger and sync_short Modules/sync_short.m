function [sync_detected, C_mag_sq, E_sq_scaled] = sync_short(I_in, Q_in, D, L, norm_factor, min_energy_threshold)
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