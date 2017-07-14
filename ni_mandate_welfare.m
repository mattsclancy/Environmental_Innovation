function [W] = ni_mandate_welfare(Qm,par)
par(8) = Qm;
[W] = niw(par);
W = -W;