function t2c_tm = calcT2C_tm(EOP_tm, nutmod)
% calculate rotation matrix for TRF2CRF in time model resolution
%
% input:
%   EOP_tm ... struct with EOP in t_m resolution [struct]
%   nutmod ... nutation model [string]
% output:
%   t2c_tm ... struct with TRF2CRF rotation matrix in time model resolution [struct]

% number of time stemps
N = length(EOP_tm);

% preallocate struct
t2c_tm = struct;

% calculate t2c per time stemp
for i = 1:N
    
    % calculate t2c matrix
    [t2c_tm(i).t2c, ~, ~, ~] = trs2crs(EOP_tm(i).mjd, EOP_tm(i).xp, EOP_tm(i).yp, EOP_tm(i).dut1, EOP_tm(i).dX, EOP_tm(i).dY, nutmod);
    
end

end

