function [Epr] = m1_Epr(t,Qm,a,b,c1,c2,n,w,grid)

if Qm == 0 && c2 == c1+t;
    Epr = w^2*(n-(1-0.5^n))/(n*(n+1)*(n+2));
else
    th1s = mp(0,w,grid);
    th2s = mp(0,w,grid);
    Epr_sum = 0;
    for ii=1:grid;
        th1 = th1s(ii);            
        % For each theta1, we find the expected value conditional on winning
        pwin = (th1/w)^(n-1);
        if n > 1;
            ll_max = find(th2s==max(th2s(th2s <= th1)));
            Epr_th1 = 0;
            p_sum = 0;
            for ll=1:ll_max;
                th2 = th2s(ll);
                p2 = (n-1)/th2*(th2/th1)^(n-1);
                Epr_th1 = Epr_th1 + p2*m1_pr(t,Qm,a,b,c1,c2,th1,th2);
                p_sum = p_sum + p2;
            end
            Epr_sum = Epr_sum + pwin*Epr_th1/p_sum;
        else;
            Epr_sum = Epr_sum + pwin*m1_pr(t,Qm,a,b,c1,c2,th1,0);
        end
    end
    Epr = Epr_sum/grid;
end
end