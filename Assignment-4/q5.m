clc; clear; 

omega = 7.29e-5;        
la = deg2rad(39.9611); 
g = 9.81;               
L = 10;                 
h = 0.1;                
t = 0:h:20000;     

Y0 = [1; 0; 0; 0];

C = 2 * omega * sin(la);
K = g / L;

% y(1)=x, y(2)=u, y(3)=y, y(4)=v
f = @(t, Y) [Y(2); 
             C*Y(4) - K*Y(1); 
             Y(4); 
             -C*Y(2) - K*Y(3)];

% modified euler
y_mode = zeros(4, length(t));
y_mode(:, 1) = Y0;

for i = 1: length(t)-1
    ynplus1p = y_mode(:,i) + h * f(t(i), y_mode(:,i));
    fnplus1p = f(t(i+1), ynplus1p);
    y_mode(:, i+1) = y_mode(:,i) + (h/2) * (f(t(i), y_mode(:,i)) + fnplus1p);
end

% range kutta order 4
y_range = zeros(4, length(t));
y_range(:, 1) = Y0;

for i = 1: length(t)-1
    k1 = f(t(i), y_range(:,i));
    k2 = f(t(i+1)+(h/2), y_range(:,i) + (h/2) * k1);
    k3 = f(t(i+1)+(h/2), y_range(:,i) + (h/2) * k2);
    k4 = f(t(i+1)+h, y_range(:,i) + h * k3);
    y_range(:, i+1) = y_range(:,i) + (h/6) * (k1 + 2*k2 + 2*k3 + k4);
end

% adam bashford multon pc order 4
y_abm = zeros(4, length(t));
y_abm(:, 1:4) = y_range(:, 1:4);

for i = 4: length(t)-1
    fn = f(t(i), y_abm(:,i));
    fnm1 = f(t(i-1), y_abm(:,i-1));
    fnm2 = f(t(i-2), y_abm(:,i-2));
    fnm3 = f(t(i-3), y_abm(:,i-3));

    ynp1p = y_abm(:, i) + (h/24) * (55*fn - 59*fnm1 + 37*fnm2 - 9*fnm3);
    fnp1p = f(t(i+1), ynp1p);
    y_abm(:, i+1) = y_abm(:, i) + (h/24) * (9*fnp1p + 19*fn - 5*fnm1 + fnm2);
end

% ode45
[t_ode45, y_ode45] = ode45(f, t, Y0);
y_ode45 = y_ode45';

% taylors method
syms y1(time) y2(time) y3(time) y4(time)
y1p = y2;
y2p = C*y4 - K*y1;
y3p = y4;
y4p = -C*y2 - K*y3;

y1pp = diff(y1p,time); 
y2pp = diff(y2p,time);
y3pp = diff(y3p,time);
y4pp = diff(y4p,time);

y1ppp = diff(y1pp,time); 
y2ppp = diff(y2pp,time);
y3ppp = diff(y3pp,time);
y4ppp = diff(y4pp,time);

y1pppp = diff(y1ppp,time); 
y2pppp = diff(y2ppp,time);
y3pppp = diff(y3ppp,time);
y4pppp = diff(y4ppp,time);

vars = [diff(y1, time) diff(y2, time) diff(y3, time) diff(y4, time)];
sub_val = [y1p y2p y3p y4p];

for i = 1 : 3
    y1pp = subs(y1pp, vars, sub_val); 
    y2pp = subs(y2pp, vars, sub_val);
    y3pp = subs(y3pp, vars, sub_val);
    y4pp = subs(y4pp, vars, sub_val);

    y1ppp = subs(y1ppp, vars, sub_val); 
    y2ppp = subs(y2ppp, vars, sub_val);
    y3ppp = subs(y3ppp, vars, sub_val);
    y4ppp = subs(y4ppp, vars, sub_val);

    y1pppp = subs(y1pppp, vars, sub_val); 
    y2pppp = subs(y2pppp, vars, sub_val);
    y3pppp = subs(y3pppp, vars, sub_val);
    y4pppp = subs(y4pppp, vars, sub_val);
end

syms y1_num y2_num y3_num y4_num 
vars_final = [y1(time), y2(time), y3(time), y4(time)];
subs_final = [y1_num, y2_num, y3_num, y4_num];

y1p_f = matlabFunction(subs(y1p, vars_final, subs_final), "Vars", [time, y1_num, y2_num, y3_num, y4_num]);
y1pp_f = matlabFunction(subs(y1pp, vars_final, subs_final), "Vars", [time, y1_num, y2_num, y3_num, y4_num]);
y1ppp_f = matlabFunction(subs(y1ppp, vars_final, subs_final), "Vars", [time, y1_num, y2_num, y3_num, y4_num]);
y1pppp_f = matlabFunction(subs(y1pppp, vars_final, subs_final), "Vars", [time, y1_num, y2_num, y3_num, y4_num]);

y2p_f = matlabFunction(subs(y2p, vars_final, subs_final), "Vars", [time, y1_num, y2_num, y3_num, y4_num]);
y2pp_f = matlabFunction(subs(y2pp, vars_final, subs_final), "Vars", [time, y1_num, y2_num, y3_num, y4_num]);
y2ppp_f = matlabFunction(subs(y2ppp, vars_final, subs_final), "Vars", [time, y1_num, y2_num, y3_num, y4_num]);
y2pppp_f = matlabFunction(subs(y2pppp, vars_final, subs_final), "Vars", [time, y1_num, y2_num, y3_num, y4_num]);

