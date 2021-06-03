% clear everything
clear all
clc

% define constants
g = 9.81;
L1 = 1;
L2 = 1;
m1 = 1;
m2 = 1;
t = linspace(0, 10, 240);

% solve odes
sol = ode45(@(t, y) doublePendulum(t, y, L1, L2, m1, m2, g), t, [pi/10 0 pi/30 0]);

% generate video
theta1 = interp1(sol.x, sol.y(1, :), t);
theta2 = interp1(sol.x, sol.y(3, :), t);
videoDouble(t, theta1, theta2, 10, L1, L2, 'pendDuplo');
