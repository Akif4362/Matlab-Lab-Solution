clc; clear;
h = 0.1;
a = 0;
b = 25;
t = a:h:b;

bg = 1.1; bl = 0.00025; dg = 0.0005; 
dl = 0.7;

% y = [NL; NG]
f = @(t, y) [bl*y(2)*y(1) - dl*y(1);
    bg*y(2) - dg*y(1)*y(2)];

% modified euler
y_mode = zeros(2, length(t));
y_mode(:, 1) = [500; 3000];

for i = 1: length(t)-1
    ynplus1p = y_mode(:,i) + h * f(t(i), y_mode(:,i));
    fnplus1p = f(t(i+1), ynplus1p);
    y_mode(:, i+1) = y_mode(:,i) + (h/2) * (f(t(i), y_mode(:,i)) + fnplus1p);
end

% range kutta order 4
y_range = zeros(2, length(t));
y_range(:, 1) = [500; 3000];

for i = 1: length(t)-1
    k1 = f(t(i), y_range(:,i));
    k2 = f(t(i+1)+(h/2), y_range(:,i) + (h/2) * k1);
    k3 = f(t(i+1)+(h/2), y_range(:,i) + (h/2) * k2);
    k4 = f(t(i+1)+h, y_range(:,i) + h * k3);
    y_range(:, i+1) = y_range(:,i) + (h/6) * (k1 + 2*k2 + 2*k3 + k4);
end

% adam bashford multon pc order 4
y_abm = zeros(2, length(t));
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

[t_ode45, y_ode45] = ode45(f, t , [500; 3000]);

% taylors method
syms L(time) G(time)
nl1 = bl*G*L - dl*L;
ng1 = bg*G - dg*L*G;

nl2 = diff(nl1,time); 
ng2 = diff(ng1,time);

nl3 = diff(nl2,time); 
ng3 = diff(ng2,time);

nl4 = diff(nl2,time); 
ng4 = diff(ng2,time);


vars = [diff(L, time) diff(G, time)];
sub_val = [nl1 ng1];

for i = 1 : 3
    nl2 = subs(nl2, vars, sub_val); 
    ng2 = subs(ng2, vars, sub_val);

    nl3 = subs(nl3, vars, sub_val); 
    ng3 = subs(ng3, vars, sub_val);

    nl4 = subs(nl4, vars, sub_val); 
    ng4 = subs(ng4, vars, sub_val);
end

syms L_num G_num 
vars_final = [L(time), G(time)];
subs_final = [L_num, G_num];

nl1_f = matlabFunction(subs(nl1, vars_final, subs_final), "Vars", [time, L_num, G_num]);
nl2_f = matlabFunction(subs(nl2, vars_final, subs_final), "Vars", [time, L_num, G_num]);
nl3_f = matlabFunction(subs(nl3, vars_final, subs_final), "Vars", [time, L_num, G_num]);
nl4_f = matlabFunction(subs(nl4, vars_final, subs_final), "Vars", [time, L_num, G_num]);

ng1_f = matlabFunction(subs(ng1, vars_final, subs_final), "Vars", [time, L_num, G_num]);
ng2_f = matlabFunction(subs(ng2, vars_final, subs_final), "Vars", [time, L_num, G_num]);
ng3_f = matlabFunction(subs(ng3, vars_final, subs_final), "Vars", [time, L_num, G_num]);
ng4_f = matlabFunction(subs(ng4, vars_final, subs_final), "Vars", [time, L_num, G_num]);

y_taylor_L = zeros(1, length(t));
y_taylor_G = zeros(1, length(t));
y_taylor_L(1) = 500; 
y_taylor_G(1) = 3000;

for i = 1: length(t) - 1
    L_curr = y_taylor_L(i);
    G_curr = y_taylor_G(i);
    
    y_taylor_L(i+1) = L_curr + h*nl1_f(0,L_curr, G_curr) + ...
              (h^2/2)*nl2_f(0,L_curr, G_curr) + ...
              (h^3/6)*nl3_f(0,L_curr, G_curr) + ...
              (h^4/24)*nl4_f(0,L_curr, G_curr);
          
    
    y_taylor_G(i+1) = G_curr + h*ng1_f(0,L_curr, G_curr) + ...
              (h^2/2)*ng2_f(0,L_curr, G_curr) + ...
              (h^3/6)*ng3_f(0,L_curr, G_curr) + ...
              (h^4/24)*ng4_f(0,L_curr, G_curr);
end

y_taylor = [y_taylor_L; y_taylor_G];

results = [t' y_mode(1,:)' y_taylor(1,:)' y_range(1,:)' y_abm(1,:)' y_ode45(:,1)];
array2table(results, "VariableNames", ["t", "euler", "taylor", "rangekutta", "abm", "ode45"])

results = [t' y_mode(2,:)' y_taylor(2,:)' y_range(2,:)' y_abm(2,:)' y_ode45(:,2)];
array2table(results, "VariableNames", ["t", "euler", "taylor", "rangekutta", "abm", "ode45"])

plot(t, y_mode, 'r*')
hold on
plot(t, y_taylor, 'gx')
plot(t, y_range, 'bdiamond:')
plot(t, y_abm, 'csquare')
plot(t, y_ode45', 'mv')
