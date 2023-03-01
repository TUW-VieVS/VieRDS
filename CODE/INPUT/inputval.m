function [ p ] = inputval
% Specify input paramters

% %% global observation params (channel independent)

% sampling rate or bandwidth
p.sampling_frequency = 32; % sampling rate in MHz
% p.bandwidth = 2; % bandwidth in MHz

% scan length
p.scan_length = 1; % scan length in sec

% station name
p.station_name = 'Hb'; % two letter code

% station name for trf coordinates
p.station_name_trf_coord = 'Hb'; % two letter code

% delay rate application method
% p.delay_rate_application_method = 'multiple-non-uniform-fft';
% p.delay_rate_application_method = 'single-non-uniform-fft';
% p.delay_rate_application_method = 'time-domain-sample-phase_shift';
p.delay_rate_application_method = 'single-side-band-modulation';

% number of bits
p.number_of_bits = 2;

% date
p.date_vec = [2019, 1, 24, 11, 0, 0];

% source name
p.source_name = '1849+670';

% VDIF
p.frame_length_byte            = 8032;
p.header_length_byte           = 32;
p.vdif_version_number          = 1;

% VEX
p.recorder_transport_type_name = 'Flexbuff';
p.mode_observation = 'sim-0001';
p.site_type = 'fixed';
p.station_name_8character = 'STATION1';
p.site_position_ref = 'sked_position.cat';
p.occupation_code = '0000000';
p.source_type = 'star';
p.ref_coord_frame = 'J2000';
p.polarization = 'R';
p.IF_sideband = 'U';
p.obs_sideband_vex = 'U';

% Source location from CRF or user defined
%p.s_crf = [0, 0]'; % comes into play when zero-baseline is deactivated

% Station location from TRF or user defined
% p.X_trf = [0, 0, 0]'; % comes into play when zero-baseline is deactivated

%% multi channel params
% Center frequency of observed signal
p.f0 = 8212.99; % center frequency of observed signal in MHz

% Bandpass filter
% p.bandpass_filter_name = 'none';
p.bandpass_filter_name = 'default';
p.bandpass_fa_cutoff_perc = 0.01;
p.bandpass_fb_cutoff_perc = 0.99;
p.bandpass_number_of_filter_coefficients = 400;

% Fractional delay filter
p.fractional_delay_filter_ntaps = 101;
p.fractional_delay_filter_stopBandAtt = 140;


% quantization factor (percentage of sigma in quantization)
p.qfact = 1.08;

% Delay tau plus 
% additional delay independend of delay calculated from apriori station coordinates (delay_tau_plus_sec)
% crucial for zero baseline observation (to be able to apply a zero baseline delay)
p.delay_source = 0; % ns
p.delay_system = 0;
p.delay_pcal = 0;
p.delay_super = 0;

% phase offset 
p.phaseoff_source = 0; % rad
p.phaseoff_system = 0;
p.phaseoff_pcal = 0;
p.phaseoff_super = 0;

%% BLOCKS:

% Flux density + effective area OR temperature

    % (A) targetsource
    p.fluxdensity_targetsource = 1; % flux density target source in Jy
    % p.temp_targetsource = 0.02; % antenna temperature of target source in K

    % (B) system
    p.fluxdensity_system = 3000; % flux density system in Jy
    % p.temp_system = 70; % temperature of system (system temperature) in K

    % (C) effective telescope area
    p.effective_area_telescope = 100*0.5; % effective area of telescope in m^2

% Phase cal

    % Phase cal tone power perc (%)
    p.phase_cal_tone_power_perc = 0; % power of phase calibration tone in percentage (1% = 0.01) of total noise power

    % Phase cal frequency spacing (repition rate)
    p.phase_cal_repetition_rate = 0; % phase calibration tone repetition rate in MHz (e.g. 5 or 10 MHz)
 
    % Phase cal frequency offset (Hz)
    p.phase_cal_frequency_offset = 0;
    
    % Phase cal channel phase offset (deg)
    p.phase_cal_phase_offset = 0;
       
    % Phase cal tone phase offset file
    p.phase_cal_tone_phase_offset_file = '';
    
    % Phase cal tone phase offset
    p.phase_cal_tone_phase_offset = [];
   
% Target source
    % signal type of target source
    p.signal_type_target_source = 'gaussian-white-noise';
    % p.signal_type_target_source = 'APOD';
%     p.signal_type_target_source = 'gaussian-white-noise-arbitrary-magnitude';

    % value of signal type
    p.signal_value_target_source = NaN;

% arbitrary amplitude filter
    % in case 'gaussian-white-noise-arbitrary-magnitude' is selected
%     p.arb_mag_file = '';
    p.arb_mag_interpolation_res = 1e6; % MHz
    p.arb_mag_filter_order = 300;
    p.arb_mag_filter_design = 'FIR-modeling-with-frequency-sampling-method';
    p.arb_mag_filter_signal_type = 'source'; % source, system, pcal, super
    
% Time model for parameter calculation

    % type of time model creation (look for possible input in function which calls this parameter)
    p.tm_reference_point_type = 'multiple';
    
    % time period before and after scan start and stop (rounded values to sec) [sec]
    p.time_model_period_before_scan_start_sec = 0;
    
    % discretisation time intervall for time model [sec]
    p.time_model_discretisation_intervall_sec = 2.5e-1;
    
    % adjustable model reference time (if 0 model params will be calculated for start of scan) [sec]
    p.tm_adjustable_time_offset = 0.0; 

    % difference quotient method to calculate delay rate
    p.delay_rate_method_difference_quotient = 'central';

    % difference quotient time intervall [sec]
    p.delay_rate_difference_quotient_dT = 1e-3;
    
    % interpolation interval for delay rate [sec]
    p.delay_rate_interpolation_interval = 1e-3;
    
    % interpolation method for delay rate
    p.delay_rate_interpolation_method = 'linear';

%% vdif
p.vdif_special_label_str = 'sim';
p.vdif_special_label_int = '0';

%% mpsd
% false
p.mpsd_i = 0;

%% delay and delay rate configuration
p.delay_rate_application_YN = 1;
p.delay3step_YN = 1;

end

