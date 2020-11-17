function print_controling_setup(c)
% prints the controling setup
%
% input:
%   c ... controling struct

% fieldnames
fn = fieldnames(c);

% number of controling params
N = length(fn);

% print header
fprintf('controling setup:\n')

% loop through all params and print name and value
for i=1:N
    
    nam = fn{i};    % field name
    val = c.(nam);  % field value
    
    % struct, cell won't be printed
    if isstruct(val) || iscell(val)
        fprintf('\tmatlab object (will not be printed)\n')
        continue;
    end
    
    % strings
    if ischar(val)
        fprintf('\t%s,\t %s\n',nam, val);
    end
    
    % numerics
    if isnumeric(val)
        if length(val)==1 % ... with single size only
            if mod(val,1)==0
                fprintf('\t%s,\t %d\n',nam, val);
            else
                fprintf('\t%s,\t %d\n',nam, val);
            end
        end
    end
    
end


end

