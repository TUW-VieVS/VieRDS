function [X_crf_t0, v_vec, v_vec_r, v,v_r] = central_dquotient(s0, dT, t0, MJD, XP, YP, DUT1, DX, DY, eop_interp_method, nutmod, X_trf)
% calculates velocity model parameters based on "central difference quotient" method
%
% input:
%   s0 ... source vector [cart]
%   dT ... difference quotient time length [sec]
%   t0 ... reference time stemp [mjd]
%   MJD ... time series of mjds
%   XP ... x-wobble time series
%   YP ... y-wobble time series
%   DUT1 ... dut1 time series
%   DX,DY ... nutation time series
%   eop_interp_method ... interpolation method
%   nutmod ... nutation method
%   X_trf ... station position in TRF
%
% output:
%   X_t0 ... CRF station coordinates at t0
%   tau_geocenter_t0 ... geocenter delay for X_t0
%   dx ...velocity vector
%   dx_s0 ... velocity vector projected on source vector
%   v ... station velocity value [m/s]
%   v_radial ... station velocity (radial component) value [m/s]
%   delay_rate ... delay rate [s/s]

% convention for time boundaries:
%   ta = t0-dt/2;
%   tb = t0+dt/2;

%% time borders
% first time boarder [mjd]
ta = t0-dT/2*secscale;

% last time boarder [mjd]
tb = t0+dT/2*secscale;

%% rotation matrices
% rotation matrix for ta
t2c_ta = trs2crs_2( ta, MJD, XP, YP, DUT1, DX, DY, eop_interp_method, nutmod );

% rotation matrix for tb
t2c_tb = trs2crs_2( tb, MJD, XP, YP, DUT1, DX, DY, eop_interp_method, nutmod );

% rotation matrix for t0
t2c_t0 = trs2crs_2( t0, MJD, XP, YP, DUT1, DX, DY, eop_interp_method, nutmod );

%% station vectors in CRF
% X_crf_t0 ... station vector in CRF at t0
X_crf_t0 = t2c_t0*X_trf;

% X_crf_ta ... station vector in CRF at ta
X_crf_ta = t2c_ta*X_trf;

% X_crf_tb ... station vector in CRF at tb
X_crf_tb = t2c_tb*X_trf;

%% length of station vectors projected on source direction
% s_X_t0 ... station vector projected onto source direction 
s_X_t0 = dot(X_crf_t0, s0);

% s_X_ta
s_X_ta = dot(X_crf_ta, s0);

% s_X_tb
s_X_tb = dot(X_crf_tb,s0);

%% station vectors projected on source direction
% svec_X_t0
svec_X_t0 = s_X_t0*s0;

% svec_X_ta
svec_X_ta = s_X_ta*s0;

% svec_X_tb
svec_X_tb = s_X_tb*s0;

%% difference quotient: dX
% X(tb)-X(ta), direction of velocity [m]
dX = X_crf_tb-X_crf_ta;

% s_X(tb)-s_X(ta), direction of radial velocity [m]
dX_s0 = svec_X_tb-svec_X_ta;

% is the antenna moving in direction of source vector or opposite of the
% source vector
if norm(s0+dX_s0)/(norm(s0)+norm(dX_s0)) < norm(s0)
    v_r_sign = -1;
else
    v_r_sign = 1;
end


%% vector difference quotient: v_vec=dX/dT
% velocity vector [m/s]
v_vec = dX/dT;

% radial velocity vector [m/s]
v_vec_r = dX_s0/dT;

%% velocity magnitude difference quotient: v=||v_vec||
% velocity [m/s]
v = norm(v_vec);

% radial velocity [m/s]
v_r = v_r_sign*norm(v_vec_r);

end

