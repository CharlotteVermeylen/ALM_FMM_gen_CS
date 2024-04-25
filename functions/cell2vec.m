function xvec = cell2vec(x)

    xvec = [];
    
    if iscell(x)
        for i=1:length(x)
            xi = x{i};
            xvec = [xvec; xi(:)];      
        end
    elseif isstruct(x)
        xvec = [x.U(:);x.V(:);x.W(:)];
    else
        xvec = x(:);
    end
    
end