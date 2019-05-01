% n = 2e5; X = X(1:n, :); ix = sum(X); X = X(:,ix>0); Y = Y(1:n);

% %% news20 + lbfgs
% load data/news20
% name = 'news20_lbfgs_5';
% bt.lr = 1; bt.rho = .6; bt.nstep = 10;
% m = 5; max_iter = 30;

% %% news20 + lbfgs
% load data/news20
% name = 'news20_gd';
% bt.lr = .5; bt.rho = .6; bt.nstep = 10;
% m = 0; max_iter = 200;

%% rcv1 + lbfgs
load data/rcv1
name = 'rcv1_lbfgs_5';
bt.lr = 1; bt.rho = .6; bt.nstep = 10;
m = 5; max_iter = 30;
l2 = 0;

%% rcv1 + gd
load data/rcv1
name = 'rcv1_gd';
bt.lr = 1; bt.rho = .8; bt.nstep = 10;
m = 0; max_iter = 30;
l2 = 0;

%% ctr lbfgs
load ctr
name = 'ctr_lbfgs_5';
bt.lr = 1; bt.rho = .2; bt.nstep = 6;
m = 5; max_iter = 100;
l2 = 1;

%% ctr gd
load ctr
name = 'ctr_gd';
bt.lr = .05; bt.rho = .5; bt.nstep = 10;
m = 0; max_iter = 100;
l2 = 1;

%% kdd, gd
load data/kdd10
name = 'kdd_gd';
bt.lr = .05; bt.rho = .5; bt.nstep = 10;
m = 0; max_iter = 100;
l2 = 1;

%% kdd, lbfgs
name = 'kdda_lbfgs_5';
bt.lr = 1; bt.rho = .5; bt.nstep = 10;
m = 5; max_iter = 100;
l2 = 1;

%% run
gammas = [1 .7 .4 .1];
res = search_gamma(X, Y, l2, m, max_iter, gammas, bt, 10);

%% save
save(['res/' name], 'res', 'gammas')

%% draw
names = {'ctr', 'rcv1', 'kdda'};
algo = {'gd', 'lbfgs_5'};
for i = 1 : 3
  for j = 1 : 2
    name = [names{i}, '_', algo{j}];
    load(['res/' name])
    figure(1)
    clear opt;
    opt.mk={''}; opt.ls={'-', '--', '-.', ':'};
    muplot2([], res', opt)
    legend(strcat('\gamma=', num2str(gammas')))
    xlabel('iteration')
    ylabel('objective')
    savepdf(['fig/', name, '_objv'])

    figure(2)
    [~,k] = min(res);
    clear opt
    opt.ls = {''};
    opt.mk = {'x'};
    muplot2([], gammas(k), opt)
    xlabel('iteration')
    set(gca,'ytick', gammas(end:-1:1));
    ylabel('\gamma')
    ylim([0, 1]);
    savepdf(['fig/', name, '_gamma'])
  end
end
