function [ns] = m1_nw_1(t,Qm,omegas,k,a,b,c1,c2,grid)

% This code computes the number of innovators for each omega

ns = zeros(1,length(omegas));
ii = 1;
n0 = 0;
n1 = 1;
while n0 == 0;
    w = omegas(ii);
    pr1 = m1_Epr(t,Qm,a,b,c1,c2,n1,w,grid);

    if pr1 <= k;
        if ii == length(omegas);
            n0 = -1;
        else
            ii = ii+1;
        end
    else
        n0 = 1;
        ns(ii:length(omegas)) = 1;
    end
end
