function s = exchandling(s)
% handling of exceptions

% weird bug in yaml reader, station two letter "On" will be assigned to
% value 1, this is changed in here
if s.station_name_trf_coord == 1
    s.station_name_trf_coord = 'On';
end

end

