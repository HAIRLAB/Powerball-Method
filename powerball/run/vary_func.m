%% ctr lbfgs, func
% load ctr
name = 'ctr_lbfgs_5_f';
bt.lr = 1; bt.rho = .2; bt.nstep = 6;
m = 5; max_iter = 100;
l2 = 1;

%% rcv1 + lbfgs + func
load data/rcv1
name = 'rcv1_lbfgs_5_f';
bt.lr = 1; bt.rho = .5; bt.nstep = 10;
m = 5; max_iter = 30;
gamma = [.1 .9];
l2 = 0;

%% news20 + lbfgs + func
load data/news20
name = 'news20_lbfgs_5_f';
bt.lr = 1; bt.rho = .5; bt.nstep = 10;
m = 5; max_iter = 30;
gamma = [.1 .9];
l2 = 0;

%% kdda + lbffgs + func
name = 'kdda_lbfgs_5_f';
bt.lr = 1; bt.rho = .2; bt.nstep = 5;
m = 5; max_iter = 100;
gamma = [.1 .9];
l2 = 1;

%% run
[res,var] = search_func(X, Y, l2, m, max_iter, [0 1 2], gamma, bt, 10);

%% save
save(['res/' name], 'res')

%% draw
names = {'ctr', 'rcv1', 'kdda'};
for i = 1 : 3
  name = [names{i} '_lbfgs_5_f'];
  load(['res/' name])
  figure(1)
  clear opt;
  opt.mk={''}; opt.ls={'-', '--', '-.', ':'};
  muplot2([], res', opt)
% legend(strcat('\gamma=', num2str(gammas')))
  legend({'baseline', 'sign(g)|g|^\gamma', 'tanh(sign(g)|g|^\gamma)|g|^\gamma'})
  xlabel('iteration')
  ylabel('objective')
  savepdf(['fig/', name, '_objv'])
end
