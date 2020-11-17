function fprint_phase_cal_detect(fileID, comment_line)
% print $PHASE_CAL_DETECT block to vex file

fprintf(fileID, '$PHASE_CAL_DETECT;\n');
fprintf(fileID, '%s\n', comment_line);

fprintf(fileID, '* WARNING: This block is hard coded!\n');
fprintf(fileID, 'def Standard;\n');
fprintf(fileID, '  phase_cal_detect = &U_cal : 2;\n');
fprintf(fileID, 'enddef;\n');

fprintf(fileID, '%s\n', comment_line);

end

