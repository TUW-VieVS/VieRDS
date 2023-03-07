function [signal_arrives_at_station] = reStorageSignalArrivesAtStation(tau, dr, ntau, phi0_rad, phi0_sample)
% re-storage of params
% 
% input:
%   dr ... delay rate
%   ntau ... sample delay
%   phi0_rad ... phase offset
%   phi0_sample ... offset in samples
%
% output:
%   signal_arrives_at_station ... new struct

signal_arrives_at_station.tau = tau;
signal_arrives_at_station.delay_rate = dr;
signal_arrives_at_station.sample_delay = ntau;
signal_arrives_at_station.sample_delay_rounded = round(ntau);
signal_arrives_at_station.sample_frac_delay = ntau-round(ntau);

signal_arrives_at_station.phase_offset_fa = phi0_rad;
signal_arrives_at_station.tau_phase_offset_fa = phi0_sample;

fprintf('Signal arrives at station:\n')
fprintf('\t tau: %f [ns]\n', signal_arrives_at_station.tau*10^9)
fprintf('\t delay rate: %f [ns/s]\n', signal_arrives_at_station.delay_rate*10^9)
fprintf('\t sample_delay: %f []\n', signal_arrives_at_station.sample_delay)
fprintf('\t sample_delay_rounded: %f []\n', signal_arrives_at_station.sample_delay_rounded)
fprintf('\t sample_frac_delay: %f []\n', signal_arrives_at_station.sample_frac_delay)
fprintf('\t phase_offset_fa: %f [rad]\n', signal_arrives_at_station.phase_offset_fa)
fprintf('\t tau_phase_offset_fa: %f [rad] \n', signal_arrives_at_station.tau_phase_offset_fa)

end