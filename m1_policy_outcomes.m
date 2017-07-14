function [W] = m1_policy_outcomes(policy,xx,par,nn)

if policy == 'T';
    par(7) = xx;
elseif policy == 'M';
    par(8) = xx;
else
    par(9) = xx;
end
y = m1_outcomes(par,0,nn);
W = y(1,10);