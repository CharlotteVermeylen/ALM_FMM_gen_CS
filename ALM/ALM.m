function out = ALM(T,x,param,opt)
    % Implementation of the Augmented Lagrangian function with ineauqlity
    % constraint on the elements of x (y2) and equality constraint (y1).
    % The layout of the algorithm is largely inspired by Algorithm 17.4 in
    %
    % Nocedal, J., and Wright, S. J. Numerical optimization. Springer, New
    % York, 1999.
    %
    % The initialization of the parameters is inspired by 
    %
    % Conn, A. R., Gould, N. I. M., and Toint, P. A globally convergent  
    % augmented  Lagrangian algorithm for optimization with general 
    % constraints and simple bounds. SIAM Journal on Numerical Analysis 28, 
    % 2 (1991),545–572.
    % 
    % The application of this algorithm to the fast matrix multiplication 
    % problem already appeared in:
    %
    % Vermeylen, C., Van Barel, M. Stability improvements for fast matrix 
    % multiplication. Numer Algor (2024). 
    % https://doi.org/10.1007/s11075-024-01806-y
    %
    % This  version of the algorithm generalizes the AL algorithm for the 
    % generalized cyclic symmetric structure proposed in:
    %
    % Vermeylen, C., Van Barel, M. Generalized cyclic symmetric 
    % decompositions for the matrix multiplication tensor. arXiv: ...
    
    % Initialization Lagrange multipliers
    if isfield(x,'ybest') 
        y = x.ybest;
        x = x.Ubest;
        y1 = y{1};
        y2 = y{2};
    else
        xvec = cell2vec(x);
        n = length(xvec);
        y1 = zeros(length(opt.I)+opt.discr*length(xvec),1);
        y2 = zeros(n,1);
        y = {y1,y2};
    end
    
    gradtol_opt = 10^(-14);
    mu = (10^(-1)); % (Conn:0.1) 1/beta, <= 1
    beta = 1/mu;
    nu_opt = 10^(-13);
    
    % parameters ALM
    p.tau = 0.5; % (Conn:0.01) < 1
    p.gamma_bar = 0.1; % (Conn:0.1) < 1
    p.alfa_w = 1; % (Conn:1) <= 1
    p.beta_w = 1; % (Conn:1) <= 1
    p.alfa_nu = 0.1; % (Conn:0.1) < min(1,alfa_w) 
    p.beta_nu = 0.9; % (Conn:0.9) < min(1,beta_w) 
    p.nu_bar = 1; % (Conn:1) <= 1  
    p.w_bar = gradtol_opt; % (Conn:1) <= 1 
    
    % Initialization parameters and tolerances
    alfa = min(mu,p.gamma_bar); % 0.1 < 1
    w = max(p.w_bar*(alfa)^(p.alfa_w),gradtol_opt); % 10^-14 
    opt.gradtol = w;
    nu = p.nu_bar*(alfa)^(p.alfa_nu); % +- 0.8 tolerance constraint

    [f,Fn,hn,gr,~,Un] = get_values(T,x,beta,y,param,opt);
    out = struct;       
    out = initialize_output_ALM(out,Un,f,Fn,[],[],beta,w,nu);
    
    k = 1;
    
    if hn <= nu_opt && norm(gr) <= gradtol_opt
        disp('Starting point already satisfies optimality conditions')
        out.Ubest = x;
        out.ybest = y;
        return
    end

    while k < opt.kmax

        [x,out_LM,k_LM] = LM_ALM(T,x,y,beta,param,opt);
        opt.mu = out_LM.mu(end);
        xvec = cell2vec(x);

        [f,Fn,hn,gr] = get_values(T,x,beta,y,param,opt);

        if (hn) <= nu
            if hn <= nu_opt && norm(gr) <= gradtol_opt
                out.Ubest = x;
                out.fbest = f;
                out.ybest = y;
                out = update_output_ALM(out,Fn,beta,w,nu,k_LM,out_LM);
                
                out.params_ALM = p;
                disp('Optimality conditions satisfied')
                return
            end
            h = equality(x,opt);
            y1 = y1 + beta*h;
            y2 = max(y2-beta*(opt.u-xvec),zeros(size(y2))) - max(beta*(opt.l-xvec)-y2,zeros(size(y2)));
            y_new = {y1,y2};
            y = y_new;
            
            alfa = mu;
            % lower tolerance constraint
            nu = max(nu*mu^p.beta_nu,nu_opt);         
            % lower tolerance gradient
            w = max(w*alfa^p.beta_w,gradtol_opt);
            opt.gradtol = w;
                
        else
            mu = max(p.tau*mu,10^(-16)); % lower mu
            beta = 1/mu;
            alfa = mu*p.gamma_bar;
            nu = max(p.nu_bar*alfa^p.beta_nu,nu_opt);
            w = max(gradtol_opt,p.w_bar*alfa^(p.beta_w));
            opt.gradtol = w;
        end
               
        fprintf(('It: %i, Fn: %i, hn: %i, grn: %i, Un: %i, beta: %i, w: %i, nu: %i \n'),...
            k,Fn,hn,norm(gr),norm(xvec,'inf'),beta,w,nu)
        
        k = k + 1;
        
        out = update_output_ALM(out,Fn,beta,w,nu,k_LM,out_LM);
    end
    
    out.Ubest = x;
    out.fbest = f;
    out.ybest = y;
    out.params_ALM = p;
    
    disp('Maximal number of iteration reached')  
end