function [g1,g2] = inequality(x,y,beta,opt)

    xvec = cell2vec(x);
    g1 = max(opt.l-(xvec+y/beta),zeros(size(xvec))); 
    g2 = max((xvec+y/beta)-opt.u,zeros(size(xvec)));
            
end