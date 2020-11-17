function printParamOverview( params )
% print summary of input and calculates params

%% Parameter overview

fprintf('\n')
fprintf('-----------------------------------------------------------------\n')
fprintf(' Station name: %s\n\n', params.station_name )
if isfield(params,'station_name_trf_coord')
    fprintf(' Station name in TRF: %s\n\n', params.station_name_trf_coord )
end
if isfield(params,'source_name')
    fprintf(' Source: %s\n\n', params.source_name )
end

% coordinates
if isfield(params,'X_trf')
    fprintf(' TRF coordinates:                         X: %f m\n', params.X_trf(1));
    fprintf('                                          Y: %f m\n', params.X_trf(2));
    fprintf('                                          Z: %f m\n', params.X_trf(3));
    fprintf('\n')
end
if isfield(params,'X_crf_t0')
    fprintf(' Station coordinates inertial:            X: %f m\n', params.X_crf_t0(1));
    fprintf('                                          Y: %f m\n', params.X_crf_t0(2));
    fprintf('                                          Z: %f m\n', params.X_crf_t0(3));
    fprintf('\n')
end
if isfield(params,'s_crf_sph')
    fprintf(' CRF coordinates:                        ra: %f rad\n', params.s_crf_sph(1));
    fprintf('                                         de: %f rad\n', params.s_crf_sph(2));
    fprintf('\n')
end
% fprintf(' Velocity vector:                         X: %f m\n', params.velocity_antenna_vec(1));
% fprintf('                                          Y: %f m\n', params.velocity_antenna_vec(2));
% fprintf('                                          Z: %f m\n', params.velocity_antenna_vec(3));
% fprintf('\n')

% basics
fprintf(' Sampling freqeuncy                        %.10f MHz\n',params.sampling_frequency*10^-6)
fprintf(' Bandwidth                                 %.10f MHz\n',params.bandwidth*10^-6)
fprintf(' Sampling interval                         %f ns\n', params.sampling_interval*10^9)
fprintf(' Scan length                               %.3f s\n',params.scan_length)
fprintf(' Number of bits                            %.0d \n', params.number_of_bits)
fprintf(' Spectral resolution                       %f kHz\n',params.spectral_resolution*10^-3)
fprintf(' Number of samples per station             %d\n',params.num_samples_scan)
fprintf(' Center frequency of observed signal       %f MHz\n', params.f0*10^-6)
fprintf('\n')

% flux density, temperature, effective telescope area 
fprintf(' Target source flux density                %.3f Jy\n',params.fluxdensity_targetsource * 10^26 )
fprintf(' System flux density (SEFD)                %.3f Jy\n',params.fluxdensity_system * 10^26 )
fprintf(' Antenna temperature                       %.3f K\n', params.temp_targetsource )
fprintf(' System temperature                        %.3f K\n', params.temp_system )
fprintf(' Effective telescope area                  %.2f m^2\n', params.effective_area_telescope )
fprintf('\n')

% sigma
fprintf(' Sigma (amplitude) target source           %.3d V\n',params.sigma_targetsource)
fprintf(' Sigma (amplitude) target system           %.3d V\n',params.sigma_system)

% power
fprintf(' Power of source                           %.3d W\n', params.power_targetsource )
fprintf(' Power of system                           %.3d W\n', params.power_system )
if params.power_pcal == 0
    fprintf(' Power of pcal signal                      %d W\n', params.power_pcal )
else
    fprintf(' Power of pcal signal                      %.3d W\n', params.power_pcal )
end
fprintf(' Total power collected                     %.3d W\n', params.power_all )

params.TEMP = [params.temp_targetsource,params.temp_system];
params.temp_perc = params.TEMP/sum(params.TEMP);

fprintf(' SNR (vs total power):\n')
fprintf('   Source                                  %.3f%%  (%.3f dB)\n', params.SNR_source_total*100, params.SNR_source_total_db )
fprintf('   System noise flux                       %.3f%%  (%.3f dB)\n', params.SNR_system_total*100, params.SNR_system_total_db )
fprintf('   Pcal                                    %.3f%%  (%.3f dB)\n', params.SNR_pcal_total*100, params.SNR_pcal_total_db  );
fprintf(' SNR (vs system power):\n')
fprintf('   Source                                  %.3f%%  (%.3f dB)\n', params.SNR_source_system*100, params.SNR_source_system_db )
fprintf('   Pcal                                    %.3f%%  (%.3f dB)\n', params.SNR_pcal_total*100, params.SNR_pcal_total_db  );
fprintf('\n')

% phase cal
if params.phase_cal_tone_power_perc == 0
    fprintf(' No pcal signal added\n')
else
    fprintf(' Phase calibration tone pulse rate         %d MHz\n',params.phase_cal_repetition_rate*10^-6)
    fprintf(' Phase calibration tone interval           %d usec\n',params.phase_cal_pulse_interval*10^6)
    fprintf(' Phase calibration tone interval           %d samples\n',params.phase_cal_pulse_period_in_samples)
    fprintf(' Phase calibration amplitude               %d Volt\n', params.pcal_amplitude)
    fprintf(' Phase calibration phase                   %f °\n', rad2deg(params.phase_cal_phase_offset))
    fprintf(' Phase calibration frequency offset        %f MHz\n', params.phase_cal_frequency_offset*1e-6)
end
fprintf('\n')

% geometry
iwars = params.index_for_ptm_signal_arrivaL_time;
fprintf(' t0 (wavefront arrives at station)         %s\n', params.p_tm.signal_arrival_station_first_sample(iwars).datetime)
fprintf(' Delay geocenter (t0)                          %f ns\n', params.p_tm.signal_arrival_station_first_sample(iwars).tau_geocenter*1e9)
fprintf(' Delay rate (t0)                               %f ns/s\n', params.p_tm.signal_arrival_station_first_sample(iwars).delay_rate*1e9)
% fprintf(' Velocity of antenna                       %f m/s\n', params.velocity_antenna)
fprintf(' Radial velocity component wrt. source (t0)    %f m/s\n', params.p_tm.signal_arrival_station_first_sample(iwars).v_antenna_radial)
% fprintf(' Doppler shift at center frequency         %f Hz\n', params.p_tm(1).doppler_shift_f0)
% fprintf(' Loss of bandwidth due to doppler effect   %f%% \n', abs(max([params.p_tm(:).fb_doppler]) - params.fb)/params.bandwidth*100)
fprintf('\n')

% time
fprintf(' Date (wavefront arrives at geo-center)    %s\n', params.date_datetime)
fprintf(' MJD                                       %4f\n', params.date_mjd)

% other settings
fprintf(' Delay rate application method: %s\n', params.delay_rate_application_method)

% applied delays
fprintf('\n')
fprintf(' Applied delays (ns):\n')
fprintf('\t source  %f\n',params.delay_source*1e9)
fprintf('\t system  %f\n',params.delay_system*1e9)
fprintf('\t pcal    %f\n',params.delay_pcal*1e9)
fprintf('\t superp  %f\n',params.delay_super*1e9)

% applied unversial phase offsets
fprintf('\n')
fprintf(' Applied phase offsets (rad):\n')
fprintf('\t source  %f\n',params.phaseoff_source)
fprintf('\t system  %f\n',params.phaseoff_system)
fprintf('\t pcal    %f\n',params.phaseoff_pcal)
fprintf('\t superp  %f\n',params.phaseoff_super)



fprintf('-----------------------------------------------------------------\n')

end

