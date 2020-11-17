function [x] = combCos(Ns,Nc,A,phase_offset)
% creates a comb signal based on a sum of cos functions
%
% input:
%   Ns ... length of signal (samples)
%   Nc ... comb interval in the time domain in (samples)

n = 1:Ns;

x = zeros(1,Ns);

for k = 1:Nc
    x = x + A*cos(2*pi*n*k/Nc+phase_offset);
end

x = x/(Nc);

end

