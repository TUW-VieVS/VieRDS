function p_tm = calc_params_tm(t_m, MJD, XP, YP, DUT1, DX, DY, intp_method, nutmod, X_trf, s0, dT, vel_method )
% calc kinematic model params for each model time stemp
%
% input:
%   t_m ... reference time stemps (time-model)
%   MJD ... vector of MJD [mjd]
%   XP ... vector of XP [rad]
%   YP ... vector of YP [rad]
%   DUT1 ... vector of DUT1 [s]
%   DX ... vector of DX [rad]
%   DY ... vector of DY [rad]
%   intp_method ... interpolation method
%   nutmod ... nutation model [string]
%   X_trf ... station vector in TRF
%   s0  ... cartesian vector to source with unit length [m]
%   dT ... delay_rate_difference_quotient_dT [sec]
%   vel_method ... method to calcluate the velocity of the station [string]
%   l ... label for paramters that will be attached at the end
%   of usual variable string name
%   
% output:
%   p_tm ... reference frame parameters for each model time stemp
%       mjd ... modjuldate [mjd double]
%       datetime ... date in datetime format [string]
%       xp ... x polar motion angle [rad]
%       yp ... y polar motion angle [rad]
%       dut1 ... dut1 angle [sec]
%       dX ... celestial pole offset around x-axes [rad]
%       dY ... celestial pole offset around y-axes [rad]
%       t2c ... rotation matrix between TRS and CRS
%       s_X_scalar ... length of station vector projected on source vector [m]
%       x_X_vec ... station vector projected on source vector [m,m,m]
%       tau_geocenter ... geocenter delay of station with respect to source [s]
%       v_vec ... station velocity vector [m/s]
%       v_vec_r ... radial station velocity vector wrt. source [m/s]
%       v ... magnitude of station velocity (v_vec) [m/s]
%       v_r ... magnitude of radial station velocity (v_vec_r) [m/s]
%       delay_rate ... delay rate of geocenter delay [s/s]

% number of time stemps
N = length(t_m);

% preallocate struct
p_tm = struct;

% calculate params for each time stemp
for i = 1:N
    
    % datevec of reference time stemp
    d = datevec(t_m(i));
    
    % calculate mjd of d
    p_tm(i).mjd = modjuldat(d(1),d(2),d(3),d(4),d(5),d(6));
    
    % datetime to p_m struct
    p_tm(i).datetime = t_m(i);
    
    % datenum 
    p_tm(i).datenum = datenum(t_m(i));
    
    % EOP
    [ p_tm(i).xp, p_tm(i).yp, p_tm(i).dut1, p_tm(i).dX, p_tm(i).dY ] = eopinterp( p_tm(i).mjd, MJD, XP, YP, DUT1, DX, DY, intp_method );
    
    % calculate t2c matrix
    [p_tm(i).t2c, ~, ~, ~] = trs2crs(p_tm(i).mjd, p_tm(i).xp, p_tm(i).yp, p_tm(i).dut1, p_tm(i).dX, p_tm(i).dY, nutmod);
    
    % transform X_trf to X_crf
    p_tm(i).X_crf = p_tm(i).t2c*X_trf;
    
    % calcuate vector product to get projected length on source vector [m]
    p_tm(i).s_X_scalar = dot(p_tm(i).X_crf, s0);
    
    % calculate s_X in vector form by scaling s0 with length of projection [m]
    p_tm(i).s_X_vec = p_tm(i).s_X_scalar*s0;

    % geo center delay [sec]
    p_tm(i).tau_geocenter = p_tm(i).s_X_scalar/physconst('LightSpeed');
    fprintf('\t %d: tau geocenter: %f [ns]\n', i, p_tm(i).tau_geocenter*10^9)
    
    % delta geo center delay [sec]
    p_tm(i).delta_tau_geocenter = p_tm(i).tau_geocenter - p_tm(1).tau_geocenter;
    
    % calculate (radial) velocity [m/s]
    if strcmp(vel_method,'central')
        [X_crf_t0, p_tm(i).v_antenna_vec, p_tm(i).v_antenna_vec_radial, p_tm(i).v_antenna, p_tm(i).v_antenna_radial] = central_dquotient(s0, dT,  p_tm(i).mjd, MJD, XP, YP, DUT1, DX, DY,  intp_method, nutmod, X_trf);
    end
    
    % calculate delay rate [s/s]
    p_tm(i).delay_rate = p_tm(i).v_antenna_radial/physconst('LightSpeed');
    
    % delta delay rate [s/s]
    p_tm(i).delta_delay_rate = p_tm(i).delay_rate - p_tm(1).delay_rate;
    
    % delay rate change error due discretisation [sec]
    if i == 1
        p_tm(i).delay_rate_discretisation_error = 0;
    else
        p_tm(i).delay_rate_discretisation_error = abs(p_tm(i).delay_rate - p_tm(i-1).delay_rate);
    end
    
    % doppler quotient (c+v_r/c) = 1+delay_rate
    p_tm(i).doppler_quotient = 1+p_tm(i).delay_rate ;
    
    % check velocity routines
    if X_crf_t0 ~= p_tm(i).X_crf
        warning('please check your transformation routines in the velocity calculation. It is not consistent')
    end
    
end

end