function J = deriv_CPD_asym_CS(x,param)
    
    [U,V,W] = cell2factorm(x,param);
    
    P = param.P;
    T = param.T;
    M = param.M;
    N = param.N;
    S = param.S;
    R = param.R;
    r = R-(S+3*T);
    n = M;
   
    J = cell(1,S+3*T+3*R); % a_1 ... a_S b_1 ... b_T c_1 ... c_T d_1 ... d_T u_21 ... u2(S+3*T) v_21 ... v2(S+3*T) w_21 ... w2(S+3*T) u_41 ... u2r v_41 ... v2r w_21 ... w2r 
    
    I1 = zeros(M*P,n^2); % Derivative of U(:,i) to A(:,i),B(:,i),... for all i.
    I1(1:n^2,:) = eye(n^2);
    IU2 = zeros(M*P,M*P-n^2); % Derivative of U(:,i) to U2(:,i), for all i.
    IU2(end-M*P+n^2+1:end,:) = eye(M*P-n^2);
    
    I2 = zeros(N*P,n^2);  % Derivative of V(:,i) to A(:,i),B(:,i),... for all i.
    I21 = eye(n^2);
    for i=1:n
        I2(1+(i-1)*P:(i-1)*P+n,:) = I21(1+(i-1)*n:i*n,:);
    end
    
    IV2 = zeros(P*N,P*N-n^2); % Derivative of V(:,i) to V2(:,i), for all i.
    I22 = eye(P*N-n^2);
    for i=1:n
        IV2(n+1+(i-1)*P:i*P,:) = I22(1+(i-1)*(P-n):i*(P-n),:);
    end
    IV2(P*n+1:end,:) = I22(n*(P-n)+1:end,:);
    
    I3 = zeros(M*N,n^2); % Derivative of W(:,i) to A(:,i),B(:,i),... for all i.
    for i=1:n
        I3(1+(i-1)*N:(i-1)*N+n,:) = I21(1+(i-1)*n:i*n,:);
    end
    
    IW2 = zeros(M*N,M*N-n^2); % Derivative of W(:,i) to W2(:,i), for all i.
    I31 = eye(M*N-n^2);
    for i=1:n
        IW2(n+1+(i-1)*N:i*N,:) = I31(1+(i-1)*(N-n):i*(N-n),:);
    end
    
    for i = 1:S
        Ui = U(:,i);
        Vi = V(:,i);
        Wi = W(:,i);

        J{1,i} = kron(kron(eye(M*N),Vi),Ui)*I3 + kron(kron(Wi,eye(P*N)),Ui)*I2 + kron(kron(Wi,Vi),eye(M*P))*I1;     
    end
    
    I_MP = eye(M*P);
    I_NP = eye(N*P);
    I_NM = eye(N*M);
        
    for i = 1:T     
        J{1,S+i} = kron(kron(W(:,S+i),V(:,S+i)),I_MP)*I1 + kron(kron(W(:,S+T+i),I_NP),U(:,S+T+i))*I2 + kron(kron(I_NM,V(:,S+2*T+i)),U(:,S+2*T+i))*I3;
        J{1,S+T+i} = kron(kron(W(:,S+T+i),V(:,S+T+i)),I_MP)*I1 + kron(kron(W(:,S+2*T+i),I_NP),U(:,S+2*T+i))*I2 + kron(kron(I_NM,V(:,S+i)),U(:,S+i))*I3;
        J{1,S+2*T+i} = kron(kron(W(:,S+2*T+i),V(:,S+2*T+i)),I_MP)*I1 + kron(kron(W(:,S+i),I_NP),U(:,S+i))*I2 + kron(kron(I_NM,V(:,S+T+i)),U(:,S+T+i))*I3;
    end

    for i = 1:S+3*T
        J{1,S+3*T+i} = kron(kron(W(:,i),V(:,i)),I_MP)*IU2;
        J{1,2*(S+3*T)+i} = kron(kron(W(:,i),I_NP),U(:,i))*IV2;
        J{1,3*(S+3*T)+i} = kron(kron(I_NM,V(:,i)),U(:,i))*IW2;
    end
    
    for i = 1:r
        J{1,4*(S+3*T)+i} = kron(kron(W(:,S+3*T+i),V(:,S+3*T+i)),I_MP);
        J{1,4*(S+3*T)+r+i} = kron(kron(W(:,S+3*T+i),I_NP),U(:,S+3*T+i));
        J{1,4*(S+3*T)+2*r+i} = kron(kron(I_NM,V(:,S+3*T+i)),U(:,S+3*T+i));
    end

    J = cell2mat(J);

end