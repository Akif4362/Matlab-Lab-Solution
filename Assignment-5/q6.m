clc; clear; 
a = [2 1 2; 1 -5 -4; 2 6 -2];
fprintf("given game \n\n")
disp(a)

fprintf("row minimums: \n")
disp(min(a, [], 2))
fprintf("max of rowmins: %d\n\n", max(min(a, [], 2)))

fprintf("column maximums: \n")
disp(max(a, [], 1))
fprintf("min of colmaxs: %d\n", min(max(a, [], 1)))

if max(min(a, [], 2)) == min(max(a, [], 1))
    fprintf("saddle point reached. value of the game is %d\n", min(max(a, [], 1)))

else
    fprintf("\nsaddle point doesnt exist. we use dominance principle\n")

    for i = 1 : 3
        for k = 1 : 3
            if k~=i
                if all(a(k,:) >= a(i,:))
                    a(i,:) = NaN;               
                    break
                end
            end
        end
    end

    fprintf("\nremoving non dominant row \n\n")
    disp(a)

    game = [];
    
    for i = 1 : 3
        if ~isnan(a(i,:))
            game(end+1,:) = a(i,:);
        end
    end
    
    for j = 1 : 3
        for k = 1 : 3
            if k~=j
                if all(game(:,k) <= game(:,j))
                    game(:,j) = NaN;               
                    break
                end
            end
        end
    end
    
    fprintf("removing non dominant column \n\n")
    disp(game)

    game = game';
    
    game2 = [];
    
    for i = 1 : 3
        if ~isnan(game(i,:))
            game2(end+1,:) = game(i,:);
        end
    end
    
    game2 = game2';
    fprintf("matrix becomes \n\n")
    disp(game2)
    
    syms p
    e1 = p * game2(1,1) + (1-p) * game2(2,1);
    e2 = p * game2(1,2) + (1-p) * game2(2,2);
    p2 = solve(e1==e2,p);

    fprintf("if probability of taking strategy 1 for player 1 is p and that of taking strategy 2 is (1-p) we get two equations \n\n")
    fprintf("e1 == %s\n", string(e1))
    fprintf("e2 == %s\n\n", string(e2))
    fprintf("solving them we get, p = %d\n", p2)
    
    fprintf("therefore, value of the game is %s", string(subs(e1,p,p2)))
end
