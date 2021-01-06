function vierds(yaml_file_name)
tic;


%% start of code
fprintf('start raw data simulation: %s\n',datetime('now'));

% clear matlab memory and close files/figures
%clear; close all

% add baseband sim libs
%addpath(genpath('CODE'))

% check if OUT folder exists
if ~exist('OUT', 'dir')
    mkdir('OUT')
end

%yaml_file_name='input_val.yaml';

%% input
% arranges all the input for the software
% input
%   yaml file or default settings
fprintf('\n')
fprintf('::::::::::::::::::::::::\n')
fprintf('::::::Input module::::::\n')
fprintf('::::::::::::::::::::::::\n')
fprintf('\n')

[SIM_sta, CH_ind, controling, ref_frame] = bbs_input(yaml_file_name);

%% number of simulations
NSim = length(SIM_sta);

%% create current output folder
mkdir(controling.output_folder_long);

%% bbs_model

fprintf('\n')
fprintf('::::::::::::::::::::::::\n')
fprintf('::::::Model module::::::\n')
fprintf('::::::::::::::::::::::::\n')
fprintf('\n')

% preallocate
params_common = cell(NSim,1);

% loop through simulation
for iSim = 1:NSim
    
    fprintf('\nStart model calculation for CH: %.0f/%.0f\n\n',iSim,NSim)
    % model params per simulation
    [SIM_sta{iSim}, params_common{iSim}] = bbs_model( SIM_sta{iSim}, controling, ref_frame );
    
end

%% vex file
if controling.vex_file == 1
    create_vex_file(SIM_sta,controling);
end

%% DiFX
% create v2d file
if controling.write_v2d_file == 1
    create_v2d_file_wrapper(SIM_sta,controling)
end

%% bbs_signal

fprintf('\n')
fprintf('::::::::::::::::::::::::\n')
fprintf(':::::Signal module::::::\n')
fprintf('::::::::::::::::::::::::\n')
fprintf('\n')

% loop through simulation
for iSim = 1:NSim
    fprintf('Ch %.0f\n',iSim)
    % signals per simulation
    SIM_sta{iSim} = bbs_signal(SIM_sta{iSim}, params_common{iSim}, controling);
end

%% vdif

fprintf('\n')
fprintf('::::::::::::::::::::::::\n')
fprintf('::::Formatter module::::\n')
fprintf('::::::::::::::::::::::::\n')
fprintf('\n')

if controling.write_vdif_file == 1
    create_vdif_files(CH_ind, SIM_sta, controling);
end

%% cp yaml input file to OUT folder
% yaml file
if isfile(yaml_file_name)
    % file exists
    copyfile(yaml_file_name,controling.output_folder_long)
else
    % file does not exist
    fprintf('YAML input file does not exist\n')
end

% DIFX directory
if exist(controling.difx_folder_long, 'dir')
    % folder exists
    copyfile(controling.difx_folder_long,controling.output_difx_folder_long(1:end-1));
end

%% end
t=toc;

fprintf('Congratulations, you simulated raw VLBI telescope data!\n\n')
fprintf('You can find your output data here: %s\n', controling.output_folder_long)
fprintf('\n')
fprintf('Run time: %f (sec)\n\n',t)

fprintf('end of code\n')

end


