clc; clear;
% (a)
fprintf("(a)\n")
syms x y real 
z = x + 1i * y;
fz = expand(z^2);
vp = real(fz);
sf = imag(fz);

fprintf("f(z) = %s + i%s \n", vp, sf)

vp_x = diff(vp,x);
vp_y = diff(vp,y);
sf_x = diff(sf,x);
sf_y = diff(sf,y);

if vp_x == sf_y && vp_y == -sf_x 
    fprintf("CR eqtions are satisfied\n")
end

% (b)
fprintf("\n(b)\n")
if diff(vp,x,2) + diff(vp,y,2) == 0
    fprintf("velo potential is harmonic function\n")
end

if diff(sf,x,2) + diff(sf,y,2) == 0
    fprintf("stream function is harmonic function\n")
end

% (c)
fprintf("\n(c)\n")
u = vp_x;
v = vp_y;
fprintf("u = %s \n", u)
fprintf("v = %s \n", v)

% (d)
fprintf("\n(d)\n")
[X, Y] = meshgrid(-2:0.01:2, -2:0.01:2);

vp_f = matlabFunction(vp);
sf_f = matlabFunction(sf);
u_f = matlabFunction(u);
v_f = matlabFunction(v);

contour(X, Y, vp_f(X,Y), 25, 'b--')
hold on
contour(X, Y, sf_f(X,Y), 25, 'r--')
legend("velocity potential", "stream function")
title("Velocity Potential and Stream Function Graph")
xlabel("x")
ylabel("y")

figure
[X, Y] = meshgrid(-2:0.3:2, -2:0.3:2);
quiver(X, Y, u_f(X), v_f(Y))
xlim([-2 2])
title("Velocity Field")
xlabel("x")
ylabel("y")

fprintf("the flow is symmetric about x and y axis and stagnation point is at (0,0)")
