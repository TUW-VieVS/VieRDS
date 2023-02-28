function [p, s] = modelparams_ext( s )
% uses maximum doppler shift of all stations to create extended bandwidth
% extended bandwidth is a larger bandwidth than observed to use frequencies
% which are shifted across bandwidth borders
%
% params calculated:
%   station_names               ... cell array with station names
%   fa                          ... array with lower frequency limits
%   fb                          ... array with upper frequency limits
%   fa_doppler                  ... array with lower doppler frequency limits (emitted)
%   fb_doppler                  ... array with upper doppler frequency limits (emitted)
%   doppler_shift               ... array with doppler frequencies
%   spectral_resolution         ... array with spectral resolution
%   fa_min                      ... min. lower frequency limit of all stations
%   fb_max                      ... max. upper frequency limit of all stations
%   bandwidth_max               ... max. bandwidth considering all stations
%   doppler_shift_max           ... max. doppler shift considering all stations
%   spectral_resolution_min     ... min. spectral resolution
%   fa_ext                      ... lower frequency limit of extended bandwidth
%   fb_ext                      ... upper frequency limit of extended bandwidth

fnames  = fieldnames(s);
nF      = length(fnames);

%% Memory preallocation
p.fa                   = zeros(nF,1);
p.fb                   = zeros(nF,1);
p.doppler_shift        = zeros(nF,1);
p.spectral_resolution  = zeros(nF,1);
p.signal_type_target_source = cell(nF,1);
p.number_of_samples     = zeros(nF,1);
p.scan_length           = zeros(nF,1);

%% Loop over all stations in struct 's' to get params of each station in a vector
for iF = 1:nF
    p.station_names{iF,1}          = s.(fnames{iF}).station_name;          % station name array in params
    p.f0(iF,1)                     = s.(fnames{iF}).f0;
    p.fa(iF,1)                     = s.(fnames{iF}).fa;                    % fa array in params
    p.fb(iF,1)                     = s.(fnames{iF}).fb;                    % fb array in params
    %     p.fa_doppler_min(iF,1)         = min([s.(fnames{iF}).p_tm.signal_arrival_geocenter(:).fa_doppler]);
    %     p.fb_doppler_max(iF,1)         = max([s.(fnames{iF}).p_tm(:).fb_doppler]);
    %     p.doppler_shift_max(iF,1)      = max([s.(fnames{iF}).p_tm(:).doppler_shift_fb]);
    p.spectral_resolution(iF,1)    = s.(fnames{iF}).spectral_resolution;
    p.signal_type_target_source{iF,1} = s.(fnames{iF}).signal_type_target_source;
    p.number_of_samples(iF,1)      = s.(fnames{iF}).num_samples_scan;
    p.scan_length(iF,1)      = s.(fnames{iF}).scan_length;
    p.delay_tau(iF,1) =  s.(fnames{iF}).p_tm.signal_arrival_geocenter(1).tau_geocenter;
    p.delay_rate_tau(iF,1) =  s.(fnames{iF}).p_tm.signal_arrival_geocenter(1).delay_rate;
end

%% spectral calculations (bandwidth, spectral resolution)
% minimum frequency observed by all stations
p.fa_min = min( p.fa );

% maximum frequency observed by all stations
p.fb_max = max( p.fb );

% total required bandwidth
p.bandwidth_max = p.fb_max - p.fa_min;

% maximum dopplershift of all stations
% p.doppler_shift_max = max( p.doppler_shift_max );

% finest spectral resolution
p.spectral_resolution_min = min(p.spectral_resolution);

% baseband frequencies
p.fa_base  = p.fa - p.fa_min;
p.fb_base  = p.fb - p.fa_min;

% frequency index
p.k_fa = p.fa_base ./ p.spectral_resolution_min + 1;
p.k_fb = p.fb_base ./ p.spectral_resolution_min + 1;


%% number of samples
p.number_of_samples_max  = max(p.number_of_samples);


%% clock offset and rate
tau_min = min(p.delay_tau);
rate_min = min(p.delay_rate_tau);
for iF = 1:nF
    s.(fnames{iF}).clock_offset = p.delay_tau(iF) - tau_min;
    s.(fnames{iF}).clock_rate = p.delay_rate_tau(iF) - rate_min;
    %     s.(fnames{iF}).clock_offset = 0;

end

%% source type
signal_type_target_source = unique(p.signal_type_target_source);
if length(signal_type_target_source) == 1
    % one common signal source type specified
    p.signal_type_target_source = unique(p.signal_type_target_source);
else
    % differnt signal source types specified
end

%% Matrix with Station and Source Id
i = 1;
% per station
for iF = 1:nF
    % check if MPS is true
    if s.(fnames{iF}).mpsd_i == 1
        % per MPS
        for iMPS = 1:s.(fnames{iF}).number_of_MPS
            p.StaSourceID(i,1) = iF;
            p.StaSourceID(i,2) = s.(fnames{iF}).MPS(iMPS).index;
            i = i+1;
        end
    end
end


