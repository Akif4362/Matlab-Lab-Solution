clc; clear;
syms r t
syms x y 

sf = 2*t;
vp = 2*log(r);

[R, T] = meshgrid(linspace(0.1, 5, 50), linspace(0, 2*pi, 50));

X = R.*cos(T);
Y = R.*sin(T);

sff = matlabFunction(sf);
vpf = matlabFunction(vp);

contour(X, Y, sff(T), 25, 'b')
hold on
contour(X, Y, vpf(R), 25, 'r--')

title("stream lines and equipotential lines")
xlabel("x")
ylabel("y")

ur = diff(vp,r);
ut = diff(vp,t)/r;
u = ur*cos(t) - ut*sin(t);
v = ur*sin(t) + ut*cos(t);

u = subs(u, [cos(t) sin(t)], [x/r y/r]);
u = subs(u, r, sqrt(x^2 + y^2));

v = subs(v, [cos(t) sin(t)], [x/r y/r]);
v = subs(v, r, sqrt(x^2 + y^2));

uf = matlabFunction(u);
vf = matlabFunction(v);

[X, Y] = meshgrid(linspace(-4, 4, 10));
quiver(X, Y, uf(X, Y), vf(X, Y))
legend("stream line", "equipotential lines", "velo")
fprintf("therefore the flow is a source")
