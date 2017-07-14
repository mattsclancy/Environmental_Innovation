function [mids,weights] = mp(l,u,n)

edges = linspace(l,u,n+1);
mids = zeros(1,n);
weights = zeros(1,n)+(u-l)/n;
for nn=1:n;
    mids(nn) = (edges(nn)+edges(nn+1))/2;
end