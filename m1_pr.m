function [pr] = m1_pr(t,Q,a,b,c1,c2,th1,th2)
if c2-th1+Q >= c1+t; % Impossible to exceed mandate %
    pr = (th1-th2)*Q;
else % Possible for winner to exceed mandate.
    % Now we find the unconstrained optimal solution and the constrained
    % optimal solution. First, the unconstrained solution:
    
    Q_max = exp(a-b*(c1+t)); % Entire energy market at dirty energy prices
    Q_opt = (th1 - (c2-c1-t))/2; % Optimal quantity, w/o competition
    price = c1+t;
    if Q_opt > Q_max; % Renewable takes over entire market
        
        % At this point demand is kinked. Optimal quantity may be greater
        % than Q_max, if the marginal change of profit with respect to
        % quantity, given below, is positive.
        marginal = c1+t-c2+th1-2*Q_max-1/b;
        if marginal > 0; % Optimal unconstrained quantity exceeds Q_max
            % Find the unconstrained max
            q0 = [Q_max exp(a)];
            Q_opt = fzero(@m1_hiQ_eq,q0,[],a,b,c2,th1);
            price = (a-log(Q_opt))/b;
        else
            Q_opt = Q_max;
        end
    end
    u_royalty = price-(c2-th1+Q_opt);
    % Next we find the constrained optimum.
    if c2-th2+Q <= c1+t; % The mandate must be exceeded
        Q_con = th2 - (c2-c1-t);
        if Q_con > Q_max;
            q0 = [Q_max exp(a)];
            Q_con = fzero(@m1_hiconQ_eq,q0,[],a,b,c2,th2);
        end
    else
        Q_con = Q;
    end
    c_royalty = th1-th2;
    % Now we find the maximum profit. If Q_opt exceeds Q_con, then the
    % researcher can choose to achieve either the constrained or
    % unconstrained profit level. Otherwise, they must take the constrained
    % profit level.
    if Q_opt > Q_con;
        pr = max(Q_con*c_royalty,Q_opt*u_royalty);
    else
        pr = Q_con*c_royalty;
    end
end
