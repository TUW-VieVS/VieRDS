function sta = bbs_signal(sta, params_common,controling)
% generates all the signals for bbs
% input:
%   sta
%   params_common
% output:
%   sta

% station names and number of stations
[ stations, NSt ] = station_struct_label( sta );

% create source signal
params_common = source_signal(params_common);

% create baseband signal at each station
for iSt = 1:NSt
    
    fprintf('station %s:\n',sta.(stations{iSt}).station_name)
    
    [sta.(stations{iSt})] = signal_operations_wrapper(params_common, sta.(stations{iSt}), controling);
        
end

end
