function [d_max,g_opt] = Dmax(M,d_l,d_u)

cvx_begin 
cvx_solver Mosek
variable d(M)
variable g(M)
maximize sum(d)
subject to

    for j = 1:M
        d(j) == d_l(j) + d_u(j)*g(j);
        sum(g) <= 1.8;
        g(1) + g(2) <= 1.2;
    end

% variable constraints
    g >= 0;
    g <= 1;

cvx_end
d_max = d;
g_opt = g;