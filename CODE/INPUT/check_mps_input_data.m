function [mpsd] = check_mps_input_data(mpsd_str)
% check multi point source data (mpsd) and convert text to double format
%
% input:
%   mpds ... array from text source file
%
% output:
%   mpsd ... array with converted text to double

% dimensions
[~,c] = size(mpsd_str);

% check number of clumns
if c~=5
    warning('Please check multi-point source file. The number of columns is not four.')
else

    % number of rows
    r = length(mpsd_str{1, 1});

    % pre-allocate mpsd
    mpsd = zeros(r,9);

    % copy first column
    mpsd(:,1)=mpsd_str{1, 1};

    % copy second column
    mpsd(:,2)=mpsd_str{1, 2};

    % format third and fourth column
    for i=1:r
        % RA
        [mpsd(i,3:5),~,~] = sscanf(mpsd_str{1, 3}{i} ,'%fh%fm%fs');

        % DE
        [mpsd(i,6:8),~,~] = sscanf(mpsd_str{1, 4}{i} ,'%fd%f''%f''');
    end 

    % copy fifth column
    mpsd(:,9)=mpsd_str{1, 5};

end

end