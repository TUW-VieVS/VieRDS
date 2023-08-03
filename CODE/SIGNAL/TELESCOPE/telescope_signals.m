function p = telescope_signals(p)
% creates all the telescope individual signal streams (noise, pcal, ...)
% the signals are also amplitude scaled!

%% system noise

% signal generation
x = gennoise( 1, p.num_samples_scan );
% x = sparse( 1, p.num_samples_scan );

% create standard normal distribution
p.x_system = p.sigma_system*(x - mean(x))/sqrt(var(x));

fprintf('system noise generated: %d (V)\n', p.sigma_system );

% delete tmp signal
clear x;

%% phase calibration signal

if p.phase_cal_tone_YN  == 0
    
    % no pcal signal generation
    
    % set pcal puls NaN (x ... time domain, X ... frequency domain)
    p.x_pcal = [];
    
    % test for strange code behaviour
    if p.power_pcal ~= 0
        error('Something wrong with power pcal estimation')
    end
    
else
    
    % number of phase cal tones
    Nto = p.num_pcal_tones;
    
    % pcal signal will be generated
    fprintf('phase cal signal will be generated, %d (#tones), %d V, %d MHz\n', Nto, p.pcal_amplitude, p.phase_cal_repetition_rate*10^-6  )
    fprintf('\ttone phase offset:\n')
    disp(num2str(p.phase_cal_tone_phase_offset))
    
    % pcal signal
    p.x_pcal = generatePcalSignal(p.pcal_amplitude,p.phase_cal_repetition_rate,p.sampling_interval,p.scan_length,Nto,p.phase_cal_frequency_offset,p.phase_cal_tone_phase_offset); 
    
end

end
