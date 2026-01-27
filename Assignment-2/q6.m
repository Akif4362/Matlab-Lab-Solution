clc; clear;
data = readmatrix("data.xlsx");
A = data(:, 1:7);
b = data(:, 8);
m = 11;

[g, delinv, ~] = gcd(int64(det(A)), m);

if g == 1

delinv = mod(delinv, m); % making del inverse positive
Ainv = delinv * int64(adjoint(A));
Ainv = mod(Ainv, m);
x = double(Ainv)*double(b); % solution
x = mod(x, m); % making the solution positive
x = int32(x);

fprintf("x ≡ [%d %d %d %d %d %d %d](mod %d)", x, m)

else
    disp("solution doesnt exist")
end