function fprint_if(fileID, comment_line, S)
% print $IF block to vex file
% input:
%   def_IF .. cell array with all IF names
%   if_ID ... 3D cell array with IF_ID
%   physical_name ... 3D cell array with physical IF name
%   Pol ... 3D cell array with polarization
%   Total_LO ... 3D cell array with 'Total LO' effective total LO frequency
%   Net_SB ... 3D cell array frequency_sideband
%   phasecal_freq_spacing ... 3D cell array with frequency spacing of phase cal
%   Pcal_base_freq ... 3D cell array with base frequency of phase cal frequency

fprintf(fileID, '$IF;\n');
fprintf(fileID, '%s\n', comment_line);

s = S{1};

stations = fieldnames(s);

for iSt = 1:length(stations)
    fprintf(fileID, 'def %s;\n', s.(stations{iSt}).station_name_8character);
    for iCh = 1:length(S)
        fprintf(fileID, '  if_def = &IF_A%02.0f : A%.0d : %s : %f MHz : %s : %f MHz ;\n', iCh, iCh, S{iCh}.(stations{iSt}).polarization, S{iCh}.(stations{iSt}).fa*1e-6, S{iCh}.(stations{iSt}).IF_sideband, S{iCh}.(stations{iSt}).phase_cal_repetition_rate*1e-6);
%         fprintf(fileID, '  if_def = &IF_A%02.0f : A%.0d : %s : %f MHz : %s : 0.0 MHz : 0.00 Hz;\n', iCh, iCh, S{iCh}.(stations{iSt}).polarization, S{iCh}.(stations{iSt}).fa*1e-6, S{iCh}.(stations{iSt}).IF_sideband);

    end
    fprintf(fileID, 'enddef;\n');
end

fprintf(fileID, '%s\n', comment_line);

end

