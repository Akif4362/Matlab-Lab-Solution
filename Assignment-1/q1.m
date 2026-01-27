clc; clear;
f = @(x) x - cos(x);
a = 0;
b = 1;
n = 1;
tol = 10^(-5);

while true
p = (a+b)/2;

if abs(f(p)) < tol
    break
end

if f(p)*f(a) > 0
    a = p;
else
    b = p;
end
n = n + 1;
end