clc; clear;

A = [4 7; 5 4]; 
b = [90; 120];

line1 = @(x) (b(1) - A(1,1) * x) / A(1,2);
line2 = @(x) (b(2) - A(2,1) * x) / A(2,2);
z = @(x, y) 5*x + 6*y;

hold on 


xlim([0 30])
ylim([0 40])

intersection = (A \ b)';
xintercepts = (b ./ A(:,1))';
yintercepts = (b ./ A(:,2))';


xpoint = [];

if A(1,1)*xintercepts(1) >= b(1) & A(2,1)*xintercepts(1) >= b(2)
    xpoint(end+1) = xintercepts(1);
elseif A(1,1)*xintercepts(2) >= b(1) & A(2,1)*xintercepts(2) >= b(2)
    xpoint(end+1) = xintercepts(2);
end

ypoint = [];

if A(1,2)*yintercepts(1) >= b(1) & A(2,2)*yintercepts(1) >= b(2)
    ypoint(end+1) = yintercepts(1);
elseif A(1,2)*yintercepts(2) >= b(1) & A(2,2)*yintercepts(2) >= b(2)
    ypoint(end+1) = yintercepts(2);
end

points = [[xpoint, 0]; [0, ypoint]];
pointsfill = [[xpoint, 0]; [0, ypoint]; [0, 40]; [30, 40]; [30, 0]];

fill(pointsfill(:,1), pointsfill(:,2), 'b', "FaceAlpha",0.2)
fplot(line1)
fplot(line2)
plot(points(:,1), points(:,2), 'o', "MarkerSize", 8, "MarkerFaceColor","r")



legend("valid region", "vitamin x constraint", "mineral y constraint", "point")

fprintf("%7s %8s", ["Point", "Z"])
fprintf("%7s %8s", ["=====", "="])
for i = 1: 2
fprintf("(%3i,%3i)    %3i\n", points(i,1), points(i,2), z(points(i,1), points(i,2)));
end

