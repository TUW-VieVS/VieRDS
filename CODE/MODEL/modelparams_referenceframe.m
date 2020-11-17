function p = modelparams_referenceframe(p, r, controling)
% calculate station params based on coordinate reference frame
%

% input:
%   p ... station params struct
%   r ... reference database struct
%   controling ... control struct
%
% output:
%   p ... station param struct with updated params
%       X_trf ... station coordinate vector in TRF (if already exists will NOT be overwritten)
%       take_TRF_coord ... flag to indicate if station coordinates are loaded from TRF DB
%       s_crf_sph ... source coordinates vector (ra,de) in CRF (if already exists will NOT be overwritten)
%       s_crf_cart ... source coordinate vector (x,y,z) in CRF
%       take_CRF_coord ... flag to indicate if source coordinates are loaded from CRF DB
%       p_tm struct:
%           mjd ... modjuldate [mjd double]
%           datetime ... date in datetime format [string]
%           xp ... x polar motion angle [rad]
%           yp ... y polar motion angle [rad]
%           dut1 ... dut1 angle [sec]
%           dX ... celestial pole offset around x-axes [rad]
%           dY ... celestial pole offset around y-axes [rad]
%           t2c ... rotation matrix between TRS and CRS
%           s_X_scalar ... length of station vector projected on source vector [m]
%           x_X_vec ... station vector projected on source vector [m,m,m]
%           tau_geocenter ... geocenter delay of station with respect to source [s]
%           v_vec ... station velocity vector [m/s]
%           v_vec_r ... radial station velocity vector wrt. source [m/s]
%           v ... magnitude of station velocity (v_vec) [m/s]
%           v_r ... magnitude of radial station velocity (v_vec_r) [m/s]
%           delay_rate ... delay rate of geocenter delay [s/s]      

% load station coordinates: X_trf
[p.X_trf, p.take_TRF_coord] = create_st_coord(p, r);

% load source coordinates: s_crf
[p.s_crf_sph, p.s_crf_cart, p.take_CRF_coord] = create_sr_coord(p, r);

% time stemps for model parameter calculation
t_m = get_timemodel_ref_dates( p.date_datetime,p.date_datetime_stop,p.time_model_period_before_scan_start_sec, p.time_model_discretisation_intervall_sec, p.tm_adjustable_time_offset, p.tm_reference_point_type );

% check if date is after latest leap second (there might be a new leap second)
leapsec_message(p.date_mjd, modjuldat(2017,12,31,0));

% get EOP in daily resolution [d,rad,sec]
[EOP_daily.MJD, EOP_daily.XP, EOP_daily.YP, EOP_daily.DUT1, EOP_daily.DX, EOP_daily.DY, EOP_daily.LEAP ] = load_eop(p.date_mjd, controling.EOPfile); % [d,rad,sec]

% calc kinematic model params for each model time stemp
% when wave-front arrives at geo-center
p.p_tm.signal_arrival_geocenter = calc_params_tm(t_m, EOP_daily.MJD, EOP_daily.XP, EOP_daily.YP, EOP_daily.DUT1, EOP_daily.DX, EOP_daily.DY, controling.eop_interp_method , controling.nutmod, p.X_trf, p.s_crf_cart, p.delay_rate_difference_quotient_dT, p.delay_rate_method_difference_quotient );

% signal arrival time at station
[p.signal_arrival_time,p.signal_arrival_time_offset,p.index_for_ptm_signal_arrivaL_time] = determineSignalArrivalTime(p.date_datetime,[p.p_tm.signal_arrival_geocenter(:).datetime],[p.p_tm.signal_arrival_geocenter(:).tau_geocenter],[p.p_tm.signal_arrival_geocenter(:).delay_rate]);

% re-calc kinematic model params for each model time stemp with offset
% when wave-front arrives at station
t_m_signal_arrival_station = t_m-seconds(p.signal_arrival_time_offset);
p.p_tm.signal_arrival_station_first_sample = calc_params_tm(t_m_signal_arrival_station, EOP_daily.MJD, EOP_daily.XP, EOP_daily.YP, EOP_daily.DUT1, EOP_daily.DX, EOP_daily.DY, controling.eop_interp_method , controling.nutmod, p.X_trf, p.s_crf_cart, p.delay_rate_difference_quotient_dT, p.delay_rate_method_difference_quotient );

% re-calc kinematic model params for each model time stemp with offset
% when wave-front arrives at station, but in the center of the
% interpolation points
t_m_signal_arrival_station_cs = t_m_signal_arrival_station+seconds(p.time_model_discretisation_intervall_sec/2);
p.p_tm.signal_arrival_station_center_sample= calc_params_tm(t_m_signal_arrival_station_cs, EOP_daily.MJD, EOP_daily.XP, EOP_daily.YP, EOP_daily.DUT1, EOP_daily.DX, EOP_daily.DY, controling.eop_interp_method , controling.nutmod, p.X_trf, p.s_crf_cart, p.delay_rate_difference_quotient_dT, p.delay_rate_method_difference_quotient);


% EOP for VEX file
p.EOP_vex = createEOPvex(EOP_daily);

end

