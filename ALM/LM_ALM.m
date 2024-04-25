function [x,out,k] = LM_ALM(T,x,y,beta,param,opt)
    % LM method for the optimization of the Augmented Lagrangian. 
    % Initialize parameters
    xvec = cell2vec(x);
    steptol = 10^-13;
    nu = 2;
    k = 1;    
    opt.kmax = 50;    
    
    [f,Fn,hn,gr,H,Un] = get_values(T,x,beta,y,param,opt);

    found = (norm(gr) < opt.gradtol);
    
    if isfield(opt,'mu')
        mu = opt.mu;
    else
        mu = max(diag(H));
    end
    
    out = struct;      
    out = initialize_output_LM(out,Un,f,Fn,hn,norm(gr),mu);
    while (found == 0) && (k < opt.kmax)
        step = (H + mu*speye(size(H)))\(-gr);
        stepn = norm(step);
        if stepn < steptol*(stepn+steptol)
            found = 1;
        else
            xnew_vec = xvec + step; 
            xnew = vec2cell(xnew_vec,param);
            fnew = objective_LM(xnew,T,y,beta,opt,param);

            rho = f - fnew;
            rho = 2*rho/(step'*(mu*step-gr));
            if rho > 0   
                x = xnew;  
                xvec = cell2vec(x);
                f = fnew;         
                [~,Fn,hn,gr,H,Un] = get_values(T,x,beta,y,param,opt);
                found = (norm(gr) < opt.gradtol);

                mu = mu*max([1/3,1-(2*rho-1)^3]);
                nu = 2;
                k = k + 1;
                
                out = update_output_LM(out,Un,f,Fn,hn,norm(gr),mu,rho);
                fprintf(('It: %i, Fn: %i, hn: %i, grn: %i, Un: %i, mu: %i, stepn: %i \n'),...
                    k,Fn,hn,norm(gr),norm(xvec,'inf'),mu,stepn)
            else
                mu = mu*nu;
                nu = nu*2;
            end
        end       
    end
end