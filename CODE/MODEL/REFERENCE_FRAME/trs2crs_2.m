function t2c = trs2crs_2( t0, MJD, XP, YP, DUT1, DX, DY, eop_interp_method, nutmod )
% calculates the rotation matrix from trf to crf based on a interpolation
% of a timeseries of EOP
%
% input:
%   t0 ... time stemp to calculate the t2c rotation matrix
%   MJD ... time series of mjds
%   XP ... x-wobble time series
%   YP ... y-wobble time series
%   DUT1 ... dut1 time series
%   DX,DY ... nutation time series
%   eop_interp_method ... interpolation method
%   nutmod ... nutation method
%
% output:
%   t2c ... rotation matrix to convert a 3D vector from TRF to CRF

% EOP at t0
[ xp, yp, dut1, dX, dY ] = eopinterp( t0, MJD, XP, YP, DUT1, DX, DY, eop_interp_method );

% rot. matrix (trf -> crf)
[t2c,~,~] = trs2crs(t0, xp, yp, dut1, dX, dY, nutmod);

end

