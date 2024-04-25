clear

opt.l = -1;
opt.u = 1;
opt.discr = 0;
opt.I = [];
opt.kmax = 15;
opt.beta = 0.1;
opt.mu = 0.01;
it = 50;

params = ...
    [2, 2, 3, 11, 0, 2;...
     2, 2, 3, 11, 7, 0;...
     2, 2, 3, 11, 4, 1;...
     2, 2, 3, 11, 1, 2;...
     2, 2, 3, 11, 7, 1;...
     2, 2, 3, 11, 6, 1;...
     2, 2, 3, 11, 5, 1;...
     2, 2, 3, 11, 2, 2;...
     ];
 
 results = cell(1,it);
 for j=1:size(params,1)
    param = struct;
    param.M = params(j,1);
    param.P = params(j,2);
    param.N = params(j,3);
    param.R = params(j,4);
    if params(j,5) ~= 0 || params(j,6) ~= 0
        param.S = params(j,5);
        param.T = params(j,6);
    end
    M = param.M;
    N = param.N;
    P = param.P;
    opt.discr = 0;
    
    TM = multiplication_tensor(param.M,param.P,param.N); 
    
    tic
    j2 = 2;
    for i=1:it
        rng(i)
        x0 = randn_x0(param,j2);
        out = ALM(TM,x0,param,opt);
        out.x0 = x0;
        results{i} = out;
    end
    res.param = param;
    res.opt = opt;
    res.results = results;
    res.time = toc

    if params(j,5) ~= 0 || params(j,6) ~= 0   
        save(sprintf('results_%d%d%d_%dR_%dS_%dT_rng1-%d-10-%d_randn_ALM_ul%d.mat',param.M,param.P,param.N,param.R,param.S,param.T,it,j2,opt.u),'res')
    else
        save(sprintf('results_%d%d%d_%dR_rng1-%d-10-%d_randn_ALM_ul%d.mat',param.M,param.P,param.N,param.R,it,j2,opt.u),'res')
    end
    
    tic    
    opt.discr = 1;
    opt.beta = 0.1;
    results2 = cell(1,length(results));
    for i=1:length(results)
        if results{i}.cost(end) < 10^-12
            results2{i} = ALM(TM,results{i}.Ubest,param,opt);
        end
    end
    
    res.results = results2;
    res.time = toc
    res.opt = opt;
    if params(j,5) ~= 0 || params(j,6) ~= 0
        save(sprintf('results_%d%d%d_%dR_%dS_%dT_rng1-%d-10-%d_randn_ALM_ul%d_discr_beta%0.1f.mat',param.M,param.P,param.N,param.R,param.S,param.T,it,j2,opt.u,opt.beta),'res')
    else
        save(sprintf('results_%d%d%d_%dR_rng1-%d-10-%d_randn_ALM_ul%d_discr_beta%0.1f.mat',param.M,param.P,param.N,param.R,it,j2,opt.u,opt.beta),'res')
    end
    
 end
 