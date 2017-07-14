function ns = m1_nw(t,Qm,omegas,k,a,b,c1,c2,grid)

% This code computes the number of innovators for each omega

ns = [];
n0 = 0;
n1 = 1;
for ii=1:length(omegas);
    w = omegas(ii);
    found = 0;
    while found == 0;
        pr1 = m1_Epr(t,Qm,a,b,c1,c2,n1,w,grid);
        if pr1 <= k;
            ns(end+1) = n0;
            found = 1;
        else;
            n0 = n0 + 1;
            n1 = n1 + 1;
        end
    end
end