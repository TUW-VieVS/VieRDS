function [ stations, number_of_stations ] = station_struct_label( sta )
% get station labeling from station struct and number of station structs

stations = fieldnames(sta);
number_of_stations = length(stations);

end