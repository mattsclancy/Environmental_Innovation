% This loop generates a wide array of simulation outcomes for every 
% combination of parameter values.

% See notes on Numerical Simulation Parameters for details on where these
% parameter values come from

% Note that the parameter vector should take the following form: 
% par = [a,b,c1,c2,x,k,t,Qm,s,entry,alpha,beta,w_max]
% par = [1,2, 3, 4,5,6,7, 8,9,   10,   11,  12,   13]

B = [0.005 0.01 0.0025];
X = [10 20 40];
K = [20.833 41.667 83.333];
AB = [0.5, 1.5; 0.25, 1.75; 1, 1];
c1 = 100;
c2 = 120;
w_max = 120;

n_rows = length(B)*length(X)*length(K)*length(AB(:,1))*10;
Output = zeros(n_rows,31);

nn = 1;
for bb=1:3;
    b = B(bb);
    a = b*c1+log(100);
    for xx=1:3;
        x = X(xx);
        for kk=1:3;
            k = K(kk);
            for ab=1:3;
                alpha = AB(ab,1);
                beta = AB(ab, 2);
                par = [a,b,c1,c2,x,k,0,0,0,0,alpha,beta,w_max];
                
                % Laissez-Faire, Single Innovator
                W0 = niw(par);
                y = m1_outcomes(par,W0,100);
                new_row = [0 0 0 a b c1 x k alpha beta y(1,1) y(2,1) y(1,2) y(2,2) y(1,3) y(2,3) y(1,4) y(2,4) y(1,5) y(2,5) y(1,6) y(2,6) y(1,7) y(2,7) y(1,8) y(2,8) y(1,9) y(2,9) y(1,10) y(2,10) W0];
                Output(nn,:) = new_row;
                nn = nn + 1;
                
                % Laissez-Faire, Free Entry
                par(10) = 1;
                y = m1_outcomes(par,W0,100);
                new_row = [0 1 0 a b c1 x k alpha beta y(1,1) y(2,1) y(1,2) y(2,2) y(1,3) y(2,3) y(1,4) y(2,4) y(1,5) y(2,5) y(1,6) y(2,6) y(1,7) y(2,7) y(1,8) y(2,8) y(1,9) y(2,9) y(1,10) y(2,10) W0];
                Output(nn,:) = new_row;
                nn = nn + 1;
                
                % Naive Carbon Tax, Single Innovator
                par(10) = 0;
                tax = par(5);
                par(7) = tax;
                y = m1_outcomes(par,W0,100);
                new_row = [1 0 tax a b c1 x k alpha beta y(1,1) y(2,1) y(1,2) y(2,2) y(1,3) y(2,3) y(1,4) y(2,4) y(1,5) y(2,5) y(1,6) y(2,6) y(1,7) y(2,7) y(1,8) y(2,8) y(1,9) y(2,9) y(1,10) y(2,10) W0];
                Output(nn,:) = new_row;
                nn = nn + 1;
                
                % Carbon Tax, Free Entry
                par(10) = 1;
                y = m1_outcomes(par,W0,100);
                new_row = [1 1 tax a b c1 x k alpha beta y(1,1) y(2,1) y(1,2) y(2,2) y(1,3) y(2,3) y(1,4) y(2,4) y(1,5) y(2,5) y(1,6) y(2,6) y(1,7) y(2,7) y(1,8) y(2,8) y(1,9) y(2,9) y(1,10) y(2,10) W0];
                Output(nn,:) = new_row;
                nn = nn + 1;
                
                % Optimal Carbon Tax, Single Innovator
                par(10) = 0;
                [tax welfare] = golden_section_search(par,'T',100,0.01);
                par(7) = tax;
                y = m1_outcomes(par,W0,100);
                new_row = [1 0 tax a b c1 x k alpha beta y(1,1) y(2,1) y(1,2) y(2,2) y(1,3) y(2,3) y(1,4) y(2,4) y(1,5) y(2,5) y(1,6) y(2,6) y(1,7) y(2,7) y(1,8) y(2,8) y(1,9) y(2,9) y(1,10) y(2,10) W0];
                Output(nn,:) = new_row;
                nn = nn + 1;
                
                % Optimal Carbon Tax, Free Entry
                par(10) = 1;
                [tax welfare] = golden_section_search(par,'T',100,0.01);
                par(7) = tax;
                y = m1_outcomes(par,W0,100);
                new_row = [1 1 tax a b c1 x k alpha beta y(1,1) y(2,1) y(1,2) y(2,2) y(1,3) y(2,3) y(1,4) y(2,4) y(1,5) y(2,5) y(1,6) y(2,6) y(1,7) y(2,7) y(1,8) y(2,8) y(1,9) y(2,9) y(1,10) y(2,10) W0];
                Output(nn,:) = new_row;
                nn = nn + 1;
                
                % Optimal Mandate, Single Innovator
                par(10) = 0;
                par(7) = 0;
                [mandate welfare] = golden_section_search(par,'M',100,0.01);
                par(8) = mandate;
                y = m1_outcomes(par,W0,100);
                new_row = [2 0 mandate a b c1 x k alpha beta y(1,1) y(2,1) y(1,2) y(2,2) y(1,3) y(2,3) y(1,4) y(2,4) y(1,5) y(2,5) y(1,6) y(2,6) y(1,7) y(2,7) y(1,8) y(2,8) y(1,9) y(2,9) y(1,10) y(2,10) W0];
                Output(nn,:) = new_row;
                nn = nn + 1;
                
                % Optimal Mandate, Free Entry
                par(10) = 1;
                [mandate welfare] = golden_section_search(par,'M',100,0.01);
                par(8) = mandate;
                y = m1_outcomes(par,W0,100);
                new_row = [2 1 mandate a b c1 x k alpha beta y(1,1) y(2,1) y(1,2) y(2,2) y(1,3) y(2,3) y(1,4) y(2,4) y(1,5) y(2,5) y(1,6) y(2,6) y(1,7) y(2,7) y(1,8) y(2,8) y(1,9) y(2,9) y(1,10) y(2,10) W0];
                Output(nn,:) = new_row;
                nn = nn + 1;
                
                % Optimal R&D Subsidy, Single Innovator
                par(10) = 0;
                par(8) = 0;
                [subsidy welfare] = golden_section_search(par,'S',100,0.001);
                par(9) = subsidy;
                y = m1_outcomes(par,W0,100);
                new_row = [3 0 subsidy a b c1 x k alpha beta y(1,1) y(2,1) y(1,2) y(2,2) y(1,3) y(2,3) y(1,4) y(2,4) y(1,5) y(2,5) y(1,6) y(2,6) y(1,7) y(2,7) y(1,8) y(2,8) y(1,9) y(2,9) y(1,10) y(2,10) W0];
                Output(nn,:) = new_row;
                nn = nn+1;
                
                % Optimal R&D Subsidy, Free Entry
                par(10) = 1;
                [subsidy welfare] = golden_section_search(par,'S',100,0.001);
                par(9) = subsidy;
                y = m1_outcomes(par,W0,100);
                new_row = [3 1 subsidy a b c1 x k alpha beta y(1,1) y(2,1) y(1,2) y(2,2) y(1,3) y(2,3) y(1,4) y(2,4) y(1,5) y(2,5) y(1,6) y(2,6) y(1,7) y(2,7) y(1,8) y(2,8) y(1,9) y(2,9) y(1,10) y(2,10) W0];
                Output(nn,:) = new_row;
                nn = nn+1;
                
                csvwrite('Numerical Results.csv', Output)
                disp([b x k alpha beta])
            end
        end
    end
end

csvwrite('Numerical Results.csv', Output)
