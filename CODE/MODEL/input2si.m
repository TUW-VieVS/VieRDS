function [ params ] = input2si( params )
% Transform from Input to SI units
% for loop trough all existing params and convert into SI units

params.verbosity_nr = 0;

fn = fieldnames(params);
for ifn = 1:length(fn)
    curr_name = fn{ifn};
    
    if strfind(curr_name,'_YN')
        continue;
    end
    
    if params.verbosity_nr > 2; fprintf(' check %s\n',curr_name); end
    
    % sampling rate MHz --> Hz
    if strcmp(curr_name,'sampling_frequency')
        params.sampling_frequency = params.sampling_frequency*10^6;
    end
    
    % bandwidth MHz --> Hz
    if strcmp(curr_name,'bandwidth')
        params.bandwidth = params.bandwidth*10^6;
    end
    
    % f0 MHz --> Hz
    if strcmp(curr_name,'f0')
        params.f0 = params.f0*10^6;
    end
    
    % flux density target source Jy --> W*m^-2*Hz^-1 = Jy *10^-26 
    if strcmp(curr_name,'fluxdensity_targetsource')
        params.fluxdensity_targetsource = params.fluxdensity_targetsource * 10^-26;
    end
    
    % flux density receiver (SEFD) Jy --> W*m^-2*Hz^-1 = Jy *10^-26 
    if strcmp(curr_name,'fluxdensity_system')
        params.fluxdensity_system = params.fluxdensity_system *10^-26;
    end
      
    % phase calibration repetition rate MHz --> Hz
    if strcmp(curr_name,'phase_cal_repetition_rate')
        params.phase_cal_repetition_rate = params.phase_cal_repetition_rate*10^6;
    end
    
    % phase calibration tone interval usec --> sec
    if strcmp(curr_name,'phase_cal_pulse_interval')
        params.phase_cal_pulse_interval = params.phase_cal_pulse_interval*10^-6;
    end
    
    % phase calibration pulse width
    if strcmp(curr_name,'phase_cal_pulse_width')
        params.phase_cal_pulse_width = params.phase_cal_pulse_width*10^-9;
    end
    
    % phase calibration offset
    if strcmp(curr_name,'phase_cal_phase_offset')
        params.phase_cal_phase_offset = deg2rad(params.phase_cal_phase_offset);
    end  
    
    % phase calibration delay
    if strcmp(curr_name,'phase_cal_delay')
        params.phase_cal_delay = params.phase_cal_delay*1e-12;
    end  
    
    % delay_source
    if strcmp(curr_name,'delay_source')
        params.delay_source = params.delay_source*1e-9;
    end
    % phase calibration delay
    if strcmp(curr_name,'delay_system')
        params.delay_system = params.delay_system*1e-9;
    end
    % phase calibration delay
    if strcmp(curr_name,'delay_super')
        params.delay_super = params.delay_super*1e-9;
    end
    % phase calibration delay
    if strcmp(curr_name,'delay_pcal')
        params.delay_pcals = params.delay_pcal*1e-9;
    end
end

end

