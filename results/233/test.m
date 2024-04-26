M = 2; P = 3; N = 3; R = 15; S = 5; T =1;

if S == 0 && T == 0
    n = sprintf('results_%d%d%d_%dR_rng1-50-10-2_randn_ALM_ul1.mat',M,P,N,R);
else
    n = sprintf('results_%d%d%d_%dR_%dS_%dT_rng1-50-10-2_randn_ALM_ul1.mat',M,P,N,R,S,T);
end
load(n);

res.opt = rmfield(res.opt,'test_manopt_grad');
res.opt = rmfield(res.opt,'reg');

save(n,'res')

if S == 0 && T == 0
    n = sprintf('results_%d%d%d_%dR_rng1-50-10-2_randn_ALM_ul1_discr_beta0.1.mat',M,P,N,R);
else
    n = sprintf('results_%d%d%d_%dR_%dS_%dT_rng1-50-10-2_randn_ALM_ul1_discr_beta0.1.mat',M,P,N,R,S,T);
end

load(n);

res.opt = rmfield(res.opt,'test_manopt_grad');
res.opt = rmfield(res.opt,'reg');
res = rmfield(res,'time');

save(n,'res')

