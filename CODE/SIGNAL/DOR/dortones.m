function xdor = dortones( A , f , Ns , fs )
% Generates pcal signal in time domain
% Input:
%   A           ... vector with amplitudes of tones [1,n]
%   f           ... vector with frequencies [1,]
%   Ns          ... number of samples
%   fs          ... sampling freq
% Output:
%   xpcal       ... time series of pcal signal


T   = Ns/fs; 

% generate time vector
t   = 0:1/fs:T-1/fs;

% generate pcal tone frequency vector
f_nxu   = size( f );
if f_nxu(2) == 1
    f       = f'
end



% prepare vector format of A
A_nxu   = size( A );
if A_nxu(2) == 1
    A   = A';
end

xdor = A*sin(2*pi*f'.*t);


end

