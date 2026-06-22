clc;
clear;
close all;

s0 = 40;   
k  = 42;     

u = 1.10;    
d = 0.90;  

r = 0.12;   

t = 0.5;    
n = 3;        

dt = t/n;

R = exp(r*dt);

p = (R - d)/(u - d);

s = zeros(n+1,n+1);
s(1,1) = s0;

for j = 2: n+1
    for i = 1 : j
        s(i,j) = s0 * d^(i-1) * u^(j-i);
    end
end

% (a) european call option
fprintf("(a)\n")
call = zeros(n+1,n+1);
call(:, n+1) = max(s(:,n+1) - k, 0);

for j = n:-1:1
    for i = 1:j
        call(i,j) = (p*call(i,j+1) + (1-p)*call(i+1,j+1)) / R;
    end
end

fprintf("european call option price is %.4f\n", call(1,1))
callprice = call(1,1);

% (a) american call option
call = zeros(n+1,n+1);
call(:, n+1) = max(s(:,n+1) - k, 0);

for j = n:-1:1
    for i = 1:j
        call(i,j) = max((p*call(i,j+1) + (1-p)*call(i+1,j+1)) / R, max(s(i,j)-k,0));
    end
end

fprintf("american call option price is %.4f\n", call(1,1))

% (b) european put option
fprintf("\n(b)\n")
put = zeros(n+1,n+1);
put(:, n+1) = max(k - s(:,n+1), 0);

for j = n:-1:1
    for i = 1:j
        put(i,j) = (p*put(i,j+1) + (1-p)*put(i+1,j+1)) / R;
    end
end

fprintf("european call option price is %.4f\n", put(1,1))
putprice = put(1,1);

% (c) put-call parity
fprintf("\n(c)\n")
if callprice - putprice - s0 + k*exp(-r*t) == 0
    disp("put-call parity is satisfied")
else
    disp("put-call parity is not satisfied")
end
