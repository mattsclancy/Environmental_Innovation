function [y] = ex_post_W1(a,b,c1,x,c2,n,k,th1)

% What is the equilibrium demand and price?

Qs = exp(a-b*(c1+x));
Q2 = max(0,c1+x+th1-c2);

if Q2 <= Qs;
    p = c1+x;
else;
    q0 = [Qs exp(a)];
    Q2 = fzero(@m1_comp_Q,q0,[],a,b,c2,th1);
    p = (a-log(Q2))/b;
end    
CS = exp(a-b*p)/b;
PS = Q2^2/2;
W = CS+PS-n*k;
y = [Q2,W];