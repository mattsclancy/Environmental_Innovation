function [xx,W] = golden_section_search(par,policy,nn,tolerance)

% Uses the golden section algorithm to find the policy (over an interval) 
% that achieves maximum welfare.

% Note that the parameter vector should take the following form: 
% par = [a,b,c1,c2,x,k,t,Qm,s,entry,alpha,beta,w_max]
% par = [1,2, 3, 4,5,6,7, 8,9,   10,   11,  12,   13]

gr = (-1+sqrt(5))/2;

if policy == 'T';
    b = 3*par(5);
elseif policy == 'S';
    b = 0.999;
else
    a = par(1);
    b = par(2);
    c1 = par(3);
    c2 = par(4);
    t = par(7);
    min_step    = c2-(c1+t);
    ac          = exp(a-b*(c1+t)-1)/b;
    maxQ2       = 0.5*(sqrt(min_step^2+4*ac) - min_step);
    if maxQ2 <= exp(a-b*c1-1);
    %if b*maxQ2*(c2-(c1+t)+maxQ2) >= maxQ2;
        b = maxQ2;
    else
        % This code finds the mandate such that demand for Q2 at the price
        % imposed by the mandate is just satisfied by the mandate.
        qm = [0.00001 exp(a-b*c1)];
        b = fzero(@constr_Qm,qm,[],a,b,c2);
    end
end
a = 0;

Wa = m1_policy_outcomes(policy,a,par,nn);
Wb = m1_policy_outcomes(policy,b,par,nn);

x1 = gr*a + (1-gr)*b;
W1 = m1_policy_outcomes(policy,x1,par,nn);
x2 = (1-gr)*a + gr*b;
W2 = m1_policy_outcomes(policy,x2,par,nn);
interval = b - a;
while interval > tolerance;
    if W1 > W2;
        b = x2;
        Wb = W2;
        x2 = x1;
        W2 = W1;
        x1 = gr*a + (1-gr)*b;
        W1 = m1_policy_outcomes(policy,x1,par,nn);
    else
        a = x1;
        Wa = W1;
        x1 = x2;
        W1 = W2;
        x2 = (1-gr)*a + gr*b;
        W2 = m1_policy_outcomes(policy,x2,par,nn);
    end
    interval = b - a;
end
xs = [a,x1,x2,b];
Ws = [Wa,W1,W2,Wb];
xx = xs(Ws == max(Ws));
if length(xx) > 1;
    xx = xx(1);
end
W = max(Ws);