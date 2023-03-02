function [sample_delay, sample_delay_rounded, sample_frac_delay] = calculateIntegerFractDelay(tau, Tx)
% calculate integer and fractional delay

% sample delay, real number []
sample_delay = tau/Tx;

% integer sample delay, integer number []
sample_delay_rounded = round(sample_delay);

% fractional sample delay, real number [0,1) []
sample_frac_delay = sample_delay-sample_delay_rounded;

end