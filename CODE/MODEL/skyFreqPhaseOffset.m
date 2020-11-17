function [phi0_rad,phi0_sample] = skyFreqPhaseOffset(f0,tau,Tx)
% calculates the phase offset at sky frequency
%
% input:
%   f0 ... sky frequency (Hz)
%   tau ... delay (sec)
%   Tx ... sampling intervall (sec)
%
% output:
%   phi0_rad ... phase offset at f0 (rad)
%   phi0_sample ... phi0 (samples)

phi0_rad = -2*pi*f0*tau;
phi0_sample = wrapTo2Pi(phi0_rad)/(2*pi)*Tx;

end

