function sta = bbs_signal(sta, params_common,controling,seed)
% generates all the signals for bbs
% input:
%   sta
%   params_common
%	seed
% output:
%   sta

% station names and number of stations
[ stations, NSt ] = station_struct_label( sta );

% create source signal
% seeding the PRNG to ensure the same source signal when simulating different stations on different nodes
% this is not done if no seed was set for vierds.m.
if (nargin == 4)
	rng(seed);
end
params_common = source_signal(params_common);

% create baseband signal at each station
if (nargin == 4)
	rng('shuffle');
end
for iSt = 1:NSt
    
    fprintf('station %s:\n',sta.(stations{iSt}).station_name)
    
    [sta.(stations{iSt})] = signal_operations_wrapper(params_common, sta.(stations{iSt}), controling);
        
end

end
