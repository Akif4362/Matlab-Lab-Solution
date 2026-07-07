clc; clear;
% (a)
fprintf("(a)\n")
syms z
fz = (z+1) / (z * (z-2) * (z+1i));
num = z+1;
dem = z * (z-2) * (z+1i);
singu = solve(dem == 0,z);
fprintf("the singularities are \n")
disp(singu)
fprintf("here all the singularities are simple poles \n")

% (b)
fprintf("\n(b)\n")
disp("plotting")

[X, Y] = meshgrid(linspace(-3, 3, 500));
Z = X + 1i*Y;
fZ = (Z+1)./(Z.*(Z-2).*(Z+1i));

contour(X, Y, abs(fZ), 400);
xline(0, "HandleVisibility","off")
yline(0, "HandleVisibility","off")
hold on

plot([0 2 0], [0 0 -1], 'ro', "MarkerFaceColor", "r");

text(0.1, 0.3, "z = 0")
text(2.1, 0.3, "z = 2")
text(0, -1.3, "z = -i")

title("Contour Integration")
xlabel("real(z)")
ylabel("imag(z)")
legend("contour", "poles")

% (c)
fprintf("\n(c)\n")
res = sym(zeros(1, length(singu)));

for i = 1 : length(singu)
    res(i) = subs((z - singu(i))*fz, z, singu(i));
end

for i = 1 : length(singu)
    fprintf("residue at z = %s is %s \n", singu(i), res(i))
end

% (d)
fprintf("\n(d)\n")
inside = abs(double(singu)) <= 2;
I1 = 2*pi*1i*sum(res(inside));
fprintf("contour integral for |z| = 2 is %s \n", I1)

inside = abs(double(singu)) <= 1.5;
I2 = 2*pi*1i*sum(res(inside));
fprintf("contour integral for |z| = 1.5 is %s \n", I2)

figure
plot([0 2 0], [0 0 -1], 'ro', "MarkerFaceColor", "r");

hold on
xline(0, "HandleVisibility","off")
yline(0, "HandleVisibility","off")
xlim([-3 3])
ylim([-3 3])

text(0.1, 0.3, "z = 0")
text(2.1, 0.3, "z = 2")
text(0, -1.3, "z = -i")

theta = linspace(0, 2*pi, 100);
plot(2*cos(theta), 2*sin(theta), "b");
plot(1.5*cos(theta), 1.5*sin(theta), "m");

title("Contour Integartion")
xlabel("real(z)")
ylabel("imag(z)")
legend("poles", "|z| = 2", "|z| = 1.5")
