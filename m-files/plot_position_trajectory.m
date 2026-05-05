function  plot_position_trajectory(p_array)
    % Plots Doorknob's position trajectroy in 3d space
    %
    % Inputs:
    % p_array: Array containing the position matrix of {H} at every point in
    %          time
    %
    % Output: 
    % -None-
    figure;
    plot3(p_array(:,1), p_array(:,2), p_array(:,3), 'k', 'LineWidth', 2);
    xlabel('x'); 
    ylabel('y'); 
    zlabel('z');
    title('Doorknob Position Trajectory');
    grid on; axis equal;
end

