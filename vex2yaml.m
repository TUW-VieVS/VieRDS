
function vex2yaml(vex_filename,yaml_template_filename,splitting_mode)
%VEX2YAML creates a series of yaml files out of a vex file
% each yaml file contains only 1 telescope observing 1 source
% input:
%   vex_filename ... the underlying vex file
%   master_yaml_filename ... underlying yaml file serving as a template and
%   containing "global" parameters
%   splitting_mode ... for simulation of VGOS sessions:
%       none ... each observation corresponds to 1 yaml file
%       bands ... each observation corresponds to 4 yaml files with 1 band
%       (8 channels) each
%       channels ... each observation corresponds to 32 yaml files with 1
%       channel each

vexfile = fileread(vex_filename);
% read vex file

yaml_template = fileread(yaml_template_filename);

station_section = extractBetween(vexfile,"$STATION;","end ");
% extract portion containing station definitions

each_station = extractBetween(station_section,"def","enddef");
% extract each station definition

station_names_trf = string(extractBetween(each_station,2,3));
station_names_8char = string(extractBetween(each_station,"$SITE = ",";"));
% extract 2 char and 8 char station names

station_names = [station_names_8char,station_names_trf];
clear station_names_trf;
clear station_names_8char;
% merge station names into 1 array, clear the others

sched_section = extractBetween(vexfile,"$SCHED;","$");
% extract schedule section

each_scan = extractBetween(sched_section,"scan ","endscan");
% extract each scan

scan_ids = string(extractBetween(each_scan,1,";"));
scan_starts = string(extractBetween(each_scan,"start = ",";"));
scan_starts = convertDateTime(scan_starts);
scan_sources = string(extractBetween(each_scan,"source = ",";"));
% extract id, start time and observed source for each scan

for i = 1:length(scan_ids)
    scan_stations = string(extractBetween(each_scan(i),"station = "," :"));
    % extract stations participating in ith scan
    for j = 1:length(scan_stations)
        [row, ~] = find(strcmp(station_names,scan_stations(j)));
        this_station = station_names(row,:);
        yaml_content = yaml_template;
        yaml_content = insertAfter(yaml_content,"date_vec: ","["+scan_starts(i)+"]");
        yaml_content = insertAfter(yaml_content,"station_name: ",this_station(2));
        yaml_content = insertAfter(yaml_content,"station_name_8character: ",this_station(1));
        yaml_content = insertAfter(yaml_content,"station_name_trf_coord: ",this_station(2));
        yaml_content = insertAfter(yaml_content,"source_name: ",scan_sources(i));
        % insert scan specific parameters into yaml file
        namestring = scan_ids(i)+"_"+this_station(3);
        print_yaml_files(yaml_content,namestring,splitting_mode);
    end
end
end
