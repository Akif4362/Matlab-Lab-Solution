clc; clear;
syms x w

f = piecewise((x > -pi) & (x <= pi), sin(x), 0);
disp("f(x) = ")
pretty(f)

disp("F(w) = ")
F = simplify(int(f*exp(-1i*w*x), x, -inf, inf));
disp(F)

fplot(f, [-4 4])
title("Plot of f(x)")
xlabel("x")
ylabel("y")

figure
fplot(abs(F), [-4 4])
title("Plot of |F(w)|")
xlabel("x")
ylabel("y")
