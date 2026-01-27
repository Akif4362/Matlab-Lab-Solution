clc; clear;
fprintf("(a)\n\nForward Difference Table\n\n")

x = 1.8:0.1:2.2;
y = [10.889365 12.703199 14.778112 17.148957 19.855030];

n = length(x);
dd = zeros(n);
dd(:,1) = y;

for j = 2:n
    for i = 1: n - j +1
        dd(i,j) = dd(i+1, j-1) - dd(i, j-1);
    end
end


for i = 1:5
    row = dd(i, 1:n+1-i);
    fprintf('%.1f   ', x(i));
    fprintf('%12.6f ', row);
    fprintf('\n');
end

input = 1.95;
h = x(2) - x(1);
p = (input - x(1)) / h;
result = 0;

for j = 1:n
    term = dd(1,j);
    for i = 1:j-1
        term = term * ((p-i+1)/i);
    end
    result = result + term;
end

fprintf("\n\nTherefore,\nf(1.95) = %10.10f\n\n", result)

fprintf("(b)\n\n")
resultlag = 0;

for i = 1:n
    lagterm = y(i);
    for j = 1:n
        if i~=j
            lagterm = lagterm * ((input - x(j)) / (x(i) - x(j)));
        end 
    end
    resultlag = resultlag + lagterm;
end

fprintf("Therefore by Lagrange interpolation,\nf(1.95) = %10.10f", resultlag)


fprintf("\n\n(c)\n\n")

x_eval = 2.0;
x_idx = find(x == x_eval, 1);


y_prime_3pt_central = (y(x_idx + 1) - y(x_idx - 1)) / (2 * h);
y_prime_5pt_central = (-y(x_idx + 2) + 8*y(x_idx + 1) - 8*y(x_idx - 1) + y(x_idx - 2)) / (12 * h);


x_endpoint = 2;
x_idx_end = find(x == x_endpoint, 1);
y_prime_3pt_fwd = (-3*y(x_idx_end) + 4*y(x_idx_end + 1) - y(x_idx_end + 2)) / (2 * h);


fprintf('Three-point midpoint: y''(2) ≈ %.6f\n', y_prime_3pt_central);
fprintf('Five-point midpoint: y''(2) ≈ %.6f\n', y_prime_5pt_central);
fprintf('Three-point endpoint: y''(2) ≈ %.6f\n', y_prime_3pt_fwd);
