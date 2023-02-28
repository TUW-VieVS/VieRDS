function [mpsd, mpsd_i] = check_mps_input_data(mpsd_str)
% check multi point source data (mpsd) and convert text to double format
%
% input:
%   mpds ... array from text source file
%
% output:
%   mpsd ... array with converted text to double

% validity of MPSD data
mpsd_i = 0;

% check if there are entries
if ~isempty(mpsd_str{1})
    
    % dimensions
    [~,c] = size(mpsd_str);
    
    % check number of clumns
    if c~=6
        warning('Please check multi-point source file. The number of columns is not six.')
    else
        
        % number of rows
        r = length(mpsd_str{1, 1});
        
        % pre-allocate mpsd
        mpsd = zeros(r,10);
        
        % copy first column
        mpsd(:,1)=mpsd_str{1, 1};
        
        % copy second column
        mpsd(:,2)=mpsd_str{1, 2};

        % copy third column
        mpsd(:,3)=mpsd_str{1, 3};
        
        % check if frequency entries are correct
        if ~isempty(find(mpsd(:,3) - mpsd(:,2) <= 0, 1))
            error('Wrong frequency entry in multi-point source data')
        end
        
        % format fourth and fifth column
        for i=1:r
            % RA
            [mpsd(i,4:6),~,~] = sscanf(mpsd_str{1, 4}{i} ,'%fh%fm%fs');
            
            % DE
            [mpsd(i,7:9),~,~] = sscanf(mpsd_str{1, 5}{i} ,'%fd%f''%f''');
        end
        
        % copy sixth column
        mpsd(:,10)=mpsd_str{1, 6};
        
        % check if source flux is negative
        if ~isempty(find(mpsd(:,10) < 0, 1))
            error('Source flux in multi-point source data is negative')
        end
        
        % check if source flux is zero
        if ~isempty(find(mpsd(:,10) == 0, 1))
            warning('Source flux in multi-point source data is zero. Corresponding source signal will not be simulated. Are you sure?')
        end
        
        % MPS data is valid
        mpsd_i = 1;
        
    end
else
    % warning message
    warning('No entries in multi-point source input data. Proper working of VieRDS is not guaranteed. Please specify at least one point source in text file.')
      
end

end