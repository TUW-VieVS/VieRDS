function fprint_roll(fileID, comment_line)
% print $ROLL block to vex file

fprintf(fileID, '$ROLL;\n');
fprintf(fileID, '%s\n', comment_line);

fprintf(fileID, '* WARNING: This block is hard coded!\n');
fprintf(fileID, 'def NO_ROLL;\n');
fprintf(fileID, '  roll = off;\n');
fprintf(fileID, 'enddef;\n');

fprintf(fileID, '%s\n', comment_line);

end

