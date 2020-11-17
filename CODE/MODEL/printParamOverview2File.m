function printParamOverview2File( params,controling )
% print summary of input and calculates params

file_name = [controling.output_folder_long,params.station_name,'_Ch',sprintf('%03d',params.channel_id),'_modelparam.txt'];
fid = fopen(file_name,'w');


%% Parameter overview

fprintf(fid,'\n');
fprintf(fid,'-----------------------------------------------------------------\n');
fprintf(fid,' Station name: %s\n\n', params.station_name );
if isfield(params,'station_name_trf_coord')
    fprintf(fid,' Station name in TRF: %s\n\n', params.station_name_trf_coord );
end
if isfield(params,'source_name')
    fprintf(fid,' Source: %s\n\n', params.source_name );
end

% coordinates
if isfield(params,'X_trf')
    fprintf(fid,' TRF coordinates:                         X: %f m\n', params.X_trf(1));
    fprintf(fid,'                                          Y: %f m\n', params.X_trf(2));
    fprintf(fid,'                                          Z: %f m\n', params.X_trf(3));
    fprintf(fid,'\n');
end
if isfield(params,'X_crf_t0')
    fprintf(fid,' Station coordinates inertial:            X: %f m\n', params.X_crf_t0(1));
    fprintf(fid,'                                          Y: %f m\n', params.X_crf_t0(2));
    fprintf(fid,'                                          Z: %f m\n', params.X_crf_t0(3));
    fprintf(fid,'\n');
end
if isfield(params,'s_crf_sph')
    fprintf(fid,' CRF coordinates:                        ra: %f rad\n', params.s_crf_sph(1));
    fprintf(fid,'                                         de: %f rad\n', params.s_crf_sph(2));
    fprintf(fid,'\n');
end
% fprintf(fid,' Velocity vector:                         X: %f m\n', params.velocity_antenna_vec(1));
% fprintf(fid,'                                          Y: %f m\n', params.velocity_antenna_vec(2));
% fprintf(fid,'                                          Z: %f m\n', params.velocity_antenna_vec(3));
% fprintf(fid,'\n')

% basics
fprintf(fid,' Sampling freqeuncy                        %.10f MHz\n',params.sampling_frequency*10^-6);
fprintf(fid,' Bandwidth                                 %.10f MHz\n',params.bandwidth*10^-6);
fprintf(fid,' Sampling interval                         %f ns\n', params.sampling_interval*10^9);
fprintf(fid,' Scan length                               %.3f s\n',params.scan_length);
fprintf(fid,' Number of bits                            %.0d \n', params.number_of_bits);
fprintf(fid,' Spectral resolution                       %f kHz\n',params.spectral_resolution*10^-3);
fprintf(fid,' Number of samples per station             %d\n',params.num_samples_scan);
fprintf(fid,' Center frequency of observed signal       %f MHz\n', params.f0*10^-6);
fprintf(fid,'\n');

% flux density, temperature, effective telescope area 
fprintf(fid,' Target source flux density                %.3f Jy\n',params.fluxdensity_targetsource * 10^26 );
fprintf(fid,' System flux density (SEFD)                %.3f Jy\n',params.fluxdensity_system * 10^26 );
fprintf(fid,' Antenna temperature                       %.3f K\n', params.temp_targetsource );
fprintf(fid,' System temperature                        %.3f K\n', params.temp_system );
fprintf(fid,' Effective telescope area                  %.2f m^2\n', params.effective_area_telescope );
fprintf(fid,'\n');

% sigma
fprintf(fid,' Sigma (amplitude) target source           %.3d V\n',params.sigma_targetsource);
fprintf(fid,' Sigma (amplitude) target system           %.3d V\n',params.sigma_system);

% power
fprintf(fid,' Power of source                           %.3d W\n', params.power_targetsource );
fprintf(fid,' Power of system                           %.3d W\n', params.power_system );
if params.power_pcal == 0
    fprintf(fid,' Power of pcal signal                      %d W\n', params.power_pcal );
else
    fprintf(fid,' Power of pcal signal                      %.3d W\n', params.power_pcal );
end
fprintf(fid,' Total power collected                     %.3d W\n', params.power_all );

params.TEMP = [params.temp_targetsource,params.temp_system];
params.temp_perc = params.TEMP/sum(params.TEMP);

