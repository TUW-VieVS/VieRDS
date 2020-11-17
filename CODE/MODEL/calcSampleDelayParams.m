function [n,n0,dn,phi0,phi0s] = calcSampleDelayParams(tau,Tx,fa)
%
% input:
%   tau ... delay (sec)
%   Tx ... sampling interval (sec)
%   fa ... channel lower frequency limit (Hz)

n = tau/Tx;
n0 = round(n);
dn = n-n0;
[phi0,phi0s] = skyFreqPhaseOffset(fa,tau,Tx);



end

