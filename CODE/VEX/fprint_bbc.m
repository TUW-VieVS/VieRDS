function fprint_bbc(fileID, comment_line, S )
% print $BBC block to vex file
% input:
%   def_BBC ... cell array with BBC names
%   BBC_ID ... 3D cell array with BBC ID
%   Physical_BBC_nr ... 3D cell array with physical BBC Nr.
%   IF_ID ... 3D cell array with IF labels

fprintf(fileID, '$BBC;\n');
fprintf(fileID, '%s\n', comment_line);

s = S{1};

% station names
[ stations, ~ ] = station_struct_label( s );

% bbc channels
for iSt = 1:length(stations)
    fprintf(fileID, 'def %s;\n', s.(stations{iSt}).station_name_8character);
    fprintf(fileID, '*                     BBC    Physical   IF\n');
    fprintf(fileID, '*                      ID      BBC#     ID\n');
    for iCh = 1:length(S)
        fprintf(fileID, '  BBC_assign = &BBC%02.0f : %02.0f : &IF_A%02.0f;\n', iCh, iCh, iCh);
    end
    fprintf(fileID, 'enddef;\n');   
end

fprintf(fileID, '%s\n', comment_line);

end