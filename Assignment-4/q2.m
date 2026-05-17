clc; clear;
h = [0, 3, 6, 9, 12, 15, 18, 21, 24, 27, 30, 33];
D = [1.2, 0.91, 0.66, 0.47, 0.31, 0.19, 0.12, 0.075, 0.046, 0.029, 0.018, 0.011];

subplot(2,2,1)
plot(h, D, 'o')

subplot(2,2,2)
semilogx(h, D, 'o')

subplot(2,2,3)
semilogy(h, D, 'o')

subplot(2,2,4)
loglog(h, D, 'o')

% incomplete
