clc; clear;

subplot(2,2,1)
[X, Y] = meshgrid(linspace(-1.5, 1.5, 200));
contourf(X, Y, double(X.^2 + Y.^2 <=1), [1 1], "FaceColor", 'c')
hold on;
plot([-0.5 0.5], [-0.5 0.5], 'r-o', "MarkerFaceColor", "r")
axis equal

subplot(2,2,2)
[X, Y] = meshgrid(linspace(-1.5, 1.5, 200));
surf(X, Y, (2 - 2*X + Y) / 3, "FaceColor" ,'c')
hold on;
plot([-1 0], [0 -1.5], 'r-o', "MarkerFaceColor", "r")
axis equal

subplot(2,2,3)
[X, Y] = meshgrid(linspace(0, 5, 200));
contourf(X, Y, double(X.*Y >=1), [1 1], "FaceColor", 'c')
hold on;
plot([2 4], [4 2], 'r-o', "MarkerFaceColor", "r")
axis equal

subplot(2,2,4)
[X, Y] = meshgrid(linspace(-1.5, 1.5, 200));
contourf(X, Y, double(Y<= X.^2), [1 1], "FaceColor", 'c')
hold on;
plot([-1 1], [0.5 0.5], 'r-o', "MarkerFaceColor", "r")
axis equal
