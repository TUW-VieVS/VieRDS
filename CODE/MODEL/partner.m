function [ params ] = partner( params )
% Calculate partner parameters
% Partner parameter:
%   When a parameter can be described with another parameters. Those parameters are partner parameters.
%   Example: 
%       Sampling rate and bandwidth are partner parameters
%       bandwidth can be expressed with sampling rate
    
% sampling rate OR bandwidth
if isfield(params,'sampling_frequency')
    params.bandwidth = params.sampling_frequency/2; % bandwidth of the signal based on the sampling rate in MHz
end
if isfield(params,'bandwidth')
    params.sampling_frequency = params.bandwidth * 2; % bandwidth of the signal based on the sampling rate in MHz
end

% time domain precision for matlab calculations
params.time_domain_precision_synthetic = 1/(params.sampling_frequency*10^6) ; % Precision of sampling interval in sec
    
% flux density + effective area OR temperature

% (A) targetsource
if isfield(params,'fluxdensity_targetsource')
    params.temp_targetsource = fluxdensity2temperature( params.fluxdensity_targetsource , params.effective_area_telescope );
    params.fluxdensity_targetsource = temperature2fluxdensity( params.temp_targetsource , params.effective_area_telescope );    
end
if isfield(params,'temp_targetsource')
    params.fluxdensity_targetsource = temperature2fluxdensity( params.temp_targetsource , params.effective_area_telescope );
    params.temp_targetsource = fluxdensity2temperature( params.fluxdensity_targetsource , params.effective_area_telescope );
end

% (B) system
if isfield(params,'fluxdensity_system')
    params.temp_system = fluxdensity2temperature( params.fluxdensity_system , params.effective_area_telescope );
    params.fluxdensity_system = temperature2fluxdensity( params.temp_system , params.effective_area_telescope );    
end
if isfield(params,'temp_system')
    params.fluxdensity_system = temperature2fluxdensity( params.temp_system , params.effective_area_telescope );    
    params.temp_system = fluxdensity2temperature( params.fluxdensity_system , params.effective_area_telescope );
end

% phase cal
if params.phase_cal_repetition_rate ~= 0
    params.phase_cal_interval = 1/params.phase_cal_repetition_rate;
    params.phase_cal_tone_YN = 1;
else
    params.phase_cal_interval = 0;
    params.phase_cal_tone_YN = 0;
end
if params.phase_cal_tone_power_perc == 0
    params.phase_cal_tone_YN = 0;
end

% precision of time domain
params.sampling_frequency_synthetic = 1/params.time_domain_precision_synthetic;

%% date
    
% mjd
params.date_mjd = modjuldat(params.date_vec(1),params.date_vec(2),params.date_vec(3),params.date_vec(4),params.date_vec(5),params.date_vec(6));

% matlab date
params.date_datetime = datetime(params.date_vec);
params.date_datetime_stop = datetime(params.date_vec + [0,0,0,0,0,params.scan_length]);

% vector
params.date_vec_stop = datevec(params.date_datetime_stop);

% doy
doy = day(params.date_datetime,'dayofyear');
params.doy = doy;

% string
yyyy = params.date_vec(1);
hh = params.date_vec(4);
mi = params.date_vec(5);
ss = params.date_vec(6);
params.date_str = sprintf('%04.0fy%03.0fd%02.0fh%02.0fm%02.0fs', yyyy, doy, hh, mi, ss );

yyyy = params.date_vec_stop(1);
hh = params.date_vec_stop(4);
mi = params.date_vec_stop(5);
ss = params.date_vec_stop(6);
params.date_str_stop = sprintf('%04.0fy%03.0fd%02.0fh%02.0fm%02.0fs', yyyy, doy, hh, mi, ss );


end

