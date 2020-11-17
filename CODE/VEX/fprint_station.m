function fprint_station(fileID, comment_line, s)
% print $STATION block to vex file
% input:
%   fileID ... matlab filed identifier
%   comment_line ... string for default comment line
%   s ... station struct

fprintf(fileID, '$STATION;\n');
fprintf(fileID, '%s\n', comment_line);

stations = fieldnames(s);

for iSt = 1:length(stations)
    fprintf(fileID, 'def %s;\n', s.(stations{iSt}).station_name);
    fprintf(fileID, '  ref $SITE = %s;\n', s.(stations{iSt}).station_name_8character);
    fprintf(fileID, '  ref $ANTENNA = %s;\n', s.(stations{iSt}).station_name_8character);
    fprintf(fileID, '  ref $DAS = %s;\n', s.(stations{iSt}).station_name_8character);
    fprintf(fileID, 'enddef;\n');
end

fprintf(fileID, '%s\n', comment_line);

end

