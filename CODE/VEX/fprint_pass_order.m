function fprint_pass_order(fileID, comment_line)
% print $PASS_ORDER block to vex file

fprintf(fileID, '$PASS_ORDER;\n');
fprintf(fileID, '%s\n', comment_line);

fprintf(fileID, '* WARNING: This block is hard coded!\n');
fprintf(fileID, 'def passOrder;\n');
fprintf(fileID, '  pass_order =   1A :   2A :   3A :   4A :   5A :   6A :   7A :   8A :   9A :  10A :  11A :  12A :  13A :  14A;\n');
fprintf(fileID, 'enddef;\n');

fprintf(fileID, '%s\n', comment_line);

end

