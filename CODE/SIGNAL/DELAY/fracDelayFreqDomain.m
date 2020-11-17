function [Y] = fracDelayFreqDomain(X,n0)
% delay signal by fractional sample
%
% method:
%   (1) create transfer function based on linear phase shift
%   (2) multiply transferfunction with spectrum
%   (3) symmetric inverse fft
%
% input:
%   X ... signal in the frequency domain
%   n0 ... sample delay in the time domain
%
% output:
%   Y ... output signal in the frequency domain

% number of samples
N = length(X);

% create transferfunction for phase shift
[ H ] = transferfunctphaseshift( n0,N );


% apply transferfunction on signal
Y = X.*H;

end

