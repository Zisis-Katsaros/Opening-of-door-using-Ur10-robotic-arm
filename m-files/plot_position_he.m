function plot_position_he(t_array, g_oh_array, q_array)
    % Plots claw's position trajectory in regards to {H} over time 
    %
    % Inputs:
    % t_array: Array of time values
    % g_oh_array: Array containing g_oh values over time
    % q_array: Array containing joint angle values over time 
    %
    % Outputs:
    % -None-
    mdl_ur10
    ur10.base = transl(1, 1, 0);
    
    N = length(t_array);

    p_he_array = zeros(N,3);

    for i = 1:N
        g_oe = ur10.fkine(q_array(i,:)).T;
        g_he = inv(g_oh_array(:, :, i)) * g_oe;
        p_he_array(i, :) = g_he(1:3, 4);
    end

    figure;
    plot(t_array, p_he_array(:,1), 'r', 'LineWidth', 1.5); hold on;
    plot(t_array, p_he_array(:,2), 'g--', 'LineWidth', 1.5);
    plot(t_array, p_he_array(:,3), 'b', 'LineWidth', 1.5);
    legend('x', 'y', 'z');
    xlabel('t (s)'); 
    ylabel('Coordinates of claw');
    title('Claw position in regards to {H}');
    grid on;
    title('Claw Trajectory in reguards to {H} over time');
end


