function [ xp_0, yp_0, dut1_0, DX_0, DY_0 ] = eopinterp(  mjd_0, mjd, xp, yp, dut1, DX, DY, method )
% Interpolation of EOPs, either linear or with lagrange 4v interpolation
%
% Input:
%   mjd_0 ... single time stemp
%   mjd ... time series
%   xp 
%   yp 
%   dut1 
%   DX ... nutation X
%   DY ... nutation Y
%   method
%
% Output:
%   xp_0 ... polar motion angle around y-axes [rad]
%   yp_0 ... polar motion angle around x-axes [rad]
%   dut1_0 ... dut1 angle [s]
%   DX_0 ... celestial pole offset around x-axes [rad]
%   DY_0 ... celestial pole offset arond y-axes [rad]

% case: linear interpolation
if strcmp(method, 'linear')
    
    % specify extrapolation method for interpolation
    extrap_method = 'extrap';
    
    % interpolation for all EOPs seperately
    dut1_0  = interp1(mjd, dut1, mjd_0, method, extrap_method);
    xp_0    = interp1(mjd, xp, mjd_0, method, extrap_method);
    yp_0    = interp1(mjd, yp, mjd_0, method, extrap_method);
    DX_0    = interp1(mjd, DX, mjd_0, method, extrap_method);
    DY_0    = interp1(mjd, DY, mjd_0, method, extrap_method);
end

% case: lagrange interpolation
if strcmp(method, 'lagrange')
    
    % interpolation for all EOPs seperately
    dut1_0    = lagint4v(mjd, dut1, mjd_0);
    xp_0      = lagint4v(mjd, xp, mjd_0);
    yp_0      = lagint4v(mjd, yp, mjd_0);
    DX_0      = lagint4v(mjd, DX, mjd_0);
    DY_0      = lagint4v(mjd, DY, mjd_0);
end

end

