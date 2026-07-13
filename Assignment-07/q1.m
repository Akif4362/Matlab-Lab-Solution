clc; clear;
syms x y f(y)

fprintf("(a)\n")
sf = 2*x*y;

if diff(sf,x,2) + diff(sf,y,2) == 0
    fprintf("flow follows laplace condition")
end

fprintf("\n\n(b)\n")
u = diff(sf, y);
v = -diff(sf, x);

vp = int(u,x);

fprintf("integrating u: \n")
fprintf("vp == %s \n", vp + f(y))
fprintf("differentiating vp wrt y: \n")
fprintf("f'(y) == %s \n", v)
fprintf("integrating wrt y: \n")

f = dsolve(diff(vp + f(y), y) == v, f(0)==0);
fprintf("f(y) == %s \n", f)

vp = vp + f;
fprintf("velocity potential is %s", vp)

fprintf("\n\n(c)\n")
fprintf("plotting")
sff = matlabFunction(sf);
vpf = matlabFunction(vp);

[X, Y] = meshgrid(linspace(-2, 2, 50));
contour(X, Y, sff(X, Y), 25, 'r')
hold on 
contour(X, Y, vpf(X, Y), 25, 'b')
title("stream line and equipotential lines")
xlabel("u")
ylabel("v")
legend("stream lines", "equipotential lines")

fprintf("\n\n(d)\n")
mag = sqrt(subs(u, [x y], [3 1])^2 + subs(v, [x y], [3 1])^2);
fprintf("magnitude of velocity at (3,1) is %f", mag)
