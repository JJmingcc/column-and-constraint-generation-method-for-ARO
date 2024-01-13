% Transportation example for CCG algorithm 
clc;
clear all;

% Parameters (experiment 1) M =5 N =6
% M = 6; % for any j
% N = 5; % for any i
% f = [400;414;326;434;352];
% a = [18;25;20;22;23];
% c = [22 33 24 15 18 22;33 23 30 43 30 33;20 25 27 29 40 26; 23 24 22 37 32 31;22 25 21 24 30 36];
% K = 1000 * ones(N,1);
% d_l = [206;274;220;100;300;230];
% d_u = [40;40;40;40;40;40];



% Parameter (experiment 2) M = N =3
M = 3; % for any j
N = 3; % for any i
f = [400;414;326];
a = [18;25;20];
c = [22 33 24;33 23 30;20 25 27];
K = 800 * ones(N,1);
d_l = [206;274;220];
d_u = [40;40;40];

o = [];


% initialization
iter = 1;  % k in algorithm
converged = 0;

   
% solving the frist stage problem
while converged == 0
    % solve the master problem in step 1; adding feasibility cut
    if iter == 1
         % d_max is within this uncertainty set 
         [d_max,g_opt] = Dmax(M,d_l,d_u);
         [mp0_opt,yopt_mp,zopt_mp] = MP0(f,a,K,N,M,d_max);
         LB(iter) = mp0_opt;
         max_LB = max(LB);
         dopt(:,iter) = d_max;
    end
    
    if iter >= 2
         [mp_opt,yopt_mp,zopt_mp] = MP2(f,a,c,K,dopt,M,N,iter);
         LB(iter) = mp_opt;
         max_LB = max(LB);
        
         if LB(iter) > max_LB
            LB(iter) = mp_opt;
         else
            LB(iter) = max(LB);
         end
        
    end
         [sp_opt,dopt] = SP(c,d_l,d_u,M,N,zopt_mp);
          dopt(:,iter + 1) = dopt;
          UB(iter) = sp_opt + f'* yopt_mp + a' * zopt_mp;
          min_UB = min(UB); 
  
    if abs(UB(iter)-LB(iter)) < 1
        converged = 1;
        break;
    else
        converged = 0;
        if sp_opt <= +inf
            iter = iter + 1;
            o = [o,iter];
        else 
            iter = iter + 1;
        end
    end
     
end          
%%
figure;
plot(UB,'rx-','LineWidth',1.5,'MarkerSize',12);
hold on;
plot(LB,'bs-','LineWidth',1.5,'MarkerSize',12);
legend('UB','LB','FontSize',12)
xlabel('Iteration','FontSize',14);
ylabel('Objective','FontSize',14);
            

