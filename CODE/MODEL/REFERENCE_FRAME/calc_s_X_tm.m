function s_X = calc_s_X_tm(X, s0)
% calculate the projection of the station vector onto the source vector for all time temps fo the time model vector
%
% input:
%   X   ... struct with station coordinates in CRF [m] 
%   s0  ... cartesian vector to source with unit length [m]
%
% output:
%   s_X ... station vector projected on source vector [m]

% number of time stems
N = length(X);

% preallocate struct
s_X = struct;

% calculate s_X per time stemp
for i = 1:N
    
    % calcuate vector product [m]
    s_X(i).s_X_scalar = dot(X(i).X_crf,s0);
    
    % calculate s_X in vector form by scaling s0 with length of projection [m]
    s_X(i).s_X_vec = s_X(i).s_X_scalar*s0;
    
end

end

