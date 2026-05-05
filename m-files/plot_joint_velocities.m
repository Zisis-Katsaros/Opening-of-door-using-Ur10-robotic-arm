function plot_joint_velocities(t_array, q_dot_array)
    % Plots joint velocities over time
    %
    % Inputs:
    % t_array: Array of time values
    % q_array: Array containing joint angle values over time 
    %
    % Outputs:
    % -None-
    figure;
    plot(t_array, q_dot_array, 'LineWidth', 1.5);
    xlabel('t (s)'); 
    ylabel('θi. (rad/s)');
    title('Joint Velocity Responses θ1. to θ2.');
    legend('θ1.','θ2.','θ3.','θ4.','θ5.','θ6.');
    grid on;
end

