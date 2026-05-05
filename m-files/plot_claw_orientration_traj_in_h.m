function plot_claw_orientration_traj_in_h(t_array, g_oh_array, q_array)
    % Plots claw's orientation trajectory in regards to {H} over time 
    % using unit quaternions
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

    quaternion_array = zeros(N,4);

    for i = 1:N
        g_oe = ur10.fkine(q_array(i,:)).T;
        g_he = inv(g_oh_array(:, :, i)) * g_oe;
        R_he = g_he(1:3, 1:3);
        quaternion = UnitQuaternion(R_he); % get unit quaternion from R_he  
        quaternion_array(i, :) = quaternion.double(); % get 1x4 unit quaternion matrix and store 
                                             % it in the unit quat. array
    end
    figure;
    plot(t_array, quaternion_array(:,1), 'r', 'LineWidth', 1.5); hold on;
    plot(t_array, quaternion_array(:,2), 'g', 'LineWidth', 1.5);
    plot(t_array, quaternion_array(:,3), 'b', 'LineWidth', 1.5);
    plot(t_array, quaternion_array(:,4), 'm--', 'LineWidth', 1.5);
    legend('w', 'x', 'y', 'z');
    xlabel('t (s)'); 
    ylabel('Quaternion Components');
    title('Claw Orientation in Unit Quaternion in regards to {H}');
    grid on;
end