y3p_f = matlabFunction(subs(y3p, vars_final, subs_final), "Vars", [time, y1_num, y2_num, y3_num, y4_num]);
y3pp_f = matlabFunction(subs(y3pp, vars_final, subs_final), "Vars", [time, y1_num, y2_num, y3_num, y4_num]);
y3ppp_f = matlabFunction(subs(y3ppp, vars_final, subs_final), "Vars", [time, y1_num, y2_num, y3_num, y4_num]);
y3pppp_f = matlabFunction(subs(y3pppp, vars_final, subs_final), "Vars", [time, y1_num, y2_num, y3_num, y4_num]);

y4p_f = matlabFunction(subs(y4p, vars_final, subs_final), "Vars", [time, y1_num, y2_num, y3_num, y4_num]);
y4pp_f = matlabFunction(subs(y4pp, vars_final, subs_final), "Vars", [time, y1_num, y2_num, y3_num, y4_num]);
y4ppp_f = matlabFunction(subs(y4ppp, vars_final, subs_final), "Vars", [time, y1_num, y2_num, y3_num, y4_num]);
y4pppp_f = matlabFunction(subs(y4pppp, vars_final, subs_final), "Vars", [time, y1_num, y2_num, y3_num, y4_num]);

y1_taylor = zeros(1, length(t));
y2_taylor = zeros(1, length(t));
y3_taylor = zeros(1, length(t));
y4_taylor = zeros(1, length(t));

y1_taylor(1) = 1;
y2_taylor(1) = 0;
y3_taylor(1) = 0;
y4_taylor(1) = 0;

for i = 1: length(t) - 1
    y1_curr = y1_taylor(i);
    y2_curr = y2_taylor(i);
    y3_curr = y3_taylor(i);
    y4_curr = y4_taylor(i);
    
    y1_taylor(i+1) = y1_curr + h*y1p_f(0,y1_curr, y2_curr, y3_curr, y4_curr) + ...
              (h^2/2)*y1pp_f(0,y1_curr, y2_curr, y3_curr, y4_curr) + ...
              (h^3/6)*y1ppp_f(0,y1_curr, y2_curr, y3_curr, y4_curr) + ...
              (h^4/24)*y1pppp_f(0,y1_curr, y2_curr, y3_curr, y4_curr);
          
    
    y2_taylor(i+1) = y2_curr + h*y2p_f(0,y1_curr, y2_curr, y3_curr, y4_curr) + ...
              (h^2/2)*y2pp_f(0,y1_curr, y2_curr, y3_curr, y4_curr) + ...
              (h^3/6)*y2ppp_f(0,y1_curr, y2_curr, y3_curr, y4_curr) + ...
              (h^4/24)*y2pppp_f(0,y1_curr, y2_curr, y3_curr, y4_curr);

    y3_taylor(i+1) = y3_curr + h*y3p_f(0,y1_curr, y2_curr, y3_curr, y4_curr) + ...
              (h^2/2)*y3pp_f(0,y1_curr, y2_curr, y3_curr, y4_curr) + ...
              (h^3/6)*y3ppp_f(0,y1_curr, y2_curr, y3_curr, y4_curr) + ...
              (h^4/24)*y3pppp_f(0,y1_curr, y2_curr, y3_curr, y4_curr);

    y4_taylor(i+1) = y4_curr + h*y4p_f(0,y1_curr, y2_curr, y3_curr, y4_curr) + ...
              (h^2/2)*y4pp_f(0,y1_curr, y2_curr, y3_curr, y4_curr) + ...
              (h^3/6)*y4ppp_f(0,y1_curr, y2_curr, y3_curr, y4_curr) + ...
              (h^4/24)*y4pppp_f(0,y1_curr, y2_curr, y3_curr, y4_curr);
end

y_taylor = [y1_taylor; y2_taylor; y3_taylor; y4_taylor];

angles = rad2deg(atan2(y_mode(3,:), y_mode(1,:)));
idx = find(abs(angles) >= 45, 1);
fprintf('Euler method time to rotate 45 degrees: %.8f seconds\n', t(idx));

angles = rad2deg(atan2(y_range(3,:), y_range(1,:)));
idx = find(abs(angles) >= 45, 1);
fprintf('Range Kutta method time to rotate 45 degrees: %.8f seconds\n', t(idx));

angles = rad2deg(atan2(y_taylor(3,:), y_taylor(1,:)));
idx = find(abs(angles) >= 45, 1);
fprintf('Taylor method time to rotate 45 degrees: %.8f seconds\n', t(idx));

angles = rad2deg(atan2(y_abm(3,:), y_abm(1,:)));
idx = find(abs(angles) >= 45, 1);
fprintf('ABM method time to rotate 45 degrees: %.8f seconds\n', t(idx));

angles = rad2deg(atan2(y_ode45(3,:), y_ode45(1,:)));
idx = find(abs(angles) >= 45, 1);
fprintf('ode45 method time to rotate 45 degrees: %.8f seconds\n', t(idx));

plot(y_taylor(1,:), y_taylor(3,:));




