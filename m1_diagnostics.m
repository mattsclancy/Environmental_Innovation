function [y] = m1_diagnostics(par,nn)

y = zeros(nn,6);

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
th1s = ws;
th2s = ws;
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
[ps tr_ns] = m2_p_triple(ws,ns,w_max,alpha,beta);

EprI = 0;
EprP = 0;
EX = 0;
ECS = 0;
EW = 0;
pr = 0;

ww = 1;
omega = ws(ww);
for ii=1:length(ps);
    p = ps(ii);
    w = tr_ns(ii,1);
    if w ~= omega;
        y(ww,1) = omega;
        y(ww,2) = EprP/pr;
        y(ww,3) = EprI/pr;
        y(ww,4) = -EX/pr;
        y(ww,5) = ECS/pr;
        y(ww,6) = EW/pr;
        
        EprI = 0;
        EprP = 0;
        EX = 0;
        ECS = 0;
        EW = 0;
        pr = 0;
        
        ww = ww+1;
        omega = ws(ww);
    end
    if p > 0;
        w = tr_ns(ii,1);
        th1 = tr_ns(ii,2);
        th2 = tr_ns(ii,3);
        n_i = tr_ns(ii,4);
        [Q2,QT,priceR,priceT,prI,prP,W] = m1_expost_outcomes(t,Qm,a,b,c1,c2,x,k,n_i,th1,th2);

        EX = EX + p*(x*(QT-Q2));
        EprI = EprI + p*prI;
        EprP = EprP + p*prP;
        EW = EW + p*W;
        ECS = ECS + p*(exp(a-b*priceT)/b);
        pr = pr+p;
    end
end
