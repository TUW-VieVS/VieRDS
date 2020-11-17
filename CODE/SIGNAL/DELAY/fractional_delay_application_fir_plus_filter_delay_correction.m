function [y] = fractional_delay_application_fir_plus_filter_delay_correction(x,dn,ntaps,r)
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

% correct for integer filter delay
y= integerDelayZeroPadding(y,(ntaps-1)/2);

% apply central normalized distribution
y = (y-mean(y))/sqrt(var(y));

end

