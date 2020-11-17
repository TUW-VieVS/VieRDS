function y = quant1(x)
% one bit quantization
%
% Input: x ... time series
% Output: x_quant ... quantized time series

Nx                  = length(x);

x_max               = max(abs(x(:)));
x_norm              = x/x_max;
x_max_test = max(abs(x_norm));
if x_max_test > 1
    warning('normalization went wrong')
end
ind_cutu            = x_norm >= 0;
ind_cutl            = x_norm < 0;
total_sum = sum(ind_cutu) + sum(ind_cutl);

fprintf('\tnum of samples >= 0 : %d %.0f%%\n',sum(ind_cutu), sum(ind_cutu)/total_sum*100)
fprintf('\tnum of samples <  0 : %d %.0f%%\n',sum(ind_cutl), sum(ind_cutl)/total_sum*100)

y = zeros(1,Nx);
y(ind_cutu)    = 1/2*ones(1,sum(ind_cutu));
y(ind_cutl)    = -1/2*ones(1,sum(ind_cutl));

num_samples = sum(ind_cutu)+sum(ind_cutl);

if num_samples ~= Nx
    warning('Quantization went wrong')
end
end