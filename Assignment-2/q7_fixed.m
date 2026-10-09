clc; clear;
n = 9;

if mod(n,2) == 0
    N = n;
    max_round = n-1;
end

if mod(n,2) ~= 0
    N = n+1;
    max_round = n;
end

team = zeros(max_round, n);

for k = 1: max_round
    for i = 1:N-1
        j = mod(k-i, N-1);
        if j == 0
            j = N-1;
        end
        if j == i;
            team(k,j) = N;
            if mod(n,2) == 0
                team(k,N) = j;
            end
            
        else
            team(k,j) = i;
            if j<i
                team(k,i) = j;
            end
        end
    end
end

team = string(team)
teamnum = string(1:1:9);
names = ["Barcelona", "Real Madrid", "Arsenal", "Liverpool", ...
         "Chelsea", "Man City", "Bayern", "Dortmund", "PSG"];
for i = 1:length(names)
    idx = team == teamnum(i);
    team(idx) = names(i);
end

if mod(n,2) ~= 0
    idx = team == string(N);
    team(idx) = "bye";
end

disp(array2table(team))
