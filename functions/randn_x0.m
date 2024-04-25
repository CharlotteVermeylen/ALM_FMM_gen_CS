function x = randn_x0(param,i)
    
    M = param.M;
    N = param.N;
    P = param.P;
    n = M;
    R = param.R;

    if isfield(param,'S')  
        if (param.S+3*param.T) < param.R
            S = param.S;
            T = param.T;
            r = R-(S+3*T);

            A = 10^(-i)*randn(n^2,S);
            B = 10^(-i)*randn(n^2,T);
            C = 10^(-i)*randn(n^2,T);
            D = 10^(-i)*randn(n^2,T);
            U2 = 10^(-i)*randn(M*P-n^2,S+3*T);
            V2 = 10^(-i)*randn(N*P-n^2,S+3*T);
            W2 = 10^(-i)*randn(N*M-n^2,S+3*T);
            U4 = 10^(-i)*randn(M*P,r);
            V4 = 10^(-i)*randn(N*P,r);
            W4 = 10^(-i)*randn(N*M,r);

            x = {A,B,C,D,U2,V2,W2,U4,V4,W4};
        else 
            x = 10^(-i)*randn(M^2,R);
        end
    else
        x = {10^(-i)*randn(M*P,R),10^(-i)*randn(N*P,R),10^(-i)*randn(M*N,R)};
    end

end