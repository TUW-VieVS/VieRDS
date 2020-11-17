function [p] = modelparams_power(p)

% source power
p.power_targetsource   = temp2power ( p.temp_targetsource , p.bandwidth );

% system power
p.power_system         = temp2power( p.temp_system , p.bandwidth );

% relative pcal power (% to [0,1] conversion)
p.power_pcal_rel = p.phase_cal_tone_power_perc/100;

% all power
p.power_source_plus_system            = temp2power( p.temp_targetsource + p.temp_system , p.bandwidth );
p.power_all = p.power_source_plus_system * (1+p.power_pcal_rel);

% power of pcal signal
p.power_pcal = p.power_pcal_rel * p.power_all;

% check all power calculation
p.power_all = p.power_targetsource + p.power_system + p.power_pcal;

% amplitude of phas cal tones (sinusoid) 
% from "The Tone Generator and Phase Calibration in VLBI Measurements" J.B. Thomas (1978) and 
% "Methods for measuring the signal of the phase calibration of the VLBI radio telescopes" E.V. Nosov 2019
p.pcal_amplitude = sqrt(2*p.power_pcal/p.num_pcal_tones);


% Power to standard deviation of gaussian noise
% P ... power in Watts
% x ... ergodic guassian noise
% x ~ N(0,sigma) gaussian noise with zero-mean and sigma standard deviation
% N ... Number of samples of x
%
% P = 1/N * sum(x^2)
% sigma^2 = 1/N * sum(x^2)
% P = sigma^2
% sigma = sqrt(P)

% sigma, only valid if signal is a gaussian noise
p.sigma_targetsource   = sqrt(p.power_targetsource);
p.sigma_system         = sqrt(p.power_system);
p.sigma_all            = sqrt(p.power_all);
p.sigma_pcal           = sqrt(p.power_pcal); 
p.sigma_pcal_2         = sqrt(p.pcal_amplitude.^2/2*p.num_pcal_tones);

p.pcal_amplitude_2 = sqrt(2*0.1^2/(p.num_pcal_tones)*p.sigma_system^2);


% SNR: signal to noise ratio
%   defined as the ratio of the power of source signal to the power of the noise:
%       SNR = P_signal/P_noise
%   in decibel (db):
%       SNR_db = 10*log10(SNR)

% system
p.SNR_system_total = p.power_system/p.power_all;
p.SNR_system_total_db = 10*log10(p.SNR_system_total); % (db)

% source
p.SNR_source_total = p.power_targetsource/p.power_all; % no scale
p.SNR_source_system = p.power_targetsource/p.power_system; % no scale
p.SNR_source_system_db = 10*log10(p.SNR_source_system); % (db)
p.SNR_source_total_db = 10*log10(p.SNR_source_total); % (db)

% pcal 
p.SNR_pcal_total = p.power_pcal/p.power_all; % no scale
p.SNR_pcal_system = p.power_pcal/p.power_system; % no scale
p.SNR_pcal_system_2 = p.sigma_pcal_2/p.sigma_system;
p.SNR_pcal_total_db = 10*log10(p.SNR_pcal_total); % (db)
p.SNR_pcal_system_db = 10*log10(p.SNR_pcal_system); % (db)

end

