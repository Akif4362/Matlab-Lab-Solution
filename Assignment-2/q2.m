clc; clear;

% euclid algorithm for gcd
function g = gcd_euclid(a,b)

if b == 0
    g = a;
else
    g = gcd_euclid(b, mod(a,b));
end

end

% extended euclid algorithm for linear combination
function [g, x, y] = extended_euclidean(a, b)
    
    if b == 0
        g = a;
        x = 1;
        y = 0;
    else
        [g, x1, y1] = extended_euclidean(b, mod(a, b));
        x = y1;
        y = x1 - floor(a / b) * y1;
    end
end