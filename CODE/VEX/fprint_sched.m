function fprint_sched(fileID, comment_line, s)
% print $SCHED block to vex file

fprintf(fileID, '$SCHED;\n');
fprintf(fileID, '%s\n', comment_line);

stations = fieldnames(s);

fprintf(fileID, 'scan SIM001;\n');
fprintf(fileID, '  start = %s;\n', s.s1.date_str);
fprintf(fileID, '  mode = %s;\n', s.s1.mode_observation);
fprintf(fileID, '  source = %s;\n', s.s1.source_name);
for iSt = 1:length(stations)
    fprintf(fileID, '  station = %s : 0 sec : %.0f sec : 0 ft: 1A : &n : 1;\n', s.(stations{iSt}).station_name, s.s1.scan_length);
end
fprintf(fileID, 'endscan;\n');

end

