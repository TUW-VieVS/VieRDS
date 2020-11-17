function create_vex_file(S,controling)
% program which creates a VEX (VLBI Experiment) file
%
% blocks required for correlation, still not sure which one are really required:
%   $ANTENNA
%   $CLOCK
%   $CORR (NYI)
%   $DAS
%   $EOP
%   $EXPER
%   $FREQ
%   $PHASE_CAL_DETECT (hard coded)
%   $ROLL (hard coded)
%   $IF
%   $SITE
%   $SOURCE
%   $TRACKS
%
% limitations:
% * for each section a station section is created, even if the station have
% the same settings
% * several param values are still hardcoded

% Input:


% default channel id
iCh = 1;

% default station id
iSt = 1;

% default station struct
s = S{iCh};

% station names and number of stations
[ stations, ~ ] = station_struct_label( s );

% comment line
comment_line = '*--------------------------------------------------------';

% create file
fileID = fopen([controling.output_folder_long,sprintf('%s.vex',controling.experiment_name)],'w');

% print VEX_rev
fprintf(fileID, 'VEX_rev = %s;\n',controling.vex_file_format);

% print $GLOBAL;
fprint_global(fileID, comment_line,controling.experiment_name)

% print $EXPER;
iSt = 1;
def_EXPER = controling.experiment_name;
exper_name = def_EXPER;
exper_description = controling.experiment_description;
exper_nominal_start = s.(stations{iSt}).date_str;
exper_nominal_stop = s.(stations{iSt}).date_str_stop;
scheduler_name = controling.user_name;
target_correlator = controling.target_corr;
software = controling.software;
software_version = controling.software_version;


fprint_exper(fileID, comment_line, exper_name, exper_description, exper_nominal_start, exper_nominal_stop, scheduler_name, target_correlator, software, software_version)

% print $STATION;
fprint_station(fileID, comment_line, s)

% print $MODE;
fprint_mode(fileID, comment_line, s)

% print $SITE;
fprint_site(fileID, comment_line, s)

% print $ANTENNA;
fprint_antenna(fileID, comment_line, s )
   
% print $DAS; (data-acquisition system information)
fprint_das(fileID, comment_line, s)

% print $SOURCE;
fprint_source(fileID, comment_line, s)

% print $BBC; (not necessary for correlation)
fprint_bbc(fileID, comment_line, S )

% print $IF;
fprint_if(fileID, comment_line, S)

% print $TRACKS;
fprint_tracks(fileID, comment_line, S )

% tape only
subpass = 'A';

% print $FREQ;
fprint_freq(fileID, comment_line, S )

%
% hardcoded:
% *=========================================================================================================
% $PASS_ORDER;
% *=========================================================================================================
% * WARNING: This block is hard coded!
%     def passOrder;
%         pass_order =   1A :   2A :   3A :   4A :   5A :   6A :   7A :   8A :   9A :  10A :  11A :  12A :  13A :  14A;
%     enddef;

fprint_pass_order(fileID, comment_line)

% *=========================================================================================================
% $ROLL;
% *=========================================================================================================
% * WARNING: This block is hard coded!
%     def NO_ROLL;
%         roll = off;
%     enddef;

fprint_roll(fileID, comment_line)

% *=========================================================================================================
% $PHASE_CAL_DETECT;
% *=========================================================================================================
% * WARNING: This block is hard coded!
%     def Standard;
%         phase_cal_detect = &U_cal : 1;
%     enddef;

fprint_phase_cal_detect(fileID, comment_line)


%   
%% 'High-level' $blocks
%
% $STATION;
%   def_STATION ... cell array of all station names
%   ref_SITE ... cell array of references to site
%   ref_ANTENNA ... cell array of references to antenna
%   ref_DAS ... 3d cell array of references to das block

%% $SCHED block
%
%   scan_names ... list of all scan names (string: 024-1100)
%   start ... list of all start times (string: 2019y024d11h00m00s)
%   mode ... list of all modes
%   source ... source names for all scans
%   station ... cell array with all station per scan
%   datastart ... nominal start time of good data
%   datastop ... nominal stop time of good data
%   startpos ... tape position in ft or m (only for tape)
%   pass ... tape pass (only for tape)
%   drive ... physical drive (only tape)

fprint_sched(fileID, comment_line, s)

%% fprintf $CLOCK
fprint_clock(fileID, s)

%% print $EOP
fprint_EOP(fileID,  s.(stations{iSt}).EOP_vex)

%% close vex file
fclose(fileID);

end

