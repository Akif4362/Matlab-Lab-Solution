clc; clear;
a = [3 1];
m = [4 6];

solution = true;
for i = 1:length(a)-1
   if mod(a(i+1)-a(i), gcd(m(i+1),m(i))) ~= 0
    disp("soluiton doesnt exist")
    solution = false;
    break
   end
end

if solution == true
    x0 = a(1);
    M = m(1);

    for i = 2:length(a)
        ai = a(i);
        mi = m(i);
        rhs = ai - x0;
        g = gcd(M, mi);

        % scaling
        M1 = M / g;
        m1 = mi / g;
        rhs1 = rhs / g;

        % solve M1*k ≡ rhs1 (mod m1)
        [~, invM, ~] = gcd(M1, m1);
        k = invM*rhs1;
        k = mod(k, m1);

        % update
        x0 = x0 + M*k;
        M = M*m1;
    end
    fprintf("solution is x ≡ %i (mod %i)", x0, M)
end


