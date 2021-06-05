% clear everything
clear all
clc

% define constants
g = 9.81;
l = 1;
t = linspace(0, 10, 2400);

% solve odes
options = odeset('maxStep', 10/240, 'RelTol', 1e-6);
sol_nonlinear_piover10 = ode45(@(t, y) [y(2), -g/l * cos(y(1)) * y(1)].', t, [pi/10 0], options);
sol_linear_piover10 = ode45(@(t, y) [y(2), -g/l * y(1)].', t, [pi/10 0], options);

% generate video
% videoSimple(sol_nonlinear_piover10.x, sol_nonlinear_piover10.y(1, :), sol_linear_piover10.y(1, :), 10, l, 'pendSimples_piover10');

% generate video for (pi/4, 0)
sol_nonlinear_piover4 = ode45(@(t, y) [y(2), -g/l * cos(y(1)) * y(1)].', t, [pi/4 0], options);
sol_linear_piover4 = ode45(@(t, y) [y(2), -g/l * y(1)].', t, [pi/4 0], options);
% videoSimple(sol_nonlinear_piover4.x, sol_nonlinear_piover4.y(1, :), sol_linear_piover4.y(1, :), 10, l, 'pendSimples_piover4');

% generate phase diagram
figure();
hold on;

xlabel('\theta (rad)');
ylabel('d\theta/dt (rad/s)');
plot(sol_nonlinear_piover4.y(1, :), sol_nonlinear_piover4.y(2, :), 'red');
plot(sol_linear_piover4.y(1, :), sol_linear_piover4.y(2, :), 'blue');

hold off;

% get the time instants where the lag is bigger than 2 degrees
t_lag_piover10 = [];
lag_piover10 = sol_linear_piover10.y(1, :) - sol_nonlinear_piover10.y(1, :);
for i = 1:length(sol_linear_piover10.x)
    if abs(lag_piover10(i)) > pi/90
        t_lag_piover10(end + 1) = t(i);
    end
end

t_lag_piover4 = [];
lag_piover4 = sol_linear_piover4.y(1, :) - sol_nonlinear_piover4.y(1, :);
for i = 1:length(sol_linear_piover4.x)
    if abs(lag_piover4(i)) > pi/90
        t_lag_piover4(end + 1) = t(i);
    end
end

% visualize the lag
figure();
hold on;

subplot(2, 1, 1);
xlabel('t (s)');
plot(sol_linear_piover10.x, lag_piover10);
line([0 t(end)], [pi/90 pi/90]);
line([0 t(end)], [-pi/90 -pi/90]);

subplot(2, 1, 2);
xlabel('t (s)');
plot(sol_linear_piover4.x, lag_piover4);
line([0 t(end)], [pi/90 pi/90]);
line([0 t(end)], [-pi/90 -pi/90]);

hold off;
