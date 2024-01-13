function [mp_opt,y_mp,z_mp] = MP0(f,a,K,N,M,d_max)

cvx_begin 
    cvx_solver Mosek
    variable y(N) binary
    variable z(N)  
    variable x(N,M)
    variable mp_obj
    minimize mp_obj
    subject to 
        mp_obj == f'*y + a'*z;
        for i = 1:N
            z(i) <= K(i) * y(i); 
        end
        sum(x,2) <= z;
        sum(x,1)' >= d_max;
        z >= 0;  
        x >= 0;
cvx_end

y_mp = y;
z_mp = z;
mp_opt = f'*y + a'*z;