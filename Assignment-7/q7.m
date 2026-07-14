clc; clear;
syms t v(t)

fprintf("(a)\n")

vt = dsolve(diff(v,t) == -(0.0055*v^2 + 1), v(0) == 450*1000/3600);
fprintf("v(t) = %s \n", vt)

vt_f = matlabFunction(vt);
t_final = vpasolve(vt==0,t);

tspan = linspace(0, t_final, 50);
plot(tspan, vt_f(tspan))
xlabel('time (s)')
ylabel('velocity (m/s)')
title('velocity vs time')

fprintf("\n(b)\n")
x = zeros(size(tspan));

for i = 2:length(tspan)

    sum = 0;

    for j = 1:i-1
        h = tspan(j+1) - tspan(j);
        sum = sum + (vt_f(tspan(j)) + vt_f(tspan(j+1)))*h/2;
    end

    x(i) = sum;

end

figure
plot(tspan,x)
grid on
xlabel('time (s)')
ylabel('distance (m)')
title('distance vs time')

fprintf('Stopping distance = %.4f m\n',x(end))
