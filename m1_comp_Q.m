function [y] = m1_comp_Q(q,a,b,c2,th1)
    y = (a-log(q))/b - c2 + th1 - q;
end