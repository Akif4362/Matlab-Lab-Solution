% linear congruence
clc;
a = 9;
b = 12;
m = 15;
incon_sol = [];

d = gcd(a,m);

if mod(b,d) == 0
    fprintf("solution exists. there are %i incongruent solutions\n", d)

    syms x y integer                
    eqn = a*x - m*y == b;      % for diophantine eq ax - my = b)
    [x_sol, y_sol] = solve(eqn,[x y]);

    for i = 0:d-1
        x_incon = x_sol + (m/d)*i;
        incon_sol(end+1) = x_incon; 
    end

    fprintf("incongruent solutions are %i %i %i", incon_sol)
else
    disp("solution doesnt exist")
    end



