function out = initialize_output_ALM(out,Un,f,Fn,grn,hn,beta,w,nu)

    out.cost = f;
    out.CPD = Fn;
    out.grn = grn;
    out.hn = hn;
    out.beta = beta;
    out.w = w;
    out.nu = nu;
    out.Un = Un;
    out.mu = [];
    out.k_LM = [];

end