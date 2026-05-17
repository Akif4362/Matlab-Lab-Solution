clc; clear;
R = 8.31;
M = 0.028;
pv = @(v,T) 4.*pi.*(M/(2.*pi.*R.*T)).^(3/2) .* v.^2 .* exp(-M.*v.^2 / (2.*R.*T));

syms pv_syms T_syms v_syms M_syms R_syms positive
pv_syms = 4*pi*(M_syms/(2*pi*R_syms*T_syms))^(3/2) * v_syms^2 * exp(-M_syms*v_syms^2 / (2*R_syms*T_syms));
vmax = solve(diff(pv_syms, v_syms)==0);
disp("vp = ")
disp(vmax)

vmax = matlabFunction(vmax);

v_span = linspace(0, 3000, 1000);
T = [200, 400, 800, 1200];

for i = 1 : length(T)
    hold on;
    plot(v_span, pv(v_span, T(i))) % curve
    plot(vmax(M,R,T(i)), pv(vmax(M,R,T(i)), T(i)), 'ro', 'HandleVisibility','off') % peaks
end

xlim([0 3000])
ylim([0 2.5e-3])
xlabel('v')
ylabel('p(v)')
title('maxwell speed distribution')
legend('T = 200','T = 400','T = 800', 'T = 1200')

% trend line
figure;
hold on
vp_of_T = vmax(M,R,T);
T_span = linspace(T(1), T(end), 1000);

p = polyfit(T, vp_of_T, 3);
trendline_yval = polyval(p,T_span); 
plot(T_span, trendline_yval, 'k--')
plot(T, vp_of_T, 'bo', 'MarkerFaceColor', 'b')
xlabel('T')
ylabel('vp')
title('trend line')




