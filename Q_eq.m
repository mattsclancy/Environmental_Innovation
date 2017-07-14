function [y] = Q_eq(q,a,b,c1,priceR,Q2,t)
    y = (a-log(q))/b - ((q-Q2)*(c1+t)+Q2*priceR)/q;
end
        