function  plot_knob_orientation_traj_uq(t_array,q_array)
    % Plots Doorknob's orientation trajectroy in unit quaternions 
    %
    % Inputs: 
    % t_array: Array of points in time 
    % q_array: Array containing the orientation of {H} described in unit 
    %          quaternion at every point in time
    figure;
    plot(t_array, q_array(:,1), 'r', 'LineWidth', 1.5); hold on;
    plot(t_array, q_array(:,2), 'g', 'LineWidth', 1.5);
    plot(t_array, q_array(:,3), 'b', 'LineWidth', 1.5);
    plot(t_array, q_array(:,4), 'm', 'LineWidth', 1.5);
    legend('w', 'x', 'y', 'z');
    xlabel('t (s)'); 
    ylabel('Quaternion Components');
    title('Doorknob Orientation in Unit Quaternion');
    grid on;
end

