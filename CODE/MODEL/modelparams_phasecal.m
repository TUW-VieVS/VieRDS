function [p] = modelparams_phasecal(p)

% Params:
%   n_pcalpulse_width
%   n_pcalpulse_width_rounded
%   phase_cal_pulse_interval
%   n_pcalpulse_interval
%   n_pcalpulse_interval_rounded

% phase cal reptition rate (Hz)
DFc = p.phase_cal_repetition_rate;

% phase cal pulse interval (sec)
p.phase_cal_pulse_interval = 1/DFc;

% bandwidth (Hz)
fbw = p.bandwidth;

% check 

% phase cal will be simulated when repition rate is non zero and not negativ
if DFc > 0
    
    % check if DFc is larger than the total bandwidth
    if DFc > fbw
        warning('Phase cal repition rate is larger than the total bandwidth. Phase cal signal will not be simulated')
        p.phase_cal_tone_YN = 0;
    end
    
    % check if DFc is smaller than sampling interval in the frequency domain
    if DFc < p.spectral_resolution
        warning('Phase cal repition rate is smaller than spectral resolution. Phase cal signal will not be simulated')
        p.phase_cal_tone_YN = 0;
    end
    
    % number of phase cal tones rounded to integer value
    p.num_pcal_tones = floor(fbw/DFc);
    
    % check if phase cal period is integer multiple of sampling interval
    if mod(p.phase_cal_pulse_interval/p.sampling_interval,1)==0
        p.phase_cal_pulse_period_in_samples = p.phase_cal_pulse_interval/p.sampling_interval;
    else
        p.phase_cal_pulse_period_in_samples = 0;
        warning('Phase cal pulse interval is not a integer multpile of the sampling interval')
        fprintf('Tpulse/Tx = %f\n',p.phase_cal_pulse_interval/p.sampling_interval)
    end
    
else
    p.phase_cal_tone_YN = 0;
    fprintf('Phase cal reptition rate is zero or negativ Hz, pcal signal not simulated\n')
end

% (1) Number of tones in spectrum
p.num_pcal_tones = floor(p.bandwidth / p.phase_cal_repetition_rate);

if p.phase_cal_tone_YN == 0
    % in this case with no phase cal pulse width specified, a value of 1234*10^9 is handed over to the next programs which will be interpreted as discrete pulses with "no" extension
    p.phase_cal_tone_power_perc = 0; % power of phase calibration tone in percentage (1% = 0.01) of total noise power
    p.phase_cal_repetition_rate = 0; % phase calibration tone repetition rate in MHz (e.g. 5 or 10 MHz)
    p.phase_cal_pulse_width = 0;
end

end

