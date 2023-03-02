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
end