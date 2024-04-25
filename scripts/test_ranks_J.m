% Before running this script make sure that all folders are included in the 
% Matlab path.
clear 

M = 2; P = 4; N = 5; R = 33; S = 1; T = 0;

if S == 0 && T == 0
    n = sprintf('results_%d%d%d_%dR_rng1-50-10-2_randn_ALM_ul1.mat',M,P,N,R);
else
    n = sprintf('results_%d%d%d_%dR_%dS_%dT_rng1-50-10-2_randn_ALM_ul1.mat',M,P,N,R,S,T);
end
load(n);

results = res.results;
param = res.param
disp(res.opt)

%%
costs = zeros(length(results),1);
for i=1:length(results)
    if ~isempty(results{i})
        costs(i) = results{i}.cost(end);
    end
end
i1 = find(costs > 10^-100);
i2 = find(costs < 10^-12);
i = intersect(i1,i2);
fprintf('%d numerical PDs \n',length(i))

ranks = [];
svds = [];
for i=1:length(results)
    if ~isempty(results{i})
        if results{i}.cost(end) < 10^-12
            J = deriv_CPD(results{i}.Ubest,param);
            ranks = [ranks;rank(J,10^(-7))];
            svds = [svds,svd(J)];
        end
    end
end

%%
if S == 0 && T == 0
    n = sprintf('results_%d%d%d_%dR_rng1-50-10-2_randn_ALM_ul1_discr_beta0.1.mat',M,P,N,R);
else
    n = sprintf('results_%d%d%d_%dR_%dS_%dT_rng1-50-10-2_randn_ALM_ul1_discr_beta0.1.mat',M,P,N,R,S,T);
end

load(n);

results = res.results;

costs = zeros(length(results),1);
for i=1:length(results)
    if ~isempty(results{i})
        costs(i) = results{i}.cost(end);
    end
end
i1 = find(costs > 10^-100);
i2 = find(costs < 10^-12);
i = intersect(i1,i2);
fprintf('%d practical PDs \n',length(i))

ranks2 = [];
svds2 = [];
for i=1:length(results)
    if ~isempty(results{i})
        if results{i}.cost(end) < 10^-12
            J = deriv_CPD(results{i}.Ubest,param);
            ranks2 = [ranks2;rank(J,10^(-7))];
            svds2 = [svds2,svd(J)];
        end
    end
end

if exist('J','var')
    fprintf('size J: %d x %d \n',size(J,1),size(J,2))
end

ranks_unique = unique([ranks;ranks2]);
fprintf('minimal rank: %d \n',min(ranks_unique))
fprintf('maximal rank: %d \n',max(ranks_unique))
fprintf('number of different ranks: %d \n',length(ranks_unique))