fprintf(fid,' SNR (vs total power):\n');
fprintf(fid,'   Source                                  %.3f%%  (%.3f dB)\n', params.SNR_source_total*100, params.SNR_source_total_db );
fprintf(fid,'   System noise flux                       %.3f%%  (%.3f dB)\n', params.SNR_system_total*100, params.SNR_system_total_db );
fprintf(fid,'   Pcal                                    %.3f%%  (%.3f dB)\n', params.SNR_pcal_total*100, params.SNR_pcal_total_db  );
fprintf(fid,' SNR (vs system power):\n');
fprintf(fid,'   Source                                  %.3f%%  (%.3f dB)\n', params.SNR_source_system*100, params.SNR_source_system_db );
fprintf(fid,'   Pcal                                    %.3f%%  (%.3f dB)\n', params.SNR_pcal_total*100, params.SNR_pcal_total_db  );
fprintf(fid,'\n');

% phase cal
if params.phase_cal_tone_power_perc == 0
    fprintf(fid,' No pcal signal added\n');
else
    fprintf(fid,' Phase calibration tone pulse rate         %d MHz\n',params.phase_cal_repetition_rate*10^-6);
    fprintf(fid,' Phase calibration tone interval           %d usec\n',params.phase_cal_pulse_interval*10^6);
    fprintf(fid,' Phase calibration tone interval           %d samples\n',params.phase_cal_pulse_period_in_samples);
    fprintf(fid,' Phase calibration amplitude               %d Volt\n', params.pcal_amplitude);
    fprintf(fid,' Phase calibration phase                   %f °\n', rad2deg(params.phase_cal_phase_offset));
    fprintf(fid,' Phase calibration frequency offset        %f MHz\n', params.phase_cal_frequency_offset*1e-6);
end
fprintf(fid,'\n');

% geometry
iwars = params.index_for_ptm_signal_arrivaL_time;
fprintf(fid,' t0 (wavefront arrives at station)         %s\n', params.p_tm.signal_arrival_station_first_sample(iwars).datetime);
fprintf(fid,' Delay geocenter (t0)                          %f ns\n', params.p_tm.signal_arrival_station_first_sample(iwars).tau_geocenter*1e9);
fprintf(fid,' Delay rate (t0)                               %f ns/s\n', params.p_tm.signal_arrival_station_first_sample(iwars).delay_rate*1e9);
% fprintf(fid,' Velocity of antenna                       %f m/s\n', params.velocity_antenna)
fprintf(fid,' Radial velocity component wrt. source (t0)    %f m/s\n', params.p_tm.signal_arrival_station_first_sample(iwars).v_antenna_radial);
% fprintf(fid,' Doppler shift at center frequency         %f Hz\n', params.p_tm(1).doppler_shift_f0)
% fprintf(fid,' Loss of bandwidth due to doppler effect   %f%% \n', abs(max([params.p_tm(:).fb_doppler]) - params.fb)/params.bandwidth*100)
fprintf(fid,'\n');

% time
fprintf(fid,' Date (wavefront arrives at geo-center)    %s\n', params.date_datetime);
fprintf(fid,' MJD                                       %4f\n', params.date_mjd);

% other settings
fprintf(fid,' Delay rate application method: %s\n', params.delay_rate_application_method);

% applied delays
fprintf(fid,'\n');
fprintf(fid,' Applied delays (ns):\n');
fprintf(fid,'\t source  %f\n',params.delay_source*1e9);
fprintf(fid,'\t system  %f\n',params.delay_system*1e9);
fprintf(fid,'\t pcal    %f\n',params.delay_pcal*1e9);
fprintf(fid,'\t superp  %f\n',params.delay_super*1e9);

% applied unversial phase offsets
fprintf(fid,'\n');
fprintf(fid,' Applied phase offsets (rad):\n');
fprintf(fid,'\t source  %f\n',params.phaseoff_source);
fprintf(fid,'\t system  %f\n',params.phaseoff_system);
fprintf(fid,'\t pcal    %f\n',params.phaseoff_pcal);
fprintf(fid,'\t superp  %f\n',params.phaseoff_super);



fprintf(fid,'-----------------------------------------------------------------\n');

end

