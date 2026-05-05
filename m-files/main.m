clc; clear; close all;

% ############################### PART A ############################### %

% ============================= Parameters ============================= %

l = 1;            
l0 = 0.1;        
h = 0.7;          
T = 5;            
t0 = 2; % time it takes to unlock the door           
phi_f = -pi/4;    
theta_f = -pi/6; 
dt = 0.01; % step         
t_array = 0:dt:T;
N = length(t_array);


% ============== Const. Orientation and Position Matrices ============== %

p_od = [0; 2; 0];                
p_dh = [l - l0; 0; h];           
R_dh0 = [0 1 0; -1 0 0; 0 0 1]; % starting orientation of {H} in regards 
                                % to {D}


% ======================= Calculate φ(t) & θ(t) ======================= %

% Solve equation system to find factors ki  
k_phi = calculate_k(0, phi_f, T - t0);
k_theta_unlock = calculate_k(0, theta_f, t0);
k_theta_open = calculate_k(theta_f, 0, T - t0);

% Initialize phi and theta arrays
phi_array = zeros(N,1);
theta_array = zeros(N,1);

for i = 1:N
    t = t_array(i);
    if t <= t0
        theta_array(i) = quintic(k_theta_unlock, t);
        phi_array(i) = 0;
    else
        theta_array(i) = quintic(k_theta_open, t-t0);
        phi_array(i) = quintic(k_phi, t-t0);
    end
end

% Plot φ(t) and θ(t)
plot_phi_theta(t_array, phi_array, theta_array);


% ============================ Visualization =========================== %

% Initialize array with homogenous transform of {H} in regards to {0} values over time
g_oh_array = zeros(4, 4, N);
% Initialize array with unit quaternion values over time
q_array = zeros(N, 4); 
% Initialize array with unit position matrix values over time
p_oh_array = zeros(N, 3);

% Calculate g_oh and trajectory of orientation in unit quaternion, 
% Visualize the unlocking and opening of door in 3d space
figure;
for i = 1:N
    phi_t = phi_array(i);
    theta_t = theta_array(i);

    % Calculate g_od
    R_od = rotz(phi_t);
    g_od = [R_od, p_od; 0 0 0 1];

    % Calculate g_dh
    R_hh = rotx(theta_t);
    R_dh = R_dh0 * R_hh;
    g_dh = [R_dh, p_dh; 0 0 0 1];

    % Calculate g_oh
    g_oh = g_od * g_dh;
    g_oh_array(:, :, i) = g_oh; % store g_oh for part b

    p_oh_array(i, :) = g_oh(1:3, 4)'; % position submatrix
    R_oh = g_oh(1:3, 1:3); % orientation submatrix
    q = UnitQuaternion(R_oh); % get unit quaternion from R_oh  
    q_array(i, :) = q.double(); % get 1x4 unit quaternion matrix and store 
                                % it in the unit quat. array

    clf;
    % Plot {0} frame
    trplot(eye(4), 'frame', '0', 'color', 'k', 'length', 0.5); hold on;
    % Plot {H} frame
    trplot(g_oh, 'frame', 'H', 'color', 'r', 'length', 0.2); hold on;
    % Plot {D} frame 
    trplot(g_od, 'frame', 'D', 'color', 'b', 'length', 0.2);

    title(sprintf('Doorknob Trajectory | t = %.1f s', t_array(i)));
    axis equal; 
    view(30,20); 
    grid on;
    xlim([-1, 1.5]); 
    ylim([-1, 2.5]); 
    zlim([0, 1.5]);

    pause(0.01);    
end

% Plot doorknob orientation trajectory in unit quaternion 
plot_knob_orientation_traj_uq(t_array, q_array);

% Plot doorknob position trajectory in 3d space
plot_position_trajectory(p_oh_array);


% ############################### PART B ############################### %

% Load Ur10 robot
mdl_ur10
ur10.base = transl(1, 1, 0); % set base coordinates

% Initialize array with joint angle values over time 
q_array = zeros(N, 6);
q_array(1,:) = [-1.7752 -1.1823 0.9674 0.2149 1.3664 1.5708]; % start position

% Calculate homogenous transformation of {e} in regards to {H} 
R_he = [0 0 -1; 0 1 0; 1 0 0];
p_he = [0.1; 0.1; 0];
g_he = [R_he, p_he; 0 0 0 1];

% Initialize array with values of derivative of q over time 
q_dot_array = zeros(N, 6);  
% Initialize array with g_oe values over time
g_oe_array = zeros(4, 4, N);

% Itterate through all points of time 
for i = 1:N-1
    q = q_array(i,:);
    g_oh = g_oh_array(:,:,i);
    g_oe = ur10.fkine(q);
    g_oe_array(:,:,i) = g_oe;

    g_oh_next = g_oh_array(:,:,i+1); 
    g_oe_next = g_oh_next * g_he;

    Ve = tr2delta(g_oe, g_oe_next) / dt;  % tr2delta outputs spatial velocity
                                         % multiplied by time step, that's 
                                         % why we devide by dt
    Je = ur10.jacobe(q);
    q_dot_array(i,:) = inv(Je) * Ve; % q_dot = Je^(-1)*Ve 

    q_array(i+1,:) = q + q_dot_array(i,:) * dt; % numerical integration to get next
                                                % position
end


% ============================ Visualization =========================== %

% Visualize motion of robotic arm
figure;
ur10.plot(q_array, 'fps', 1/dt, 'workspace', [0 2 0 3 0 2]);


% Plot trajectory of the doorknob and the robot's claw
plot_claw_knob_trajectory(q_array,g_oh_array);

% Plot trajectory of orientation in unit quaternion 
plot_claw_orientation_traj_uq(t_array, q_array);

% Plot claw's position trajectory in regards to {H}
plot_position_he(t_array, g_oh_array, q_array);

% Plot claw's orientation trajectory in regards to {H}
plot_claw_orientration_traj_in_h(t_array, g_oh_array, q_array);

% Plot joint position responses
plot_joint_positions(t_array, q_array);

% Plot joint velocity responses
plot_joint_velocities(t_array, q_dot_array);




