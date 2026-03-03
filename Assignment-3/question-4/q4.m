clc; clear;

syms x(t) y(t) u(t) t s xn yn

ode1 = diff(x,t) == 1;
ode2 = diff(y,t) == 3*y^(2/3);
ode3 = diff(u,t) == 2;

xc = dsolve(ode1, x(0)==s);
xc = xc(end);
xc_func = matlabFunction(xc);

yc = dsolve(ode2, y(0)==1);
yc = yc(end);
yc_func = matlabFunction(yc);

uc = dsolve(ode3, u(0)==1+s);
uc = uc(end);
uc_func = matlabFunction(uc);

tval = solve(yn == yc, t);
tval = tval(1);
sval = solve(xn == subs(xc, t, tval), s);
uval = subs(uc,[s t], [sval tval]);
u_func = matlabFunction(uval);
fprintf("solution of pde is u(x,y) = %s", uval)

xspan = linspace(-5,10,100);
yspan = linspace(0,200,100);
[X,Y] = meshgrid(xspan, yspan);


u = u_func(X,Y);


figure
surf(X,Y,u)
shading interp
xlabel('x')
ylabel('y')
zlabel('u(x,y)')
title('Solution Surface: u(x,y) = x + y^{1/3}')
colorbar

hold on

for s = -6:2:6
    t = linspace(0,5,100);
    x_char = xc_func(s,t);
    y_char = yc_func(t);
    u_char = uc_func(s,t);    
    plot3(x_char, y_char, u_char, 'r--', 'LineWidth', 1.5)
end





