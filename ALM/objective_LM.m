function f = objective_LM(x,T,y,beta,opt,param)
        
    y1 = y{1};
    y2 = y{2};
    
    F = error_CPD(T,x,param);
    
    [g1,g2] = inequality(x,y2,beta,opt);
     
    h = equality(x,opt);
    
    f = [F/sqrt(beta); g1; g2; h+y1/(beta)];
   
    f = 0.5*beta*norm(f)^2;
    
end
