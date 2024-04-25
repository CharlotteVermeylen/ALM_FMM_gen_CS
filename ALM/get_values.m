function [f,Fn,hn,gr,H,Un] = get_values(T,x,beta,y,param,opt)

    xvec = cell2vec(x);
    Un = norm(xvec);
    
    f = objective_LM(x,T,y,beta,opt,param); 

    F = error_CPD(T,x,param);
    Fn = norm(F);

    h = equality(x,opt);
    hn = norm(h);
    
    H = hessian_LM(x,y,beta,opt,param);

    gr = gradient_LM(x,T,y,beta,param,opt);

end