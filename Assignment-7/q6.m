clc; clear;
syms t
h = 5;          
v = 540 / 60; % in km / minutes   
d0 = 100;       
x0 = sqrt(d0^2 - h^2);

xt = x0 - v*t;

fprintf("(a)\n")
theta = atan2d(h, xt);
fprintf("theta = %s \n", theta)

fprintf("\n(b)\n")
omega = (h * v) ./ (xt.^2 + h^2) * (180/sym(pi));
fprintf("omega = %s \n", omega)

tspan = linspace(0, 20, 1000); 

theta_f = matlabFunction(theta);
omega_f = matlabFunction(omega);

figure;
subplot(2,1,1);
plot(tspan, theta_f(tspan), 'b');
ylabel('angle of elevation (degrees)')
xlabel('time (minutes)')
title('radar antenna angle vs time')

subplot(2,1,2);
plot(tspan, omega_f(tspan), 'r');
ylabel('angular velocity (deg/min)')
xlabel('time (minutes)')
title('angular velocity vs time')

fprintf("\n(c)\n")
fprintf("plotting")
