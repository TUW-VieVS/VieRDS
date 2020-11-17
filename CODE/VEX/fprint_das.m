function fprint_das(fileID, comment_line, s)
% print $DAS block to vex file
% input:
%   def_DAS ... cell array of all das definition
%   DAS_param_name ... cell array with all param names corresponding to DAS definitions
%   DAS_param_value ... cell array with all param values corresponding to DAS param names

stations = fieldnames(s);

fprintf(fileID, '$DAS;\n');
fprintf(fileID, '%s\n', comment_line);
for iSt = 1:length(stations)
    fprintf(fileID, 'def %s;\n', s.(stations{iSt}).station_name);
    fprintf(fileID, '  record_transport_type = %s;\n', s.(stations{iSt}).recorder_transport_type_name);
    fprintf(fileID, 'enddef;\n');
end
fprintf(fileID, '%s\n', comment_line);

end