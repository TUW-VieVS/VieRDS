function [x] = combCosIdent(Ns,Nt,Tx,Tc,A,phase_offset)
% creates a comb signal based on the expression of a sum of exponentials with the cos identity
%
% input:
%   Nt ... number of combs in the time domain
%   Tx ... sampling interval (sec)
%   Tc ... comb interval in the time domain (sec)
%   T ... signal length (sec)
%   A ... amplitude

n = 1:Ns;

x = ones(1,Ns)*A;

for k = 1:Nt
    x = x+2*A*cos(2*pi*k*n*Tx/Tc+phase_offset);
end

x = x/(2*Nt+1);

end

