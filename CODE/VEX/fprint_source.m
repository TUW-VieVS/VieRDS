function fprint_source(fileID, comment_line, s)
% print $SOURCE block to vex file
% input:
%   def_SOURCE ... cell array with all source names
%   source_type ... cell array with source types
%   source_name ... cell array with source names
%   IAU_name ... cell array wiht IAU names
%   ra ... cell array with ra 
%   dec ... cell array with dec
%   ref_coord_frame ... cell array with coordinate frame

fprintf(fileID, '$SOURCE;\n');
fprintf(fileID, '%s\n', comment_line);

stations = fieldnames(s);
iSt = 1;

fprintf(fileID, 'def %s;\n', s.(stations{iSt}).source_name);
fprintf(fileID, '  source_name = %s;\n', s.(stations{iSt}).source_name);
fprintf(fileID, '  source_type = %s;\n', s.(stations{iSt}).source_type);
fprintf(fileID, '  ra = %s;\n', num2str(s.(stations{iSt}).source_ra_str));
fprintf(fileID, '  dec = %s;\n', num2str(s.(stations{iSt}).source_de_str));
fprintf(fileID, '  ref_coord_frame = %s;\n', s.(stations{iSt}).ref_coord_frame);
fprintf(fileID, '  ra_rate = 0 asec/yr; * hard coded \n');
fprintf(fileID, '  dec_rate = 0 asec/yr; * hard coded \n');

fprintf(fileID, 'enddef;\n');

fprintf(fileID, '%s\n', comment_line);



end

