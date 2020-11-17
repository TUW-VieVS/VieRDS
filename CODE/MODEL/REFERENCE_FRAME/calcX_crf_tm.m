function X_crf_tm = calcX_crf_tm(X_trf, t2c_tm)
% calculate X_crf in time model resolution
% 
% input:
%   X_trf ... station vector in TRF
%   t2c_tm ... struct with TRS2CRF rotation matrix in t_m resolution
%
% output:
%   X_crf_tm ... struct with CRF station coordinates in time model resolution [struct]

% number of time stemps
N = length(t2c_tm);

% preallocate struct
X_crf_tm = struct;

% transform X_trf for each time stemp
for i = 1:N
    
    % transform X_trf
    X_crf_tm(i).X_crf = t2c_tm(i).t2c*X_trf;
    
end

end

