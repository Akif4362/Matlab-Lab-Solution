clc; clear;
syms x y f(y)

u = 2*(x^2 - y^2);
v = -4*x*y;

vp = int(u,x);

fprintf("integrating u: \n")
fprintf("vp == %s \n", vp + f(y))
fprintf("differentiating vp wrt y: \n")
fprintf("%s == %s \n",diff(vp + f(y), y), v)
fprintf("integrating wrt y: \n")

f = dsolve(diff(vp + f(y), y) == v, f(0)==0);
fprintf("f(y) == %s \n", f)

vp = vp + f;
fprintf("velocity potential is %s", vp)

vpf = matlabFunction(vp);

[X, Y] = meshgrid(linspace(-2, 2, 75));

contour(X, Y, vpf(X, Y), 25, 'b')
title("equipotential lines")
xlabel("u")
ylabel("v")
legend("equipotential lines")
