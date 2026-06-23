clc; clear; close all;

p = 1000;
r = 0.0433; 
n = 12;

A = [225, 215, 250, 225, 205];
B = [220, 225, 250, 250, 210];

t = 1:5;

pv_A = 0;
for i = 1:5
    pv_A = pv_A + A(i) * (1 + r)^(-t(i));
end

fprintf("(a)\n")
fprintf("present value of investment A is %.4f\n", pv_A)

pv_B = 0;
for i = 1:5
    pv_B = pv_B + B(i) * (1 + r)^(-t(i));
end

fprintf("present value of investment B is %.4f \n\n", pv_B)

fprintf("(b)\n")

syms k
rr_A = -1000;
for i = 1:5
    rr_A = rr_A + A(i) * (1 + k)^(-t(i));
end

solA = vpasolve(rr_A == 0,k);
fprintf("rate of return of investment A is %.2f%% \n", vpa(solA(1)*100,3))

syms j
rr_B = -1000;
for i = 1:5
    rr_B = rr_B + B(i) * (1 + j)^(-t(i));
end

solB = vpasolve(rr_B == 0,j);
fprintf("rate of return of investment B is %.2f%%", vpa(solB(1)*100,3))
