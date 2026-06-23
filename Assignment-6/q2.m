clc;
clear;
close all;

s0 = 40;   
k  = 40;
sigma = 0.3;

r = 0.04;   

t = 0.5;    
n = 2;        

dt = t/n;

u = exp(sigma*sqrt(dt));    
d = 1/u;  

R = exp(r*dt);

p = (R - d)/(u - d);

s = zeros(n+1,n+1);
s(1,1) = s0;

for j = 2: n+1
    for i = 1 : j
        s(i,j) = s0 * d^(i-1) * u^(j-i);
    end
end

fprintf("(a)\n\n")
% n = 2
% european call option
call = zeros(n+1,n+1);
call(:, n+1) = max(s(:,n+1) - k, 0);

for j = n:-1:1
    for i = 1:j
        call(i,j) = (p*call(i,j+1) + (1-p)*call(i+1,j+1)) / R;
    end
end

fprintf("european call option price for n = 2 is %.4f\n", call(1,1))
callprice = call(1,1);

% american call option
call = zeros(n+1,n+1);
call(:, n+1) = max(s(:,n+1) - k, 0);

for j = n:-1:1
    for i = 1:j
        call(i,j) = max((p*call(i,j+1) + (1-p)*call(i+1,j+1)) / R, max(s(i,j)-k,0));
    end
end

fprintf("american call option price for n = 2 is %.4f\n", call(1,1))
fprintf("since european and american call option prices are same this is a non-divident paying stock. so it is not optimal to exercise early.\n")

fprintf("\n(b)\n")
cp_arr = zeros(2,2);

% n = 50 
t = 0.5;    
n = 50;        

dt = t/n;

u = exp(sigma*sqrt(dt));    
d = 1/u;  

R = exp(r*dt);

p = (R - d)/(u - d);

s = zeros(n+1,n+1);
s(1,1) = s0;

for j = 2: n+1
    for i = 1 : j
        s(i,j) = s0 * d^(i-1) * u^(j-i);
    end
end

call = zeros(n+1,n+1);
call(:, n+1) = max(s(:,n+1) - k, 0);

for j = n:-1:1
    for i = 1:j
        call(i,j) = (p*call(i,j+1) + (1-p)*call(i+1,j+1)) / R;
    end
end

cp_arr(1,1) = call(1,1);

putprice = call(1,1) - s0 + k * exp(-r*t);
cp_arr(1,2) = putprice;


% n = 100
t = 0.5;    
n = 100;        

dt = t/n;

u = exp(sigma*sqrt(dt));    
d = 1/u;  

R = exp(r*dt);

p = (R - d)/(u - d);

s = zeros(n+1,n+1);
s(1,1) = s0;

for j = 2: n+1
    for i = 1 : j
        s(i,j) = s0 * d^(i-1) * u^(j-i);
    end
end

call = zeros(n+1,n+1);
call(:, n+1) = max(s(:,n+1) - k, 0);

for j = n:-1:1
    for i = 1:j
        call(i,j) = (p*call(i,j+1) + (1-p)*call(i+1,j+1)) / R;
    end
end

cp_arr(2,1) = call(1,1);

putprice = call(1,1) - s0 + k * exp(-r*t);
cp_arr(2,2) = putprice;


disp(array2table(cp_arr, "RowNames", ["n = 50", "n = 100"], "VariableNames", ["call", "put"]))
