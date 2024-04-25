function out = update_output_LM(out,Un,f,Fn,hn,grn,mu,rho)

    out.cost = [out.cost;f];
    out.CPD = [out.CPD;Fn];
    out.hn = [out.hn;hn];
    out.grn = [out.grn;grn];
    out.rho = [out.rho;rho];
    out.mu = [out.mu;mu];
    out.Un = [out.Un;Un];

end