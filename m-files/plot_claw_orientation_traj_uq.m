function plot_claw_orientation_traj_uq(t_array, q_array)
    % Plots claw's orientation trajectory over time using unit quaternions
    %
    % Inputs:
    % t_array: Array of time values
    % q_array: Array containing joint angle values over time 
    %
    % Outputs:
    % -None-
    mdl_ur10
    ur10.base = transl(1, 1, 0);

    N = length(t_array);

    quaternion_array = zeros(N, 4);
    for i = 1:N
        R_oe = ur10.fkine(q_array(i,:)).R;
        quaternion = UnitQuaternion(R_oe); % get unit quaternion from R_oh  
        quaternion_array(i, :) = quaternion.double(); % get 1x4 unit quaternion matrix and store 
                                             % it in the unit quat. array
    end

    figure;
    plot(t_array, quaternion_array(:,1), 'r', 'LineWidth', 1.5); hold on;
    plot(t_array, quaternion_array(:,2), 'g', 'LineWidth', 1.5);
    plot(t_array, quaternion_array(:,3), 'b', 'LineWidth', 1.5);
    plot(t_array, quaternion_array(:,4), 'm', 'LineWidth', 1.5);
    legend('w', 'x', 'y', 'z');
    xlabel('t (s)'); 
    ylabel('Quaternion Components');
    title('Claw Orientation in Unit Quaternion');
    grid on;
end

