clear 

M = 2; P = 4; N = 5; R = 33; S = 1; T = 2;

if S == 0 && T == 0
    n = sprintf('results_%d%d%d_%dR_rng1-50-10-2_randn_ALM_ul1.mat',M,P,N,R);
else
    n = sprintf('results_%d%d%d_%dR_%dS_%dT_rng1-50-10-2_randn_ALM_ul1.mat',M,P,N,R,S,T);
end
load(n);

results = res.results;
param = res.param
opt = res.opt

%%
costs = zeros(length(results),1);

for i=1:length(results)
    if ~isempty(results{i})
        costs(i) = results{i}.cost(end);
    end
end

[B,I] = sort(costs,'descend');
results = results(I);

%%
set(0,'defaultAxesFontSize',24)
set(groot,'defaultAxesTickLabelInterpreter','latex')

figure
subplot(1,2,1)
for i=1:length(results)
    if ~isempty(results{i})
        semilogy(results{i}.cost,'-o','color',[i/length(results),0,0.5],'linewidth',1.5,'Markersize',5)
        hold on 
    end
end
axis tight
xlabel('Iteration $k$', 'interpreter','latex')
ylabel('$f(x^{(k)})$', 'interpreter','latex')

subplot(1,2,2)
for i=1:length(results)
    if ~isempty(results{i})
        plot(results{i}.Un.^2,'-o','color',[i/length(results),0,0.5],'linewidth',1.5,'Markersize',5)
        hold on 
    end
end
axis tight
xlabel('Iteration $k$', 'interpreter','latex')
ylabel('$||x^{(k)}||^2$', 'interpreter','latex')

%%
if S == 0 && T == 0
    n = sprintf('results_%d%d%d_%dR_rng1-50-10-2_randn_ALM_ul1_discr_beta0.1.mat',M,P,N,R);
else
    n = sprintf('results_%d%d%d_%dR_%dS_%dT_rng1-50-10-2_randn_ALM_ul1_discr_beta0.1.mat',M,P,N,R,S,T);
end

load(n);

results = res.results;
param = res.param
opt = res.opt

%%
costs = zeros(length(results),1);

for i=1:length(results)
    if ~isempty(results{i})
        costs(i) = results{i}.cost(end);
    end
end

[B,I] = sort(costs,'descend');
results = results(I);

%%
set(0,'defaultAxesFontSize',24)
set(groot,'defaultAxesTickLabelInterpreter','latex')

figure
subplot(1,2,1)
for i=1:length(results)
    if ~isempty(results{i})
        semilogy(results{i}.cost,'-o','color',[i/length(results),0,0.5],'linewidth',1.5,'Markersize',5)
        hold on 
    end
end
axis tight
xlabel('Iteration $k$', 'interpreter','latex')
ylabel('$f(x^{(k)})$', 'interpreter','latex')

subplot(1,2,2)
for i=1:length(results)
    if ~isempty(results{i})
        plot(results{i}.Un.^2,'-o','color',[i/length(results),0,0.5],'linewidth',1.5,'Markersize',5)
        hold on 
    end
end
axis tight
xlabel('Iteration $k$', 'interpreter','latex')
ylabel('$||x^{(k)}||^2$', 'interpreter','latex')
