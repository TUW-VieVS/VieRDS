function [sta,controling] = create_sta(yaml_input)
% this function creates the sta struct which stores the parameterization
% for the stations to simulate

%% read station input
% define default settings via inputval
% special settings via .yaml file

% preallocate struct
sta = struct;

% check if yaml file exists
if exist(yaml_input, 'file') == 2
    
    % use yaml input
    sta_yaml = ReadYaml(yaml_input);
    fprintf('yaml file used: %s\n', yaml_input)
    
else % ... no yaml file is used
    
    % create empy struct
    sta_yaml = struct;
    str_default = 'no user specification via yaml file (use default)';
    fprintf('yaml file input: %s\n', str_default)
    
end

% yaml station and setup file content
fn_yaml = fieldnames(sta_yaml); % stations specified

% seperate station blocks from setup blocks
if find(strcmp(fn_yaml,'setup')==1)
    setup_yaml = sta_yaml.setup;
    sta_yaml = rmfield(sta_yaml,'setup');
else
    fprintf('yaml input file: no "setup" block specified in yaml input file %s\n',yaml_input)
    fprintf('yaml input file: will use default values for "setup"\n')
    setup_yaml = struct;
end

% onyl station yaml file content
fn_yaml = fieldnames(sta_yaml); % stations specified
if isempty(fn_yaml)
    
    % default number of stations
    NSt = 2;
    
    % default station label of structs
    fn_yaml = {'s1','s2'};
    
else
    NSt = length(fn_yaml);
end

fprintf('Number of stations: %d\n', NSt)

% create matlab station struct with default params
for iSt = 1:NSt
    fn = fn_yaml{iSt};
    sta.(fn) = inputval;
    % default settings can come here
    % ...
end

% set controling (controls code in terms of plotting, printing, but also
% main execution pattern: zero-basline, non-zero baseline, and controls 
% also names of reference frame input data sets )
controling = setcontroling;


%% combine default and yaml input
if ~isempty(fieldnames(sta_yaml))
    sta = combine_structs(sta, sta_yaml);
end

if ~isempty(fieldnames(sta_yaml))
    controling = combine_structs(controling, setup_yaml);
end


% delete station struct coming solely from yaml input
clear sta_yaml;
clear setup_yaml;

end

