function fprint_freq(fileID, comment_line, S )
% print $FREQ block to vex file
% input:
%   def_FREQ ... cell array with frequency definitions
%   sample_rate ... cell array with sample rate
%   Band_ID ... 3D cell array with band id 
%   Sky_freq ... 3D cell array with sky frequencies
%   Net_SB ... 3D cell array with sideband
%   Chan_BW ... 3D cell array with channel sideband
%   Chan_ID ... 3D cell array with channel ID
%   BBC_ID ... 3D cell array with BBC ID
%   Phasecal_ID ... 3D cell array with phasecal ID

fprintf(fileID, '$FREQ;\n');
fprintf(fileID, '%s\n', comment_line);

s = S{1};

stations = fieldnames(s);

% freqs
for iSt = 1:length(stations)
    fprintf(fileID, 'def %s;\n', s.(stations{iSt}).station_name_8character);
    fprintf(fileID, '*                 Band    Sky freq    Net    Chan       Chan     BBC   Phase-cal\n');
    fprintf(fileID, '*                  Id    at 0Hz BBC    SB     BW         ID       ID       ID \n');
    for iCh = 1:length(S)
        f0 = S{iCh}.(stations{iSt}).fa;
        if 1*1e9 <= f0 && f0 < 2*1e9
            band_id = 'L';
        end
        if 2*1e9 < f0 && f0 <= 4*1e9
            band_id = 'S';
        end
        if 4*1e9 < f0 && f0 <= 8*1e9
            band_id = 'C';
        end
        if 8*1e9 < f0 && f0 <= 12*1e9
            band_id = 'X';
        end
        if 12*1e9 < f0 && f0 <= 18*1e9
            band_id = 'Ku';
        end
        if 18*1e9 < f0 && f0 <= 27*1e9
            band_id = 'K';
        end
        if 27*1e9 < f0 && f0 <= 40*1e9
            band_id = 'Ka';
        end
        fprintf(fileID, '  chan_def = &%s :  %.2f MHz : %s : %.2f MHz : &CH%02.0f : &BBC%02.0f : &U_cal;\n', band_id, f0*1e-6, S{iCh}.(stations{iSt}).obs_sideband_vex, S{iCh}.(stations{iSt}).bandwidth*1e-6, iCh, iCh     );
    end
    fprintf(fileID, '  sample_rate = %.2f Ms/sec;\n', s.(stations{iSt}).sampling_frequency*1e-6 ); 
    fprintf(fileID, 'enddef;\n');   
end

fprintf(fileID, '%s\n', comment_line);

end