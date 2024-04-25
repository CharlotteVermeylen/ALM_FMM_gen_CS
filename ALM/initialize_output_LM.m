function out = initialize_output_LM(out,Un,f,Fn,hn,grn,mu)

    out.cost = f;
    out.CPD = Fn;
    out.hn = hn;
    out.grn = grn;
    out.rho = [];
    out.Un = Un;
    out.mu = mu;

end