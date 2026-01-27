clc; clear;
n = 8;

if mod(n,2) == 0
    N = n;
    max_round = n - 1;
    odd = false;
else
    N = n + 1;
    max_round = n;
    odd = true;
end

team = zeros(max_round,n);

for k = 1 : max_round
    for i = 1 : N - 1
        j = mod(k - i, N - 1);
        if j == 0
            j = N - 1;
        end

        if j == i
            team(k,i) = N;
            if odd == false
                team(k,N) = i;
            end
        else
            team(k,i) = j;
            if j < n
            team(k,j) = i;
            end
        end
    end
end

% team = string(team);
% if odd == true
% idx = (team == string(N));
% team(idx) = "bye";
% end
%disp(array2table(team))

teamname = ["inf", "asymp", "eigen",...
     "lap", "sig", "vect",...
     "grad", "pri"];

rounds = strings(1, max_round);
for i = 1:max_round
    rounds(i) = "round"+ string(i);
end

disp(array2table(teamname(team),...
    "VariableNames",teamname,...
    "RowNames",rounds))
