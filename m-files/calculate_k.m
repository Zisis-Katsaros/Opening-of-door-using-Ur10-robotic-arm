function k = calculate_k(q0,qf, Tf)
    % Calculates factors ki, i = 0...5 of a quintic function
    %
    % Inputs: 
    % q0: Starting position
    % qf: Final position
    % Tf: Time to go from q0 to qf
    %
    % Outputs:
    % k: [k0, ..., k5] 
    A = [1 0 0 0 0 0;
        0 1 0 0 0 0;
        0 0 2 0 0 0;
        1 Tf Tf^2 Tf^3 Tf^4 Tf^5;
        0 1 2*Tf 3*Tf^2 4*Tf^3 5*Tf^4;
        0 0 2 6*Tf 12*Tf^2 20*Tf^3;];

    b = [q0; 0; 0; qf; 0; 0;];

    k = A \ b;
end

