function x = delay_signal(x,n0,dn0,phi0)

% input:
%   x ... input signal
%   n0 ... integer delay
%   dn0 ... fractional sample delay
%   phi0 ... delay_tau_plus_phase_offset_at_fa_rad


% rounded sample delay
if n0 ~= 0
    x = circshift(x,-n0);
end


% fractional sample delay. applies the remaining delay (integer delay -
% input delay) via a circular shift implemented with a complex phase
% rotation. the applied phase sloped is something between 0 and
% pm 2*pi/fs. Since this application yields non-symmetric frequency
% spectrum, when transformed to the time domain only a symmetric
% spectrum is created to get a real valued signal
fprintf('fractional sample delay: %f\n',dn0)

% check if there is a non-zero fractional sample delay
if dn0 ~= 0      
    x = fractional_delay_application_fir_plus_filter_delay_correction(x,-dn0,101,140);    
end

% apply constant phase offset to to all spectral components. Since the
% integer and fractional delay application only applies a phase slope
% which means that the phase is zero at the lower frequency limit.
% (like a line without a y-shift at zero). To account for this
% cirumstance, and it is required to enable multiband delays, a
% constant phase offset has to be applied to all spectral components.
% This is realized with a complex phase rotation of a constant factor


fprintf('phase offset: %f [rad]\n',phi0)

% phase offset
if phi0 ~= 0       
    % time domain approach with hilbert transform
    fim = 'neil-robertson-blog-method';     
    [x] = phaseOffsetMethods(x,phi0,fim);
end


end

