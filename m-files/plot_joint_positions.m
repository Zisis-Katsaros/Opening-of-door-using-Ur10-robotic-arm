function plot_joint_positions(t_array, q_array)
    % Plots joint positions over time
    %
    % Inputs:
    % t_array: Array of time values
    % q_array: Array containing joint angle values over time 
    %
    % Outputs:
    % -None-
    figure;
    plot(t_array, q_array, 'LineWidth', 1.5);
    xlabel('t (s)'); 
    ylabel('θi (rad)');
    title('Joint Position Responses θ1 to θ6');
    legend('θ1','θ2','θ3','θ4','θ5','θ6');
    grid on;

end

