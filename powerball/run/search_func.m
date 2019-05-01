function [res, var] = search_func(X, Y, l2, m, max_iter, func, gamma, linesearch, repeat)

w = @() randn(size(X,2),1)*.01;
Y(Y<=0) = -1; Y(Y>0) = 1;
res = []; var = [];
for f = func
  objv = zeros(repeat, max_iter);
  for r = 1 : repeat
    fprintf('func =  %g, repeat = %d\n', f, r);
    loss = @(w) logit_loss(Y, X, w, l2);
    obj = @(w, k) power_func(loss, w, k, max_iter, gamma, f);
    objv(r,:) = lbfgs(obj, w(), m, max_iter, linesearch);
  end
  res = [res; mean(objv, 1)];
  var = [var; std(objv)];
end
