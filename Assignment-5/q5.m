clc; clear;
cost = [3 5 7 6; 
        2 5 8 2; 
        3 6 9 2];
supply = [50; 75; 25];
demand = [20 20 50 60];
[m, n] = size(cost);

% north west method
X = zeros(m, n);
s = supply; d = demand;
i = 1; j = 1;
while i <= m && j <= n
    val = min(s(i), d(j));
    X(i,j) = val;
    s(i) = s(i) - val;
    d(j) = d(j) - val;
    if s(i) == 0, i = i + 1; else, j = j + 1; end
end

disp("Allocation by north-west method = ")
disp(X)
disp("total cost = ")
disp(sum(sum(X .* cost)))

it = 1;

while true

if nnz(X) < m + n - 1
    break;
end

fprintf("iteration %d\n", it)

u = NaN(m, 1); v = NaN(n, 1);
u(1) = 0; 

for k = 1:(m+n)
    for r = 1:m
        for c = 1:n
            if X(r,c) > 0 
                if ~isnan(u(r)) && isnan(v(c))
                    v(c) = cost(r,c) - u(r);
                elseif isnan(u(r)) && ~isnan(v(c))
                    u(r) = cost(r,c) - v(c);
                end
            end
        end
    end
end


Delta = zeros(m, n);
for r = 1:m
    for c = 1:n
        if X(r,c) == 0
            Delta(r,c) = cost(r,c) - (u(r) + v(c)); % unallocated cells
        else
            Delta(r,c) = 0; % allocated cells
        end
    end
end


[~, idx] = min(Delta(:));
[r,c] = ind2sub(size(Delta), idx);

path_coords = [r, c]; 


for nc = (c+1):n
    if X(r, nc) > 0
        for nr = (r-1):-1:1
            if X(nr, nc) > 0
                if X(nr, c) > 0
                    path_coords = [r, c;    
                                   r, nc;   
                                   nr, nc;  
                                   nr, c];  
                    break;
                end
            end
        end
    end
end

modi = [];
for i = 1 : length(path_coords(:,1))
modi(end+1) = X(path_coords(i,1), path_coords(i,2));
end

theta = min(modi(2:2:end));

for i = 1: length(modi)
    modi(i) = modi(i) + (-1)^(i+1) * theta;
end

for i = 1: length(modi)
    X(path_coords(i,1), path_coords(i,2)) = modi(i);
end

disp("Allocation = ")
disp(X)
disp("total cost = ")
disp(sum(sum(X .* cost)))

it = it + 1;
end

