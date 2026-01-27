clc; clear;

% simple finite continued fraction (division method)
function fin_cf = continued_fraction(a,b)
fin_cf = [];
while b ~= 0
    q = floor(a/b); % quotient
    r = mod(a,b); % remainder
    fin_cf(end+1) = q;
    a = b;
    b = r;
end
end

cf1 = continued_fraction(62, 23) 

% infinite simple continued fraction (check 302 lecture 13/10/25)

function inf_cf = infinite_continued_fraction(n)
inf_cf = [];
for i = 1:10
a = floor(n);
inf_cf(end + 1) = a;
k = 1 / (n - a);
n = k;
end
end

cf2 = infinite_continued_fraction(sqrt(6))

% convergent with recurrence relation (check 302 lecture 09/10/25)

function cv = convergent(cf_list,k)
pm2 = 0; pm1 = 1; qm2 = 1; qm1 = 0;

for i = 1:k+1
    pk = cf_list(i)*pm1 + pm2;
    qk = cf_list(i)*qm1 + qm2;

    pm2 = pm1;
    pm1 = pk;
    qm2 = qm1;
    qm1 = qk;
end
cv = sym(pk/qk)
end

cv = convergent(cf1,3)


