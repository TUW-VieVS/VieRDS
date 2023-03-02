function [ sta, params_common ] = bbs_model( sta, controling, ref_frame )
% baseband data simulator model calculation. calculation of all station
% individual and common model params. No memory intensive calculation
% of time series and frequency spectrums
%
% Input:
%   sta ... station struct
%   controling ... controling struct
%   ref_frame ... reference frame struct
%
% Output:
%   sta ... station struct model params added
%   params_common ... common set of parameters struct

% station names and number of stations
[ stations, NSt ] = station_struct_label( sta );

%% station individual estimations
% loop through all stations
for iSt = 1:NSt
    % station inidivual parameter calculation
    sta.(stations{iSt}) = stat_individual_params( sta.(stations{iSt}), controling, ref_frame );
end

%% station common
% model parameters extended
[params_common,sta] = modelparams_ext( sta );

%% print params overview

% loop through all stations
for iSt = 1:NSt
    printParamOverview( sta.(stations{iSt}) );
    printParamOverview2File( sta.(stations{iSt}),controling  );
end

% print delay table
printDelayTable(NSt,stations,sta,'tau_geocenter','us')
printDelayTable(NSt,stations,sta,'delay_rate','us/s')
end

