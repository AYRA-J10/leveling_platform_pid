% =========================================================================
% COMPLETE LEVELING PLATFORM GNC & CONTROL SIMULATION
% Author: Riya Joseph — First-Principles Engineering
% Plant: Servo-driven leveling platform (J=0.01, b=0.1)
% =========================================================================
clear; clc; close all;

%% 1. PLANT & CONTROLLER
J = 0.01;
b = 0.1;
s = tf('s');
plant = 1 / (J*s^2 + b*s);

Kp = 1.5;
Ki = 0.5;
Kd = 0.8;
N_filter = 100;

controller = pid(Kp, Ki, Kd, 1/N_filter);

%% 2. CLOSED-LOOP SYSTEMS
sys_cl    = feedback(controller * plant, 1);  % normal step response
sys_dist  = feedback(plant, controller);       % disturbance → output

%% 3. TIME VECTOR
t = 0:0.01:4;

%% 4. WIND DISTURBANCE RESPONSE
disturbance = 0.5 * (t >= 1.5);
[y_dist, ~] = lsim(sys_dist, disturbance, t);

%% 5. SENSOR NOISE + FILTERED STEP RESPONSE
noise        = 0.005 * randn(size(t));
y_clean      = step(sys_cl, t);
y_noisy      = y_clean + noise';
y_filtered   = filter(ones(1,10)/10, 1, y_noisy);  % moving average filter

%% 6. PERFORMANCE METRICS
info         = stepinfo(sys_cl);
ss_error     = abs(1 - dcgain(sys_cl));

disp('=============================================');
disp('   CONTROL SYSTEM PERFORMANCE METRICS        ');
disp('=============================================');
fprintf('1. Rise Time:        %.4f seconds\n', info.RiseTime);
fprintf('2. Overshoot:        %.2f %%\n',      info.Overshoot);
fprintf('3. Settling Time:    %.4f seconds\n', info.SettlingTime);
fprintf('4. Steady-State Err: %.6f\n',         ss_error);
disp('=============================================');

%% 7. PLOTS
figure('Name', 'Platform Control Analysis', 'Position', [100, 100, 900, 700]);

% Plot 1 — Wind disturbance recovery
subplot(2,2,1);
plot(t, y_dist, 'r', 'LineWidth', 1.8);
grid on;
xline(1.5, '--k', 'Wind Gust', 'LineWidth', 1.2);
title('Disturbance Recovery (Wind at t=1.5s)');
xlabel('Time (s)'); ylabel('Angle (rad)');

% Plot 2 — Clean step response
subplot(2,2,2);
plot(t, y_clean, 'b', 'LineWidth', 1.8);
grid on;
yline(1, '--k', 'Setpoint', 'LineWidth', 1);
title('Clean PID Step Response');
xlabel('Time (s)'); ylabel('Angle (rad)');

% Plot 3 — Noisy vs filtered
subplot(2,2,3);
plot(t, y_noisy,    'Color', [0.7 0.7 0.7], 'LineWidth', 1);
hold on;
plot(t, y_filtered, 'b', 'LineWidth', 1.8);
grid on;
legend('Noisy sensor', 'Filtered output');
title('Sensor Noise vs Filtered Response');
xlabel('Time (s)'); ylabel('Angle (rad)');

% Plot 4 — Performance metrics as text
subplot(2,2,4);
axis off;
text(0.1, 0.85, 'PERFORMANCE METRICS',  'FontWeight', 'bold', 'FontSize', 12);
text(0.1, 0.70, sprintf('Rise Time:       %.4f s',  info.RiseTime),    'FontSize', 11);
text(0.1, 0.55, sprintf('Overshoot:       %.2f %%', info.Overshoot),   'FontSize', 11);
text(0.1, 0.40, sprintf('Settling Time:   %.4f s',  info.SettlingTime),'FontSize', 11);
text(0.1, 0.25, sprintf('Steady-State Err: %.6f',   ss_error),         'FontSize', 11);
text(0.1, 0.08, 'Plant: G(s) = 1/(Js² + bs)', 'FontSize', 9, 'Color', [0.4 0.4 0.4]);

sgtitle('Leveling Platform — Full PID Control Analysis', 'FontSize', 14, 'FontWeight', 'bold');