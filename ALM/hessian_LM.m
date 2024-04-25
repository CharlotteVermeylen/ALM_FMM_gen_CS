function H = hessian_LM(x,y,beta,opt,param)

    JF = deriv_CPD(x,param);
    xvec = cell2vec(x);
    n = numel(xvec);

    Jg = eye(n); 

    [g1,g2] = inequality(x,y{2},beta,opt);
    
    I1 = find(g1);
    I2 = find(g2);
    I = union(I1,I2); 

    Jh = deriv_equality(x,opt);
    
    J = [JF/sqrt(beta) ; Jg(I,:); Jh];
    
    H = beta*transpose(J)*J;
end