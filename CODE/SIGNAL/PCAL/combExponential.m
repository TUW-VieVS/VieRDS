function [x] = combExponential(Ns,Nc,A,phase_offset)
% creates a comb signal based on a sum of expontial functions
%
% input:
%   Ns ... length of signal (samples)
%   Nc ... comb interval in the time domain in (samples)

n = 1:Ns;

x = zeros(1,Ns);

for k = 1:Nc
    x = x + A/Nc*exp(1i*2*pi*n*k/Nc+phase_offset);
end

end

