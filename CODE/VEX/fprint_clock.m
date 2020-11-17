function fprint_clock(fileID, s)
% print vex clock section
% input:
%   s ... station struct

stations = fieldnames(s);

fprintf(fileID, '$CLOCK;\n');
fprintf(fileID, '*                          Valid from       clock_early       rate epoch        rate\n');
fprintf(fileID, '*                                              [usec]                        [sec/sec]\n');
for iSt = 1:length(stations)
    fprintf('vex file clock offset %f usec\n', s.(stations{iSt}).clock_offset*1E6)
%     fprintf(fileID, 'def %s; clock_early = %s :   %g usec : %s : %g; enddef; * delay application\n', s.(stations{iSt}).station_name, s.(stations{iSt}).date_str, s.(stations{iSt}).clock_offset*1E6, s.(stations{iSt}).date_str, s.(stations{iSt}).clock_rate);
%     fprintf(fileID, 'def %s; clock_early = %s :   %g usec : %s : %g; enddef; * delay application\n', s.(stations{iSt}).station_name, s.(stations{iSt}).date_str, s.(stations{iSt}).clock_offset*1E6, s.(stations{iSt}).date_str, 0);
        fprintf(fileID, 'def %s; clock_early = %s :   %g usec : %s : 0.0; enddef; * delay application\n', s.(stations{iSt}).station_name, s.(stations{iSt}).date_str, 0, s.(stations{iSt}).date_str);

end

end