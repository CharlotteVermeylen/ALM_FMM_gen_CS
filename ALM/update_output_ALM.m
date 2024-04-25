function out = update_output_ALM(out,Fn,beta,w,nu,k_LM,out_LM)

    out.cost = [out.cost;out_LM.cost];
    out.CPD = [out.CPD;Fn];
    out.hn = [out.hn;out_LM.hn];
    out.grn = [out.grn;out_LM.grn];
    out.beta = [out.beta;beta];
    out.w = [out.w;w];
    out.mu = [out.mu;out_LM.mu];
    out.nu = [out.nu;nu];
    out.Un = [out.Un;out_LM.Un];
    if isempty(out.k_LM)
        out.k_LM = k_LM;
    else
        out.k_LM = [out.k_LM;out.k_LM(end)+k_LM];
    end

end