function [v2d_antenna] = create_v2d_antenna_struct(sta)
% create v2d file antenna struct
%
% input
%   sta ... station struct
% output
%   v2d_antenna ... v2d antenna struct

% get number of stations
[ stations, N ] = station_struct_label( sta );

% pre-allocate antenna struct
v2d_antenna = struct;

% create antenna struct
for i=1:N
    v2d_antenna(i).antenna = sta.(stations{i}).station_name; % station name
    v2d_antenna(i).filelist = [v2d_antenna(i).antenna,'.filelist'];
    v2d_antenna(i).toneSelection = 'all';
    
    % ... more setting can come here ...
    
end

end

