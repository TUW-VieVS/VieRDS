function fprint_mode(fileID, comment_line, s)
% print $MODE block to vex file
% input:
%   fileID ... matlab filed identifier
%   comment_line ... string for default comment line
%   s ... station struct

fprintf(fileID, '$MODE;\n');

fprintf(fileID, '%s\n', comment_line);

stations = fieldnames(s);

fprintf(fileID, 'def %s;\n', s.(stations{1}).mode_observation);

for iSt = 1:length(stations)
   fprintf(fileID, '  %s\n', comment_line);
   fprintf(fileID, '  ref $FREQ = %s : %s ;\n', s.(stations{iSt}).station_name_8character,  s.(stations{iSt}).station_name);
   fprintf(fileID, '  ref $BBC = %s : %s ;\n', s.(stations{iSt}).station_name_8character,  s.(stations{iSt}).station_name);
   fprintf(fileID, '  ref $IF = %s : %s ;\n', s.(stations{iSt}).station_name_8character,  s.(stations{iSt}).station_name);
   fprintf(fileID, '  ref $TRACKS = %s : %s ;\n', s.(stations{iSt}).station_name_8character,  s.(stations{iSt}).station_name);
   fprintf(fileID, '  ref $PASS_ORDER = passOrder : %s ;\n', s.(stations{iSt}).station_name_8character,  s.(stations{iSt}).station_name);
   fprintf(fileID, '  ref $ROLL = NO_ROLL : %s ;\n', s.(stations{iSt}).station_name_8character,  s.(stations{iSt}).station_name);
   fprintf(fileID, '  ref $PHASE_CAL_DETECT = Standard : %s ;\n', s.(stations{iSt}).station_name_8character,  s.(stations{iSt}).station_name);
end

fprintf(fileID, 'enddef;\n');

fprintf(fileID, '%s\n', comment_line);

end

