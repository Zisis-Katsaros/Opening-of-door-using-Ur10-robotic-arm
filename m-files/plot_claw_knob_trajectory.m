function  plot_claw_knob_trajectory(q_array,g_oh_array)
    % Plots claw's and doorknob's position trajectory in 3d space
    % 
    % Inputs:
    % q_array: Array containing joint angle values over time 
    % g_oh_array: Array containing g_oh values over time
    %
    % Outputs:
    % -None-
    mdl_ur10
    ur10.base = transl(1, 1, 0); 
    
    N =length(q_array);

    p_oe = zeros(N, 3);
    p_oh = zeros(N, 3);

    for i = 1:N
        p_oe(i, :) = ur10.fkine(q_array(i,:)).t'; % get only p_oe submatrix
                                                  % of g_oe (and transpose)
        p_oh(i, :) = g_oh_array(1:3,4,i)';
    end

    figure;
    plot3(p_oe(:,1), p_oe(:,2), p_oe(:,3), 'r-', 'LineWidth', 2); hold on;
    plot3(p_oh(:,1), p_oh(:,2), p_oh(:,3), 'k--', 'LineWidth', 2);
    legend('Claw Path', 'Knob Path');
    xlabel('X'); 
    ylabel('Y'); 
    zlabel('Z'); 
    grid on; 
    axis equal;
    title('Claw & Doorknob Trajectory');
end

