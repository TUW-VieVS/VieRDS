function fprint_exper(fileID, comment_line, exper_name, exper_description, exper_nominal_start, exper_nominal_stop, scheduler_name, target_correlator, software, software_version)
% print experiment block to vex file
% input:
%   def_EXPER ... name of definition in $EXPER block
%   VEX_rev ... file format
%   exper_name ...  experiment name
%   exper_description ... experiment description
%   exper_nominal_start ... nominal start of experiment
%   exper_nominal_stop ... nominal end of experiment
%   scheduler_name ... name of scheduler
%   scheduler_email ... mail of scheduler
%   target_correlator ... name of target correlator
%   software ... scheduling software
%   software_version ... software version

fprintf(fileID, '$EXPER;\n');
fprintf(fileID, '%s\n', comment_line);
fprintf(fileID, 'def %s;\n', exper_name);
fprintf(fileID, '  exper_name = %s;\n', exper_name);
fprintf(fileID, '  exper_description = %s;\n', exper_description);
fprintf(fileID, '  exper_nominal_start = %s;\n', exper_nominal_start);
fprintf(fileID, '  exper_nominal_stop = %s;\n', exper_nominal_stop);
fprintf(fileID, '  scheduler_name = %s;\n', scheduler_name);
fprintf(fileID, '  target_correlator = %s;\n', target_correlator);
fprintf(fileID, '* software = %s;\n', software);
fprintf(fileID, '* software_version = %s;\n', software_version);
fprintf(fileID, 'enddef;\n');
fprintf(fileID, '%s\n', comment_line);

end

