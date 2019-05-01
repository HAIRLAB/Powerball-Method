function [X, Y] = load_data(name)
% LOAD_DATA load a dataset
% name - dataset name, such as ctr, rcv1, ...
filename = ['data/' name '.mat'];
if ~exist(filename, 'file')
  websave(filename, ['http://data.dmlc.ml/powerball/', name, '.mat']);
end
load(filename)
