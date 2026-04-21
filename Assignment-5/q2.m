clc; clear;

A = [200 100; 25 50]; 
b = [5000; 1000];

line1 = @(x) (b(1) - A(1,1) * x) / A(1,2);
line2 = @(x) (b(2) - A(2,1) * x) / A(2,2);
z = @(x, y) x + y;

fplot(line1)
hold on 
fplot(line2)

xlim([0 50])
ylim([0 60])

intersection = (A \ b)';
xintercepts = (b ./ A(:,1))';
yintercepts = (b ./ A(:,2))';

xpoint = [];

if A(1,1)*xintercepts(1) <= b(1) & A(2,1)*xintercepts(1) <= b(2)
    xpoint(end+1) = xintercepts(1);
elseif A(1,1)*xintercepts(2) <= b(1) & A(2,1)*xintercepts(2) <= b(2)
    xpoint(end+1) = xintercepts(2);
end

ypoint = [];

if A(1,2)*yintercepts(1) <= b(1) & A(2,2)*yintercepts(1) <= b(2)
    ypoint(end+1) = yintercepts(1);
elseif A(1,2)*yintercepts(2) <= b(1) & A(2,2)*yintercepts(2) <= b(2)
    ypoint(end+1) = yintercepts(2);
end

points = [[0,0]; [xpoint, 0]; [intersection(1), intersection(2)]; [0, ypoint]];

fill(points(:,1), points(:,2), 'b', "FaceAlpha",0.2)
plot(points(:,1), points(:,2), 'o', "MarkerSize", 8, "MarkerFaceColor","r")

legend("flour constraint", "fat constraint", "feasible solution", "valid region")

fprintf("%7s %8s", ["Point", "Z"])
fprintf("%7s %8s", ["=====", "="])
for i = 1: 4
fprintf("(%3i,%3i)    %3i\n", points(i,1), points(i,2), z(points(i,1), points(i,2)));
end
