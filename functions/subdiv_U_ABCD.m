function [A,B,C,D] = subdiv_U_ABCD(U,param)

    A = U(:,1:param.S);
    B = U(:,param.S+1:param.S+param.T);
    C = U(:,param.S+param.T+1:param.S+2*param.T);
    D = U(:,param.S+2*param.T+1:end);
    
end