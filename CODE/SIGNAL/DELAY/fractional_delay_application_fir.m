function [y] = fractional_delay_application_fir(x,dn,ntaps,r)
% fractional delay application by use of a sinc convolution
%
% input:
%   x ... input signal
%   dn ... fraction delay [(ample)
%   ntaps ... filter length
%   r ... stop band attenuation
% 
% output:
%   y ... x delay by dn

% filter coefficients
b = frac_delay_fir(ntaps,dn,r);

% fracional delay application via convulation (filtering)
y = filter(b,1,x);

% apply central normalized distribution
y = (y-mean(y))/sqrt(var(y));

end

