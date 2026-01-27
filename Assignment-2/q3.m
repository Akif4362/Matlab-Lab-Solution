clc; clear;
a = 23621; b = 16376; c = 23;
d = gcd(a,b);
syms n x y

if mod(c,d) == 0
    disp("solution of diphantine equation exists")
    % we find particular solution with extended euclidean algorithm
    [~, x_part, y_part] = extended_euclidean(a, b);
    x_general = x == x_part + (b/d)*n
    y_general = y == y_part + (a/d)*n

    % using matlab builtin solve
    syms x1 y1 integer           
    eqn = a*x1 + b*y1 == c;      
    [x_sol, y_sol] = solve(eqn,[x1 y1])  
 
else
    disp("solution doesnt exist")
end



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

