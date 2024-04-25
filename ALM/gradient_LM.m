function g = gradient_LM(x,T,y,beta,param,opt)

    y1 = y{1};
    y2 = y{2};
    
    JF = deriv_CPD(x,param);

    F = error_CPD(T,x,param);
    
    [g1,g2] = inequality(x,y2,beta,opt);
    
    h = equality(x,opt);
    
    Dh = deriv_equality(x,opt);
    
    if isempty(opt.I) && opt.discr == 0
        g = JF'*F/beta - g1 + g2;
    else
        g = JF'*F/beta - g1 + g2 + Dh'*(h+y1/beta);
    end
    
    g = g*beta;

end