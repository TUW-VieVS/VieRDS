function [p] = read_multi_point_source_data(k,p)
% input:
%   k ... identifier if multi_point_source data should be read
% output:

% check if requirements are met to read multi-point source data
if k == 1
    
    % print file name
    fprintf('The following file will be read for multi-point source data: %s\n', p.multi_point_source_file_name)

    % print file content
    type(p.multi_point_source_file_name)

    % open file 
    fileID = fopen(p.multi_point_source_file_name);

    % read data
    p.multi_point_source_data = textscan(fileID,'%f %f %s %s %f','Delimiter',',','HeaderLines',1);

    % close file
    fclose(fileID);

end

end