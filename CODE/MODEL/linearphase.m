function [ n0 ] = linearphase( tau,fs )
% Calculates linear phase shift term
% linear phase shift term represents the gradient of phases to obtain a delay of tau

% Input:
%   tau ... delay in seconds of system
%   fs ... sampling rate
%
% Output:
%   n0 ... linear phase shift term

n0 = tau * fs;
    
    
end

