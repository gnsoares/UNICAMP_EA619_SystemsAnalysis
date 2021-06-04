% clear everything
clear all
clc

% define constants
g = 9.81;
L1 = 1;
L2 = 1;
m1 = 1;
m2 = 1;
t = linspace(0, 10, 2400);

% solve odes
options = odeset('maxStep', 10/240, 'RelTol', 1e-6);
sol = ode45(@(t, y) doublePendulum(t, y, L1, L2, m1, m2, g), t, [pi/8 -2 pi/10 0], options);

% generate video
theta1 = sol.y(1, :);
theta2 = sol.y(3, :);
videoDouble(sol.x, theta1, theta2, 10, L1, L2, 'pendDuplo');
