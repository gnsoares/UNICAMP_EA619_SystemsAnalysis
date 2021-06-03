% clear everything
clear all
clc

% define constants
g = 9.81;
l = 1;
t = linspace(0, 10, 240);

% solve odes
sol_nonlinear_piover10 = ode45(@(t, y) [y(2), -g/l * cos(y(1)) * y(1)].', t, [pi/10 0]);
sol_linear_piover10 = ode45(@(t, y) [y(2), -g/l * y(1)].', t, [pi/10 0]);

% generate video
y_nonlinear_piover10 = interp1(sol_nonlinear_piover10.x, sol_nonlinear_piover10.y(1, :), t);
y_linear_piover10 = interp1(sol_linear_piover10.x, sol_linear_piover10.y(1, :), t);
% videoSimple(t, y_nonlinear_piover10, y_linear_piover10, 10, l, 'pendSimples_piover10');

% generate video for (pi/4, 0)
sol_nonlinear_piover4 = ode45(@(t, y) [y(2), -g/l * cos(y(1)) * y(1)].', t, [pi/4 0]);
sol_linear_piover4 = ode45(@(t, y) [y(2), -g/l * y(1)].', t, [pi/4 0]);
y_nonlinear_piover4 = interp1(sol_nonlinear_piover4.x, sol_nonlinear_piover4.y(1, :), t);
y_linear_piover4 = interp1(sol_linear_piover4.x, sol_linear_piover4.y(1, :), t);
% videoSimple(t, y_nonlinear_piover4, y_linear_piover4, 10, l, 'pendSimples_piover4');

% generate phase diagram
figure();
hold on;

xlabel('\theta (rad)');
ylabel('d\theta/dt (rad/s)');
plot(y_nonlinear_piover4, interp1(sol_nonlinear_piover4.x, sol_nonlinear_piover4.y(2, :), t), 'red');
plot(y_linear_piover4, interp1(sol_linear_piover4.x, sol_linear_piover4.y(2, :), t), 'blue');

hold off;

% get the time instants where the lag is bigger than 2 degrees
t_lag_piover10 = [];
lag_piover10 = y_linear_piover10 - y_nonlinear_piover10;
for i = 1:length(t)
    if abs(lag_piover10(i)) > pi/90
        t_lag_piover10(end + 1) = t(i);
    end
end

t_lag_piover4 = [];
lag_piover4 = y_linear_piover4 - y_nonlinear_piover4;
for i = 1:length(t)
    if abs(lag_piover4(i)) > pi/90
        t_lag_piover4(end + 1) = t(i);
    end
end

% visualize the lag
figure();
hold on;

subplot(2, 1, 1);
xlabel('t (s)');
plot(t, lag_piover10);
line([0 t(end)], [pi/90 pi/90]);
line([0 t(end)], [-pi/90 -pi/90]);

subplot(2, 1, 2);
xlabel('t (s)');
plot(t, lag_piover4);
line([0 t(end)], [pi/90 pi/90]);
line([0 t(end)], [-pi/90 -pi/90]);

hold off;
