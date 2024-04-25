function [U,V,W] = cell2factorm(x,param)

    if length(x) ~= 3
        if iscell(x)
            A = x{1};
            B = x{2};
            C = x{3};
            D = x{4};
            U2 = x{5};
            V2 = x{6};
            W2 = x{7};
            U4 = x{8};
            V4 = x{9};
            W4 = x{10};
        end

        P = param.P;
        T = param.T;
        M = param.M;
        N = param.N;
        S = param.S;
        R = param.R;
        n = M;

        U = zeros(P*M,R);
        V = zeros(P*N,R);
        W = zeros(M*N,R);

        V1 = V2(1:(P-n)*n,:);
        V2(1:(P-n)*n,:) = [];
        V3 = V2;

        for i = 1:S
            Ai = reshape(A(:,i),n,n);
            V1i = reshape(V1(:,i),P-n,n);
            W1i = reshape(W2(:,i),N-n,n);
            U(:,i) = [A(:,i) ; U2(:,i)];
            Vi = [Ai;V1i];
            V(:,i) = [Vi(:); V3(:,i)];
            Wi = [Ai;W1i];
            W(:,i) = Wi(:);
        end

        for i = 1:T
            Bi = reshape(B(:,i),n,n);
            Ci = reshape(C(:,i),n,n);
            Di = reshape(D(:,i),n,n);

            V1i = reshape(V1(:,S+i),P-n,n);
            W1i = reshape(W2(:,S+i),N-n,n);
            Vi = [Di;V1i];
            Wi = [Ci;W1i];
            U(:,S+i) = [B(:,i);U2(:,S+i)];
            V(:,S+i) = [Vi(:); V3(:,S+i)];
            W(:,S+i) = Wi(:);

            V1i = reshape(V1(:,S+T+i),P-n,n);
            W1i = reshape(W2(:,S+T+i),N-n,n);
            Vi = [Bi;V1i];
            Wi = [Di;W1i];
            U(:,S+T+i) = [C(:,i);U2(:,S+T+i)];
            V(:,S+T+i) = [Vi(:);V3(:,S+T+i)];
            W(:,S+T+i) = Wi(:);

            V1i = reshape(V1(:,S+2*T+i),P-n,n);
            W1i = reshape(W2(:,S+2*T+i),N-n,n);
            Vi = [Ci;V1i];
            Wi = [Bi;W1i];
            U(:,S+2*T+i) = [D(:,i);U2(:,S+2*T+i)];
            V(:,S+2*T+i) = [Vi(:);V3(:,S+2*T+i)];
            W(:,S+2*T+i) = Wi(:);
        end

        U(:,(S+3*T)+1:end) = U4;
        V(:,(S+3*T)+1:end) = V4;
        W(:,(S+3*T)+1:end) = W4;
    else
        U = x{1};
        V = x{2};
        W = x{3};
    end

end