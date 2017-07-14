function [y] = m1_outcomes(par,W0,nn)
% This function generates via simulation the expected value and variance of
% 10 outcomes:
% Q2: The quantity of renewable energy supplied
% QT: The quantity of all energy supplied
% priceR: The price of renewable energy
% priceT: The price of blended energy
% prI: The profits of the winning innovator
% prP: The producer surplus of clean energy producers
% n: The number of innovators
% th1: The marginal cost reduction of the best innovation
% pWL: The probability that welfare is worse than the benchmark W0
% W: Welfare

% Note that the parameter vector should take the following form: 
% par = [a,b,c1,c2,x,k,t,Qm,s,entry,alpha,beta,w_max]
% par = [1,2, 3, 4,5,6,7, 8,9,   10,   11,  12,   13]

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

ws = mp(0,w_max,nn);
grid = nn;

if alpha+beta < 2;
    if ws(1) == 0 || ws(end) == om_max;
        fprintf('Infinite probability density for omega endpoints\n')
    end
end

min_step    = c2-(c1+t);
ac          = exp(a-b*(c1+t)-1)/b;
maxQ2       = 0.5*(sqrt(min_step^2+4*ac) - min_step);

if Qm > maxQ2;
    fprintf('Mandate is infeasible large')
end

% First, we compute the number of innovators under each draw of w
if entry == 1;
    ns = m1_nw(t,Qm,ws,(1-s)*k,a,b,c1,c2,grid);
else
    ns = m1_nw_1(t,Qm,ws,(1-s)*k,a,b,c1,c2,grid);
end

% Next, we compute the probability of each (w,th1,th2) draw
[ps tr_ns] = m1_p_triple(ws,ns,w_max,alpha,beta);

EQ2 = 0;
EQT = 0;
EpriceR = 0;
EpriceT = 0;
EprI = 0;
EprP = 0;
En = 0;
Eth1 = 0;
EW = 0;
pWL = 0;
EWL = 0;
EQ22 = 0;
EQT2 = 0;
EpriceR2 = 0;
EpriceT2 = 0;
EprI2 = 0;
EprP2 = 0;
En2 = 0;
Eth12 = 0;
EW2 = 0;

for ii=1:length(ps);
    p = ps(ii);
    if p > 0;
        w = tr_ns(ii,1);
        th1 = tr_ns(ii,2);
        th2 = tr_ns(ii,3);
        n_i = tr_ns(ii,4);
        [Q2,QT,priceR,priceT,prI,prP,W] = m1_expost_outcomes(t,Qm,a,b,c1,c2,x,k,n_i,th1,th2);

        EQ2 = EQ2 + p*Q2;
        EQT = EQT + p*QT;
        EpriceR = EpriceR + p*priceR;
        EpriceT = EpriceT + p*priceT;
        EprI = EprI + p*prI;
        EprP = EprP + p*prP;
        En = En + p*n_i;
        Eth1 = Eth1 + p*th1;
        EW = EW + p*W;
        EQ22 = EQ22 + p*Q2^2;
        EQT2 = EQT2 + p*QT^2;
        EpriceR2 = EpriceR2 + p*priceR^2;
        EpriceT2 = EpriceT2 + p*priceT^2;
        EprI2 = EprI2 + p*prI^2;
        EprP2 = EprP2 + p*prP^2;
        En2 = En2 + p*n_i^2;
        Eth12 = Eth12 + p*th1^2;
        EW2 = EW2 + p*W^2;
        if W <= W0;
            pWL = pWL + p;
            EWL = EWL + p*W;
        end
    end
end
vQ2 = EQ22 - EQ2^2;
vQT = EQT2 - EQT^2;
vpriceR = EpriceR2 - EpriceR^2;
vpriceT = EpriceT2 - EpriceT^2;
vprI = EprI2 - EprI^2;
vprP = EprP2 - EprP^2;
vn = En2 - En^2;
vth1 = Eth12 - Eth1^2;
vW = EW2 - EW^2;
EWL = EWL/pWL;

y = [EQ2 EQT EpriceR EpriceT EprI EprP En Eth1 pWL EW;
     vQ2 vQT vpriceR vpriceT vprI vprP vn vth1 EWL vW];
