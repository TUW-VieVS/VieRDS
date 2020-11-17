function y = quant2( x , qf )
% two bit sampling of x with adjustable size of central bit range
% Input:
%   x                   ... time series
%   qf               ... percentag of 1 sigma
%
% Output:
%   y     ... quantized time series
%
%       |-------------|-------------|
%      -1             0             1
% e.g. 
%       |------|------|------|------|   (perc_central_bit = 0.5)
%          1      2      3       4      (sampled values of x_quant)
% e.g.
%       |---------|---|---|---------|   (perc_central_bit = 0.25)
%            1      2   3      4        (sampled values of x_quant)
% e.g.
%       |---|---------|---------|---|   (perc_central_bit = 0.75)
%         1      2         3      4     (sampled values of x_quant)

% length of input signal
Nx = length(x);

% sigma of x
sigma_x = sqrt( var( x ) );

% mean value of x
mean_x      = mean( x );

% normalized x (sigma = 1)
x_norm      = ( x - mean_x ) / sigma_x;

% indicies for ranges
ind_1 = x_norm < -qf;
ind_2 = -qf <= x_norm & x_norm < 0;
ind_3 = 0 <= x_norm & x_norm < qf;
ind_4 = qf <= x_norm;

total_sum = sum(ind_1) + sum(ind_2) + sum(ind_3) + sum(ind_4);
fprintf('\tqfact: %.2f\n',qf)
fprintf('\tnum of samples    -1  < %d       : %d %.0f%%\n',-qf,sum(ind_1), sum(ind_1)/total_sum*100)
fprintf('\tnum of samples  %d <= x_norm < 0 : %d %.0f%%\n',-qf,sum(ind_2), sum(ind_2)/total_sum*100)
fprintf('\tnum of samples   0 <= x_norm < %d : %d %.0f%%\n',qf,sum(ind_3), sum(ind_3)/total_sum*100)
fprintf('\tnum of samples      %d < 1       : %d %.0f%%\n',qf,sum(ind_4), sum(ind_4)/total_sum*100)

N_check = sum(ind_1)+sum(ind_2)+sum(ind_3)+sum(ind_4);
if N_check ~= Nx
    warning('Quantization went wrong, not all samples detected')
end

y = zeros(1,Nx);
y(ind_1) = 1*ones(1,sum(ind_1));
y(ind_2) = 2*ones(1,sum(ind_2));
y(ind_3) = 3*ones(1,sum(ind_3));
y(ind_4) = 4*ones(1,sum(ind_4));

y = y - 2.5;

end