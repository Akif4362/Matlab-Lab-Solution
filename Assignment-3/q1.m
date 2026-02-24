clc; clear;
u0 = 250;
theta = 65;
wind = -30;
x0 = 3000;
g = 9.8;

ux = u0 * cosd(theta);
uz = u0 * sind(theta);
tof = (2 * uz) / g;

t = [0:0.01:tof];
x = x0 + ux * t;
y = 0 * t;
z = uz * t - (1/2) * g * t.^2;
plot3(x,y,z);

hold on; 
xn = x0 + ux * t;
yn = wind * t;
zn = uz * t - (1/2) * g * t.^2;
plot3(xn,yn,zn);
legend("No Wind", "Wind")
grid("on")