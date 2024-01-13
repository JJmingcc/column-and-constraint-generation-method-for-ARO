function [mp_opt,y_mp,z_mp] = MP2(f,a,c,K,dopt,M,N,iter)

d = dopt;

cvx_begin 
    cvx_solver Mosek
    % First-stage variables
    variable y(N) binary
    variable z(N)
    % Second stage variables
    variable x(N,M,iter)
    variable sum_x(N,iter)
    variable sumx_i(N,iter)
    variable sumx_j(M,iter)
    variable eta    
    variable mp_obj
    minimize mp_obj
    subject to 
        mp_obj == f'*y + a'*z + eta;
        % Primal cut
        for k = 1:iter
            eta >= sum(sum(c .* x(:,:,k)));
            % constraint (1)
            sumx_i(:,k) <= z;     % forany i
            % constraint (2)
            sumx_j(:,k) >= d(:,k);   % forany j  
            sumx_j(:,k) == sum(x(:,:,k))';
            sumx_i(:,k) == sum(x(:,:,k),2);
        end
         
        for i = 1:N
            z(i) <= K(i) * y(i);  
        end

       x >= 0;
       z >= 0;
        
cvx_end
 
y_mp = y;
z_mp = z;
mp_opt = f'*y + a'*z + eta;