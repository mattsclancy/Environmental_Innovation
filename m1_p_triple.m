function [ps triple_n] = m1_p_triple(ws,ns,om_max,a,b)
% A function to give the probability of attaining each (w,th1,th2) triple.
% Output is a vector of probabilities. Ordering begins with smallest
% w, th1, and th2, and then increases th2 until it would be bigger than
% th1. At this point we increment up th1 by one and repeat, until we get
% to where th1 would be bigger than w.

% First we compute the discrete probabilities of each omega.

ps = [];
triple_n = [];
pws = [];
for ii=1:length(ws);
    w = ws(ii);
    pw0 = (w/om_max)^(a-1)*(1-w/om_max)^(b-1);
    pws(end+1) = pw0;
end
pws = pws/sum(pws);

% Next we compute the discrete probabilities of th1 and th2, conditional 
% on the omega.

for ii=1:length(ws);
    w = ws(ii);
    n = ns(ii);
    pw = pws(ii);
    
    % If there are no innovators, then the probability of a draw with
    % theta1=theta2=0 is 1, and all other possibilities are zero.
    if n == 0;
        ps(end+1) = pw;
        triple_n(end+1,:) = [w 0 0 n];
    % If there is at least one innovator, then we need to compute the 
    % discrete probabilities of drawing each theta1.
    elseif n >= 1;
        th1s = mp(0,w,ii);
        p1s = [];
        for jj=1:ii;
            th1 = th1s(jj);
            lnp1 = log(n)+(n-1)*log(th1)-n*log(w);
            p1 = exp(lnp1);
            p1s(end+1) = p1;
        end
        if sum(p1s) > 0;
            p1s = p1s/sum(p1s);
        else;
            p1s = 1;
        end;
        for jj=1:ii;
            p1 = p1s(jj);
            th1 = th1s(jj);

            % If there is just one innovator, then theta2 = 0 with
            % certainty
            if n == 1;
                ps(end+1) = pw*p1;
                triple_n(end+1,:) = [w th1 0 n];
            
            % If there is more than one innovator, then we need to compute
            % the discrete probabilities of each theta2.
            else;
                th2s = mp(0,th1,jj);
                p2s = [];
                for ll=1:jj;
                    th2 = th2s(ll);
                    if th1 == 0;
                        p2 = 1;
                    else;
                        lnp2 = log(n-1)+(n-2)*log(th2)-(n-1)*log(th1);
                        p2 = exp(lnp2);
                    end
                    p2s(end+1) = p2;
                end
                if sum(p2s) > 0;
                    p2s = p2s/sum(p2s);
                else;
                    p2s = 1;
                end;
                for ll=1:jj;
                    th2 = th2s(ll);
                    p2 = p2s(ll);
                    ps(end+1) = pw*p1*p2;
                    triple_n(end+1,:) = [w th1 th2 n];
                end
            end
        end
    end
end
