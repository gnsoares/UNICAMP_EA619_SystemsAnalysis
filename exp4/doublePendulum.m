function dX = doublePendulum(t, x, L1, L2, m1, m2, g)
    % dx1/dt = d(theta_1)/dt
    dX(1, 1) = x(2);

    % dx2/dt = d(w_1)/dt
    num1 = - g * (2 * m1 + m2) * sin(x(1)) - m2 * g * sin(x(1) - 2 * x(3)) - 2 * sin(x(1) -x(3)) * m2 * (x(4)^2 * L2 + x(2)^2 * L1 * cos(x(1) -x(3)));
    den1 = L1 * (2 * m1 + m2 - m2 * cos(2 * x(1) - 2 * x(3)));
    dX(2, 1) = num1 / den1;

    % dx3/dt = d(theta_2)/dt
    dX(3, 1) = x(4);

    % dx4/dt = d(w_2)/dt
    num2 = 2 * sin(x(1) - x(3)) * (x(2)^2 * L1 * (m1 + m2) + g * (m1 + m2) * cos(x(1)) + x(4)^2 * L2 * m2 * cos(x(1) - x(3)));
    den2 = L2 * (2 * m1 + m2 - m2 * cos(2 * x(1) - 2 * x(3)));
    dX(4, 1) = num2 / den2;
end
