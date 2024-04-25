function h = equality(x,opt)

    xvec = cell2vec(x);
    h = xvec(opt.I);
       
    if opt.discr
       h_discr = xvec.*(xvec+1).*(xvec-1);
       h = [h; h_discr];
    end
    
    h = opt.beta*h;

end