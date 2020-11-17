function [x] = combDirac(Ns,dNc,A)
% generates a comb signal in the time domain by sum of diracs (1)
%
% input:
%   A ... amplitude 
%   Ns ... number of samples 
%   dNc ... interval of comb in time domain (samples)

% check integer value of Ns and dNc
if mod(Ns,1) ~= 0
    warning('number of samples is not integer value')
end

if mod(dNc,1) ~= 0
    warning('comb interval does NOT match integer samples length')
end

x = zeros(1,Ns);
x(1:dNc:end) = A;
x = [x(2:end),0];

end

