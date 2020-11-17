function fprint_antenna(fileID, comment_line, s )
% print $ANTENNA block to vex file
% input:
%   def_ANTENNA ... cell array of 8 character antenna names
%   antenna_name ... cell array with antenna names
%   antenna_diam ... cell array with antenna diameters

fprintf(fileID, '$ANTENNA;\n');
fprintf(fileID, '%s\n', comment_line);

stations = fieldnames(s);

for iSt = 1:length(stations)
    fprintf(fileID, 'def %s;\n', s.(stations{iSt}).station_name_8character);
    fprintf(fileID, '  axis_type = az : el; * hardcoded\n');
    fprintf(fileID, '  axis_offset = 0 m; * hardcoded\n');
    fprintf(fileID, '  pointing_sector = &n     :  az :  0 deg :  360 deg :  el :    5 deg :   89 deg ; * hardcoded to arbitrary value not sure if necessary\n');
    fprintf(fileID, 'enddef;\n');   
end

fprintf(fileID, '%s\n', comment_line);

end

