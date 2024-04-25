function T = multiplication_tensor(M,P,N)

    T = zeros(M*P,P*N,M*N);

    for i=1:M
        for j=1:P
            for k=1:N
                T(i+(j-1)*M,j+(k-1)*P,k+(i-1)*N) = 1;
            end
        end
    end
end