function p_tm = zero_kinematic( s )
% kinematic model params all set to zero
% p_tm.mjd = s.date_mjd;

pp.mjd = s.date_mjd;
pp.datetime = 0;
pp.datenum = 0;
pp.xp = [];
pp.yp = [];
pp.dut1 = [];
pp.dX = [];
pp.dY = [];
pp.t2c = [];
pp.X_crf = zeros(1,3);
pp.s_X_scalar = 0;
pp.s_X_vec = zeros(1,3);
pp.tau_geocenter = 0;
pp.signal_arrival_geocenter = pp.mjd;
pp.delta_tau_geocenter = 0;
pp.v_antenna_vec= 0;
pp.v_antenna_vec_radial= 0;
pp.v_antenna= 0;
pp.v_antenna_radial = 0;
pp.delay_rate = 0;
pp.delta_delay_rate = 0;
pp.doppler_quotient = 0;
pp.signal_arrival_station_first_sample=0;
pp.signal_arrival_station_center_sample=0;

p_tm.signal_arrival_geocenter = pp;
p_tm.signal_arrival_station_first_sample = pp;
p_tm.signal_arrival_station_center_sample = pp;

end

