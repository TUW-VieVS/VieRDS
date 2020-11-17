function fprint_global(fileID, comment_line, ref_exper)
% print $GLOBAL to vex file

fprintf(fileID, '$GLOBAL;\n');
fprintf(fileID, '%s\n', comment_line);
fprintf(fileID, '  ref $EXPER = %s;\n', ref_exper);
fprintf(fileID, '%s\n', comment_line);

end

