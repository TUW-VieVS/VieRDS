function [Y] = phaseOffset(X,phi0)
% constant phase offset is added to all spectral components
%
% input:
%   X ... input signal in the frequency domain
%   phi0 ... phase offset (rad)
%
% output:
%   Y ... output signal
%

% apply phase offset to X
Y = X.*exp(-1i*phi0);

end

