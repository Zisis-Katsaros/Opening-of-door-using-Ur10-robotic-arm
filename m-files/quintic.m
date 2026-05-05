function q = quintic(k, t)
    % Calculates value of quintic function with factors k_i at point t
    %
    % Inputs:
    % k: 6x1 array containing factors k_i
    % t: Point at which value of function is calculated
    %
    % Output:
    % q: Value q(t)
    q = k(1) + k(2)*t + k(3)*t^2 + k(4)*t^3 + k(5)*t^4 + k(6)*t^5;
end
