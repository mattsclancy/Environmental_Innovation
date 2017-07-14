function [y] = constr_Qm(Qm,a,b,c2)
y = c2+Qm-(a-log(Qm))/b;
end