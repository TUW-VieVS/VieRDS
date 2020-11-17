clear; close all;
addpath(genpath('/home/jgruber1/software/yamlmatlab/yaml'));
% s = ReadYaml('/home/jgruber1/software/yamlmatlab/yaml/Tests/Data/test_import/basebandsim.yaml');
WriteYaml('writeyamltest.yaml', s);
S=ReadYaml('/home/jgruber1/software/yamlmatlab/yaml/writeyamltest.yaml')