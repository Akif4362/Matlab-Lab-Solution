clc; clear;
syms x y

sf = y - x^2;

xspan = linspace(-3, 3, 50);
hold on
plot(xspan, xspan.^2)
plot(xspan, xspan.^2 + 1)
plot(xspan, xspan.^2 + 2)
legend("psi = 0", "psi = 1", "psi = 2")
title("stream lines")
xlabel("u")
ylabel("v")

fprintf("x component of velocity, u == %s \n", diff(sf,y))
fprintf("y component of velocity, v == %s", -diff(sf,x))
