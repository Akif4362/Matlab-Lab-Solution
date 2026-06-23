clc;clear;close all;

s0 = 100;          
mu = 0.16;        
sigma = 0.30;      
t = 2/12;         
k = 95;           
n = 60;           
dt = t/n;          

path_N = [50, 100, 200, 300, 500, 1000, 5000, 10000];
approxval = zeros(1, length(path_N));

% monte carlo simulation
for z = 1:length(path_N)

s = zeros(n+1, path_N(z));
s(1,:) = s0;

for j = 1:path_N(z)
    for i = 1:n
        eps = randn;  
        s(i+1,j) = s(i,j) + s(i,j)*mu*dt + sigma*s(i,j)*eps*sqrt(dt);
    end
end

call = max(s(end,:) - k, 0);
pv_call = exp(-mu*t) * mean(call);

approxval(z) = pv_call;
end

% exact value
d1 = (log(s0/k) + (mu + 0.5*sigma^2)*t) / (sigma*sqrt(t));
d2 = d1 - sigma*sqrt(t);
exactval = s0 * normcdf(d1) - k * exp(-mu*t) * normcdf(d2);

arr = [path_N' approxval' repmat(exactval,length(path_N),1) abs(approxval-exactval)'];
disp(array2table(arr, "VariableNames", ["N", "monte carlo simulation", "exact value", "abs error"]))

plot(path_N, approxval, '-o', 'MarkerFaceColor', 'b', 'LineWidth', 1.5)
xlabel("N")
ylabel("Call Option Price")
title("Monte Carlo convergence to exact value")
hold on 
yline(exactval, 'r--', 'Exact Value', 'LineWidth', 1.5)
