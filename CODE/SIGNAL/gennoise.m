function [ y ] = gennoise( num_samples )
% Basic noise generation based on number of samples
% Normal distributed
%
% Input:    num_samples ... number of samples
% Output:   y ... time series of normal distributed values with variance of 1
%           y ~ N(0,1)

y = randn(1,num_samples);

end