function [y] = m1_hiQ_eq(q,a,b,c2,th1)
    y = (a-log(q))/b - c2 + th1 - 2*q - 1/b;
end