function [y] = delay3step(x,n0,dn0,phi0,ntaps,r)
% three step delay application
%   integer delay
%   fractional sample delay
%   phase offset at sky frequency
% 
% input:
%   x ... input signal
%   n0 ... integer delay
%   dn0 ... fractional-sample delay
%   ntaps ... filter length
%   r ... attenuation
%   phi0 ... phase offset


% integer delay
fprintf('Integer delay: %d\n',n0);
if n0 ~= 0
    [y] = integerDelayZeroPadding(x,n0);
else
    y = x;
end

% fraction sample delay
fprintf('Fractional sample delay: %f, ntaps: %d, r: %f\n', dn0, ntaps, r);
if dn0 ~= 0
    [y] = fractional_delay_application_fir_plus_filter_delay_correction(y,-dn0,ntaps,r);
end

% phase shift
fprintf('Phase offset: %f (°)\n',wrapTo180(rad2deg(phi0)));
if phi0 ~= 0       
    % time domain approach with hilbert transform
    fim = 'neil-robertson-blog-method';     
    [y] = phaseOffsetMethods(y,phi0,fim);
end

end

