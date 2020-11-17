function fprint_tracks(fileID, comment_line, S )
% print $TRACKS block to vex file
% input:
%   def_TRACKS ... cell array with TRACKS names
%   subpass ... (only for tape)
%   trskID ... 3D cell array with track ID
%   signmag ... 3D cell array with sign and magnitued
%   hdsk ... don't know
%   trak_nr ... 3D cell array with track number

fprintf(fileID, '$TRACKS;\n');
fprintf(fileID, '%s\n', comment_line);

s = S{1};

stations = fieldnames(s);

% tracks
for iSt = 1:length(stations)
    fprintf(fileID, 'def %s;\n', s.(stations{iSt}).station_name_8character);
    iTr = 1;
    for iCh = 1:length(S)
        if S{iCh}.(stations{iSt}).number_of_bits == 1
            fprintf(fileID, '  fanout_def =    A : &CH%02.0f : sign : 1 : %02.0f;\n',iCh, iTr);
        end
        if S{iCh}.(stations{iSt}).number_of_bits == 2
            fprintf(fileID, '  fanout_def =    A : &CH%02.0f : sign : 1 : %02.0f;\n',iCh,iTr);
            iTr = iTr + 1;
            fprintf(fileID, '  fanout_def =    A : &CH%02.0f :  mag : 1 : %02.0f;\n',iCh,iTr);
        end
        iTr = iTr + 1;
    end
    
    % format
    fprintf(fileID, '  track_frame_format = VDIF%.0f;\n', s.(stations{1}).frame_length_byte );
    
    % enddef
    fprintf(fileID, 'enddef;\n');   
end

fprintf(fileID, '%s\n', comment_line);

end

