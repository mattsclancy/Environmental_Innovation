function [W0] = niw(par)

% Returns welfare that is obtained without innovation

a = par(1);
b = par(2);
c1 = par(3);
c2 = par(4);
x = par(5);
k = par(6);
t = par(7);
Qm = par(8);
s = par(9);
entry = par(10);
alpha = par(11);
beta = par(12);
w_max = par(13);

priceR = c2+Qm;
if priceR > c1+t;
    q0 = [exp(a-b*(c1+t)-1) exp(a-b*(c1+t))+1];
    Q = fzero(@Q_eq,q0,[],a,b,c1,priceR,Qm,t);
    p = (a-log(Q))/b;
    Q2 = Qm;
else
    Q = exp(a-b*(c1+t));
    p = c1+t;
    Q2 = max(c1+t-c2,0);
end
CS = exp(a-b*p)/b;
prP = Q2^2/2;
W0 = CS + (t-x)*(Q-Q2) + prP;
