function [x] = generatePcalSignal(A, DFc, Tx, T, Nt, DFoffset,phase_offset)
%
% Input:
%   A ... amplitude
%   DFc ... phase cal frequency spacing
%   Tx ... sampling interval
%   T ... signal length
%   Nt ... number of tones
%   DFoffset ... frequency offset
%   phase_offset ... phase offset

% time vector
t = 0:Tx:T-Tx;

% pre-allocate
x = zeros(1,length(t));

% set phase_offset to zeros if phase_offset is empty
if isempty(phase_offset)
    phase_offset = zeros(1,Nt);
end

fprintf('tone: ')
% for each tone
for k = 1:Nt
    fprintf('.')
    phi = 2*pi*(k*DFc+DFoffset)*t+phase_offset(k);
    x = x + A*cos(phi);
end

fprintf('\n')

end

