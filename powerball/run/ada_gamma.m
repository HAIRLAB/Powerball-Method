names = {'ctr', 'kdda', 'rcv1'};
for i = 1 : 3
  file = names{i};

  load(['res/' file '_lbfgs_5']);
  a = res;
  load(['res/' file '_lbfgs_5_f']);
  b = res;
  c = bsxfun(@rdivide, bsxfun(@minus, a(2:end,:), b(2,:)), b(2,:))*100;
  opt.mk={''}; opt.ls={'-', '--', '-.', ':'};
  muplot2([],c',opt)
  legend(strcat('\gamma=', num2str(gammas(2:end)')))

  if i == 2
    ylim([-0.2 .8]*100)
  elseif i == 1
    ylim([-0.1 1]*100)
  elseif i == 3
    ylim([-50 350])
  end
  xlabel('iteration')
  ylabel('relative objective (%)');
  savepdf(['fig/', file, '_adaptive'])
end
