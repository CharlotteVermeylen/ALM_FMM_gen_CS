function Dh = deriv_equality(x,opt)

    xvec = cell2vec(x);
    Dh_zeros = eye(length(xvec));
    Dh = Dh_zeros(opt.I,:);
    
    if opt.discr == 1
        J_discr = diag(3*xvec.^2-1);
        Dh = [Dh; J_discr];
    end
    Dh = opt.beta*Dh;
    
end