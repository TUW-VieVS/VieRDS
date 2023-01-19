function [k] = check_multi_point_source_input_specs(p)
% check if there 
% input:
%   p ... station specific struct
% output:
%   k ... identifier if requirements are machted (=0,1)

% identifier
k = 0;

% signal type ID
id_signal_type = 0;

% source name ID
id_source_name = 0;

% case 1:  
% signal_type_target_source: to multi-point-gaussian-white-noise
% source_name: 2358+189
% multi_point_source_file_name: 2358+189.src

% check if signal type is specified
if isfield(p,'signal_type_target_source')
    if strcmp(p.signal_type_target_source,'multi-point-gaussian-white-noise')
        id_signal_type=1;
    end
end

% check if source_name is specified
if isfield(p, 'source_name')
    id_source_name=1;
end

% check if file name is specified
if isfield(p, 'multi_point_source_file_name')

    % check if filename ends with .src
    if strcmp(p.multi_point_source_file_name(end-3:end), '.src')
        
        % name of source specified within multi_point_source_file_name
        source_name_file = p.multi_point_source_file_name(1:end-4);
        
        if id_source_name==1
            % check if source_name matches the name specified within the multi_point_source_file_name
            if strcmp(source_name_file,p.source_name)
                fprintf('name specified in multi_point_source_file_name (%s) matchses source_name (%s)\n', p.source_name, p.multi_point_source_file_name);

                % in case multi_point_source_file_name is specified but
                % signal_type_target_source is not set to multi-point-gaussian-white-noise
                if id_signal_type==1
                    fprintf('Multi-point source specification are correct:\n')
                    fprintf('\t signal_type_target_source: %s\n',p.signal_type_target_source)
                    fprintf('\t multi_point_source_file_name: %s\n',p.multi_point_source_file_name)
                    fprintf('\t source_name: %s\n',p.source_name)

                    % identifier is true
                    k = 1;

                else
                    warning('Input file for multi_point_source_file_name is specified but the signal_type_target_source is not set to multi-point-gaussian-white-noise. Multi-point source data can only be read when the signal_type_target_source is set to multi-point-gaussian-white-noise or other versions multi-point tpyes')
                end
            else
                warning('name specified in multi_point_source_file_name (%s) does not match source_name (%s)', p.source_name, p.multi_point_source_file_name)
            end
        else
            warning('source_name is not specified');
        end

    else
        warning('multi_point_source_file_name is specified but does not end with .src: %s', p.multi_point_source_file_name)
    end

else
    if id_signal_type==1
        warning('signal_type_target_source is set multi-point-gaussian-white-noise but no input file via multi_point_source_file_name is specified')
    end
end