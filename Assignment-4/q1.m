clc; clear;
T = [2 4 6 8 10 20 40 60 80 100 150 250 ...
    350 500 1000 1400];
k = [46 300 820 1560 2300 5000 3500 2100 ...
    1350 900 400 190 120 75 30 20];

loglog(T,k, 'bo', 'MarkerSize', 3)
xlabel("T")
ylabel("k")
title("(a) log scale")

% order 2
x = log10(T);
y = log10(k);
p2 = curvefit2(x, y); % dont use polyfit use curve fitting algorithm. i will update this code later

syms k_syms T_syms
k_eqn = solve(log10(k_syms) == p2(1)*log10(T_syms)^2 + p2(2)*log10(T_syms) + p2(3),...
   k_syms );
disp(vpa(k_eqn, 3))
kval = matlabFunction(k_eqn);

T_span = linspace(min(10.^x), max(10.^x), 1000);
p2_span = polyval(p2, T_span);

hold on
plot(T_span, kval(T_span))

% order 3
x = log10(T);
y = log10(k);
p2 = curvefit3(x, y);

syms k_syms T_syms
k_eqn = solve(log10(k_syms) == p2(1)*log10(T_syms)^3 + p2(2)*log10(T_syms)^2 + p2(3)*log10(T_syms) + p2(4),...
   k_syms );
disp(vpa(k_eqn, 3))
kval = matlabFunction(k_eqn);

T_span = linspace(min(10.^x), max(10.^x), 1000);
p2_span = polyval(p2, T_span);

plot(T_span, kval(T_span))

legend("real data", "order 2", "order 3")

% functions
function coef = curvefit2(xpoint, ypoint)
    nval = length(xpoint);
    sumx = sum(xpoint);
    sumx2 = sum(xpoint.^2);
    sumx3 = sum(xpoint.^3);
    sumx4 = sum(xpoint.^4);
    sumy = sum(ypoint);
    sumxy = sum(xpoint.*ypoint);
    sumx2y = sum((xpoint.^2).*ypoint);
    coef = [nval sumx sumx2; sumx sumx2 sumx3; sumx2 sumx3 sumx4] \ [sumy; sumxy; sumx2y];
    coef = flip(coef');
end

function coef = curvefit3(xpoint, ypoint)
    nval = length(xpoint);
    sumx = sum(xpoint);
    sumx2 = sum(xpoint.^2);
    sumx3 = sum(xpoint.^3);
    sumx4 = sum(xpoint.^4);
    sumx5 = sum(xpoint.^5);
    sumx6 = sum(xpoint.^6);
    sumy = sum(ypoint);
    sumxy = sum(xpoint.*ypoint);
    sumx2y = sum((xpoint.^2).*ypoint);
    sumx3y = sum((xpoint.^3).*ypoint);
    coef = [nval sumx sumx2 sumx3; sumx sumx2 sumx3 sumx4; sumx2 sumx3 sumx4 sumx5; sumx3 sumx4 sumx5 sumx6] \ [sumy; sumxy; sumx2y; sumx3y];
    coef = flip(coef');
end
