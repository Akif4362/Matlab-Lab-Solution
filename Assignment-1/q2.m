clc; clear;
syms x;
f = @(x) x^3 + 4*x^2 - 10;
g1 = @(x) x - x^3 - 4*x^2 + 10;
g1p = diff(g1,x);
g2 = @(x) sqrt((10/x)-4*x);
g2p = diff(g2,x);
g3 = @(x) 0.5 * sqrt(10 - x^2);
g3p = diff(g3,x);
g4 = @(x) sqrt(10/(4+x));
g4p = diff(g4,x);
g5 = @(x) x - ((x^3+4*x^2-10)/(3*x^2+8*x));
g5p = diff(g5,x);


% for (1)
fprintf("\n")
disp("(1)")
tol = 10^(-4);
p = 1.5;
n = 1;


if abs(subs(g1p,x,p)) < 1
    fprintf("%s  %s      %s\n", "it.", "Xn", "Xn-1")
    fprintf("%s  %s      %s\n", "===", "==", "====")
    while true
        p_prev = p;
        p = g1(p_prev);
        if abs(p - p_prev) < tol || n == 100
            break
        end
        fprintf("%d %f %f\n", n, p, p_prev)
        n = n + 1;
    end
else
    fprintf("solution doesnt exist\n")
end

% for (2)
fprintf("\n")
disp("(2)")
tol = 10^(-4);
p = 1.5;
n = 1;


if abs(subs(g2p,x,p)) < 1
    fprintf("%s  %s      %s\n", "it.", "Xn", "Xn-1")
    fprintf("%s  %s      %s\n", "===", "==", "====")
    while true
        p_prev = p;
        p = g2(p_prev);
        if abs(p - p_prev) < tol || n == 100
            break
        end
        fprintf("%d %f %f\n", n, p, p_prev)
        n = n + 1;
    end
else
    fprintf("solution doesnt exist\n")
end

% for (3)
fprintf("\n")
disp("(3)")
tol = 10^(-4);
p = 1.5;
n = 1;


if abs(subs(g3p,x,p)) < 1
    fprintf("%s  %s      %s\n", "it.", "Xn", "Xn-1")
    fprintf("%s  %s      %s\n", "===", "==", "====")
    while true
        p_prev = p;
        p = g3(p_prev);
        if abs(p - p_prev) < tol || n == 100
            break
        end
        fprintf("%d %f %f\n", n, p, p_prev)
        n = n + 1;
    end
else
    fprintf("solution doesnt exist\n")
end

% for (4)
fprintf("\n")
disp("(4)")
tol = 10^(-4);
p = 1.5;
n = 1;


if abs(subs(g4p,x,p)) < 1
    fprintf("%s  %s      %s\n", "it.", "Xn", "Xn-1")
    fprintf("%s  %s      %s\n", "===", "==", "====")
    while true
        p_prev = p;
        p = g4(p_prev);
        if abs(p - p_prev) < tol || n == 100
            break
        end
        fprintf("%d %f %f\n", n, p, p_prev)
        n = n + 1;
    end
else
    fprintf("solution doesnt exist\n")
end


% for (5)
fprintf("\n")
disp("(5)")
tol = 10^(-4);
p = 1.5;
n = 1;


if abs(subs(g5p,x,p)) < 1
    fprintf("%s  %s      %s\n", "it.", "Xn", "Xn-1")
    fprintf("%s  %s      %s\n", "===", "==", "====")
    while true
        p_prev = p;
        p = g5(p_prev);
        if abs(p - p_prev) < tol || n == 100
            break
        end
        fprintf("%d %f %f\n", n, p, p_prev)
        n = n + 1;
    end
else
    fprintf("solution doesnt exist\n")
end