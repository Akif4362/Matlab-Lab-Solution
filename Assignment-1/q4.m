clc; clear;
f = @(x)sin(x);
a = 0;
b = pi;
h = b - a;
rom = zeros(5);

for i = 1:5
    sum = 0;
    for j = 1:((b-a)/h)-1
        sum = sum + f(a + j*h);
    end

    rom(i,1) = (h/2)*(f(a)+f(b)+2*sum);
    h = h/2;
end

for j = 2:5
    for i = j:5
        rom(i,j) = (4^(j-1)*rom(i,j-1)-rom(i-1,j-1)) / (4^(j-1)-1);
    end 
end

rom
