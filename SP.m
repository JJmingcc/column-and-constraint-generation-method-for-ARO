function [sp_opt,dopt] = SP(c,d_l,d_u,M,N,z_mp)

bigM = 100000;

cvx_begin 
    cvx_solver Mosek
    % Primal variables
%    variable y(N) binary
    variable x(N,M)
%    variable z(N)
    variable g(M)
    variable d(M)
    variable sum_x(N)
    variable sum_i(N)
    variable sum_j(M)
    % dual variables
    variable Gamma(N) 
    variable lambda(M)
    variable v0(N,M) binary     
    variable v1(N) binary
    variable v2(M) binary
    
    % objective function
    variable sub_obj
    maximize sub_obj
    subject to 
        sub_obj == sum(sum_x);
        sum_x == sum(c.*x,2);
        sum_i == sum(x,2);
        sum_j == sum(x)';
        % KKT stationary condition 
        for i = 1:N
            for j = 1:M
                c(i,j) + Gamma(i) - lambda(j) >= 0;
                c(i,j) + Gamma(i) - lambda(j) <= bigM * v0(i,j);
                x(i,j) <= (1 - v0(i,j)) * bigM;
            end
        end
        
        % Capacity constraint (24)
        for i = 1:N
        % primal constraint (24)
            sum_i(i) <= z_mp(i); 
        % slackness constraint (24)    
            z_mp(i) - sum_i(i) <= v1(i)* bigM; 
            Gamma(i) <= (1 - v1(i)) * bigM;
        end
       
        % constraint (25)
        for j = 1:M
        % primal constraint    
            sum_j(j) >= d(j);   %for any j
        % slackness constraint
            sum_j(j) - d(j) <= v2(j) * bigM;
            lambda(j) <= (1 - v2(j)) * bigM;
            
        end  
        
        % Uncertainty constraint
        for j = 1:N
            d(j) == d_l(j) + d_u(j)*g(j);        
        end
        
        sum(abs(g)) <= 1.8;
        g(1) + g(2) <= 1.2;
        % variable constraints
        g >= 0;
        g <= 1;
        x >= 0;
        
        % dual variable constraints
        Gamma >= 0;
        lambda >= 0;  
cvx_end

dopt = d;
sp_opt = sum(sum_x);

