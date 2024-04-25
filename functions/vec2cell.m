function x = vec2cell(xvec,param)
    
    R = param.R;
    N = param.N;
    
    if isfield(param,'S') 
        if (param.S + 3*param.T) == param.R
            x = reshape(xvec,N^2,R);
        else
            M = param.M;
            N = param.N;
            P = param.P;
            n = M;
            R = param.R;
            S = param.S;
            T = param.T;
            r = R-(S+3*T);

            A = reshape(xvec(1:n^2*S),n^2,S);
            xvec(1:n^2*S) = [];

            B = reshape(xvec(1:n^2*T),n^2,T);
            xvec(1:n^2*T) = [];

            C = reshape(xvec(1:n^2*T),n^2,T);
            xvec(1:n^2*T) = [];

            D = reshape(xvec(1:n^2*T),n^2,T);
            xvec(1:n^2*T) = [];

            U2 = reshape(xvec(1:(M*P-n^2)*(S+3*T)),M*P-n^2,S+3*T);
            xvec(1:(M*P-n^2)*(S+3*T)) = [];

            V2 = reshape(xvec(1:(N*P-n^2)*(S+3*T)),N*P-n^2,S+3*T);
            xvec(1:(N*P-n^2)*(S+3*T)) = [];

            W2 = reshape(xvec(1:(N*M-n^2)*(S+3*T)),N*M-n^2,S+3*T);
            xvec(1:(M*N-n^2)*(S+3*T)) = [];

            U4 = reshape(xvec(1:M*P*r),M*P,r);
            xvec(1:M*P*r) = [];

            V4 = reshape(xvec(1:N*P*r),N*P,r);
            xvec(1:N*P*r) = [];

            W4 = reshape(xvec(1:N*M*r),N*M,r);
            xvec(1:N*M*r) = [];

            assert(isempty(xvec))

            x = {A,B,C,D,U2,V2,W2,U4,V4,W4};
        end
    else   
        M = param.M;
        P = param.P;
        n1 = M*P;
        n2 = P*N;
        n3 = M*N;
        
        x = cell(1,3);
        
        xi = xvec(1:n1*R);

        x{1} = reshape(xi,n1,R);

        xi = xvec(n1*R+1:(n1+n2)*R);

        x{2} = reshape(xi,n2,R);

        xi = xvec((n1+n2)*R+1:end);

        x{3} = reshape(xi,n3,R);
    end
end