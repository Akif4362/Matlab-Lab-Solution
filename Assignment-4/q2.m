clc; clear;
h = [0, 3, 6, 9, 12, 15, 18, 21, 24, 27, 30, 33];
D = [1.2, 0.91, 0.66, 0.47, 0.31, 0.19, 0.12, 0.075, 0.046, 0.029, 0.018, 0.011];

subplot(2,2,1)
plot(h, D, 'o')
title("both linear scale")
xlabel("h")
ylabel("D")

subplot(2,2,2)
semilogx(h, D, 'o')
title("h log axis vs D linear axis")
xlabel("h")
ylabel("D")

subplot(2,2,3)
semilogy(h, D, 'o')
title("h linear axis vs D log axis")
xlabel("h")
ylabel("D")

subplot(2,2,4)
loglog(h, D, 'o')
title("both log axis")
xlabel("h")
ylabel("D")

% for exponential fitting let y = c1 * e^(c2 * x)
% taking log on both sides, log(y) = log(c1) + c2 * x (which is linear)
% taking polyfit with x unchanged and y as log(y), first coefficient (slope) = c2
% second coefficient (intercept) = log(c1). so, c1 = exp(coefficient) 

coef = polyfit(h, log(D), 1);
c2 = coef(1);
c1 = exp(coef(2));

fprintf("the coefficients are %f and %f", c1, c2)

figure
plot(h, c1.*exp(c2.*h))
hold on
plot(h, D, 'ro')
title("exponential fitting on linear scale with original points")
xlabel("h")
ylabel("D")
