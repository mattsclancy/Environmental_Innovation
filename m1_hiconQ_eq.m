function [y] = m1_hiconQ_eq(q,a,b,c2,th2)
    y = (a-log(q))/b - c2 + th2 - q;
end