clc;clear;
A = [4 3 0; 3 4 -1; 0 -1 4];
b = [24 30 -24];
x_old = ones(1,length(b));
x = zeros(1,length(b));
n = 1;
tol = 10^(-5);

% jacobi
while true
for i = 1:length(b)
    sum = 0;
    for j = 1:length(b)
        if j~=i
            sum = sum + A(i,j) * x_old(j);
        end
    end
    x(i) = (1/A(i,i)) * (b(i) - sum);
end

error = max(abs(x-x_old));
x_old = x;

fprintf("%d   %f   %f   %f \n", n,x)
if error < tol
    break
end 

n = n+1;

end

% gauss
fprintf("\nGauss\n")

x_old = ones(1,length(b));
x = zeros(1,length(b));
n = 1;
tol = 10^(-5);

while true
for i = 1:length(b)
    sum = 0;
    for j = 1:length(b)
        if j>i
            sum = sum + A(i,j) * x_old(j);
        elseif j<i 
            sum = sum + A(i,j) * x(j);
        end
    end
    x(i) = (1/A(i,i)) * (b(i) - sum);
end

error = max(abs(x-x_old));
x_old = x;

fprintf("%d   %f   %f   %f \n", n,x)
if error < tol
    break
end 

n = n+1;

end