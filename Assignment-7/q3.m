clc; clear;

a = 3;  
m = 1;  

syms x y 
z = x + 1i*y;

Fz = (m / (2*pi)) * log((z.^2 - a^2) ./ (z.^2 + a^2));
sf = imag(Fz);
vp = real(Fz);
sff = matlabFunction(sf);

[X, Y] = meshgrid(linspace(-6, 6, 400), linspace(-6, 6, 400));

hold on
contour(X, Y, sff(X,Y), 80);

theta = linspace(0, 2*pi, 200);
plot(3*cos(theta), 3*sin(theta), 'r--');

plot([a, -a], [0, 0], 'ko', 'MarkerFaceColor', 'g');
plot([0, 0], [a, -a], 'ko', 'MarkerFaceColor', 'r');

u = diff(vp,x);
v = diff(vp,y);
u_f = matlabFunction(u);
v_f = matlabFunction(v);

[X, Y] = meshgrid(linspace(-6, 6, 10));
quiver(X, Y, u_f(X, Y), v_f(X, Y))
legend("streamlines", "circle", "source", "sink", "velocity")
xlabel("x")
ylabel("y")
title("streamline")
