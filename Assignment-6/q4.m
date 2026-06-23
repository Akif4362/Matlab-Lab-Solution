clc;clear;close all;

s0 = 100;          
mu = 0.16;        
sigma = 0.30;      
t = 2/12;         
k = 95;           
n = 60;           
dt = t/n;          
m = 10;            
s = zeros(n+1, m);
s(1,:) = s0;

for j = 1:m
    for i = 1:n
        eps = randn;  
        s(i+1,j) = s(i,j) + s(i,j)*mu*dt + sigma*s(i,j)*eps*sqrt(dt);
    end
end

plot(0:n, s)
xlabel("Time (days)")
ylabel("Stock Price")
title("Monte Carlo simulation")

call = max(s(end,:) - k, 0);
pv_call = exp(-mu*t) * mean(call);

fprintf("present value of call option is %.4f \n", pv_call)
