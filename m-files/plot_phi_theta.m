function plot_phi_theta(t_array,phi_array, theta_array)
    % Plots Graph of φ(t) and θ(t) over time
    %
    % Inputs:
    % t_array: Array of time values
    % phi_array: Array of phi values
    % theta_array: Array of theta values
    %
    % Outputs: 
    % -None-

    % φ(t) Plot
    figure;
    subplot(2,1,1);
    plot(t_array, rad2deg(phi_array), 'LineWidth', 2, 'Color', 'b');
    xlabel('t (s)'); 
    ylabel('\phi (deg)'); 
    title('Door Rotation'); 
    grid on;
    
    % θ(t) Plot
    subplot(2,1,2);
    plot(t_array, rad2deg(theta_array), 'LineWidth', 2, 'Color', 'r');
    xlabel('t (s)'); 
    ylabel('\theta (deg)'); 
    title('Doorknob Tilt'); 
    grid on;
end

