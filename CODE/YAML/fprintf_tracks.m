function fprintf_tracks(fileID, comment_line, S )
% print $ANTENNA block to vex file

fprintf(fileID, '$TRACKS;\n');
fprintf(fileID, '%s\n', comment_line);

s = S{1};

stations = fieldnames(s);

for iSt = 1:length(stations)
    fprintf(fileID, '\tdef %s;\n', s.(stations{iSt}).station_name_8character);
    iTr = 1;
    for iCh = 1:length(S)
        if S{iCh}.(stations{iSt}).bit_depth == 1
            fprintf(fileID, '\t\tfanout_def =    A : &CH%02.0f : sign : 1 : %02.0f;\n',iCh, iTr);
        end
        if S{iCh}.(stations{iSt}).bit_depth == 2
            fprintf(fileID, '\t\tfanout_def =    A : &CH%02.0f : sign : 1 : %02.0f;\n',iCh,iTr);
            iTr = iTr + 1;
            fprintf(fileID, '\t\tfanout_def =    A : &CH%02.0f :  mag : 1 : %02.0f;\n',iCh,iTr);
        end
        iTr = iTr + 1;
    end
    fprintf(fileID, '\tenddef;\n');   
end

fprintf(fileID, '%s\n', comment_line);

end

