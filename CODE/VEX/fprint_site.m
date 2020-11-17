function fprint_site(fileID, comment_line, s)
% print $SITE block to vex file
% input:
%   def_SITE ... cell array of 8 character site names
%   site_type ... cell array of site types corresponding to site names
%   site_ID ... cell array of 2 character site names
%   site_position ... cell array with 3d double vectors of site coordinates


fprintf(fileID, '$SITE;\n');
fprintf(fileID, '%s\n', comment_line);

stations = fieldnames(s);

for iSt = 1:length(stations)
    fprintf(fileID, 'def %s;\n', s.(stations{iSt}).station_name_8character);
    fprintf(fileID, '  site_type = %s;\n', s.(stations{iSt}).site_type);
    fprintf(fileID, '  site_name = %s;\n', s.(stations{iSt}).station_name_8character);
    fprintf(fileID, '  site_ID = %s;\n', s.(stations{iSt}).station_name);
    fprintf(fileID, '  site_position = %d m : %d m : %d m;\n', s.(stations{iSt}).X_trf(1), s.(stations{iSt}).X_trf(2), s.(stations{iSt}).X_trf(3));
    fprintf(fileID, '  site_position_ref = %s;\n', s.(stations{iSt}).site_position_ref);
    fprintf(fileID, '  occupation_code = %s;\n', s.(stations{iSt}).occupation_code);    
    fprintf(fileID, '  enddef;\n');
end

fprintf(fileID, '%s\n', comment_line);

end

