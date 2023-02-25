function [J] = mps2channel(fa, fb, fa_mp, fb_mp)
% allocate source signal(s) to frequency channel
% input:
%   fa ... lower-frequency limit of channel (Hz)
%   fb ... upper-frequency limit of channel (Hz)
%   fa_mp ... vector of lower-frequency limits of source signals (Hz)
%   fb_mp ... vector of upper-frequency limits of source signals (Hz)

% number of entries
Nmps = length(fa_mp);

% pre-allocate match vector
J = zeros(1, Nmps);

% loop through MPS entries
for i=1:Nmps
    
    % case 1: channel lies in mps channel
    if fa_mp(i) <= fa && fb <= fb_mp(i)
        
        % assign line number
        J(i) = 1;
        
    end 

end