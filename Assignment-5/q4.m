clc; clear;
cost = [3 5 7 6; 
        2 5 8 2; 
        3 6 9 2];
supply = [50 75 25];
demand = [20 20 50 60];

% i) north-west corner method
sup_nw = supply; dem_nw = demand;
X_nw = zeros(size(cost));
i = 1; j = 1;
while i <= length(sup_nw) && j <= length(dem_nw)
    val = min(sup_nw(i), dem_nw(j));
    X_nw(i,j) = val;
    sup_nw(i) = sup_nw(i) - val;
    dem_nw(j) = dem_nw(j) - val;
    if sup_nw(i) == 0, i = i + 1; else, j = j + 1; end
end

% ii) least cost method
sup_lc = supply; dem_lc = demand;
X_lc = zeros(size(cost));
temp_cost = cost;
while sum(sup_lc) > 0 && sum(dem_lc) > 0
    [~, idx] = min(temp_cost(:));
    [r, c] = ind2sub(size(cost), idx);
    val = min(sup_lc(r), dem_lc(c));
    X_lc(r,c) = val;
    sup_lc(r) = sup_lc(r) - val;
    dem_lc(c) = dem_lc(c) - val;
    if sup_lc(r) == 0, temp_cost(r, :) = inf; end
    if dem_lc(c) == 0, temp_cost(:, c) = inf; end
end


[rows, cols] = size(X_nw);
combinedem_nw = cell(rows, cols);
for r = 1:rows
    for c = 1:cols
        combinedem_nw{r,c} = sprintf('%d (%d)', X_nw(r,c), cost(r,c));
    end
end

[rows, cols] = size(X_lc);
combinedem_lc = cell(rows, cols);
for r = 1:rows
    for c = 1:cols
        combinedem_lc{r,c} = sprintf('%d (%d)', X_lc(r,c), cost(r,c));
    end
end

[~, idx] = min(cost(:));
cost(:)
