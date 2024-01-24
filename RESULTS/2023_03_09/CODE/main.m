
clear all;
close all,

addpath('scripts/');


%node01
%Integer delay: -5
%Fractional sample delay: 0.010145
%fs=16*10^6;
%Tx=1/fs:
%Relative delay: 0.000000 (ns)Relative delay: -0.007982 (ns)Relative delay: -311.876337 (ns)Relative delay: -311.873938 (ns)
%% true delay
amb=31.25002; % (ns)
Namb=10;
% amb=50.00002;
% Namb=6;

true.delay=-[-311.876337, -311.865957, -311.855576, -311.845195, -311.834814, -311.824433, -311.772529, -311.668721, -311.564913, -311.461105]-Namb*amb;
true.deltaRaDe = [0,0.1,0.2,0.3,0.4,0.5,1,2,3,4];

%% read in all fringe-fitting data
i_exp=1;
DATA_DIR = {'VGOS480_32MHz'};
% DATA_DIR = {'VGOS480_8MHz'};
% DATA_DIR = {'X_8MHz'};

DATA_FILE = {'n00','n01','n02','n03','n04','n05','n06','n07','n08','n09'};

for i=1:length(DATA_FILE)

    % session
    % session_label='all_mcs.txt';
    % session_label='';
    fsetup='VGOS480';
    % data_file='../DATA/c2a_out/data_2023_03_09_03_31_PM_node2.txt';
    % data_file='../DATA/c2a_out/data_2023_03_09_03_39_PM_node3.txt';
    data_dir=['../DATA/',DATA_DIR{i_exp},'/c2a_out/'];
    data_file=DATA_FILE{i};
    data_file_long=[data_dir,data_file,'.txt'];

    % true_delay = 0.311866*10^-6;
    session_label=['VGOSM_F',fsetup];
    data_version=4;

    % define colors
    [setup.my_colors] = define_colors(1);

    % define frequencies
    [freq] = define_frequencies(session_label);

    % define polarization
    [pol] = define_polarization(session_label);

    % define stations
    [stat] = define_stations(session_label);

    % define input databases
    [db] = define_input_databases(session_label,data_version,data_file_long);

    iamp=1;
    ipha=0;
    ireadtext=0;

    %% read data Cor2Asc data
    % struct
    [sdata] = read_c2a_data(db,pol);
    %%
    % single point source
    id_one = 1:50;
    ta.one = sdata(id_one);
    if i>1
        % two point sources
        id_two =51:100;


        ta.two = sdata(id_two);
    end

    DATA.(data_file)=sdata;
    T.(data_file)=ta;

    %calculate statistics
    T.(data_file).stats.one.mbd.avg=mean([ta.one.resid_mbd]);
    T.(data_file).stats.one.mbd.sig=sqrt(var([ta.one.resid_mbd]));
    T.(data_file).stats.one.mbd.sig_theory=mean([ta.one.mbd_error]);
    T.(data_file).stats.one.sbd.avg=mean([ta.one.resid_sbd]);
    T.(data_file).stats.one.sbd.sig=sqrt(var([ta.one.resid_sbd]));
    T.(data_file).stats.one.snr.avg=mean([ta.one.snr]);
    T.(data_file).stats.one.snr.sig=sqrt(var([ta.one.snr]));
    T.(data_file).stats.one.N=length([ta.one.resid_mbd]);

    if isfield(T.(data_file), 'two')
        T.(data_file).stats.two.mbd.avg=mean([ta.two.resid_mbd]);
        T.(data_file).stats.two.mbd.sig=sqrt(var([ta.two.resid_mbd]));
        T.(data_file).stats.two.mbd.sig_theory=mean([ta.two.mbd_error]);
        T.(data_file).stats.two.sbd.avg=mean([ta.two.resid_sbd]);
        T.(data_file).stats.two.sbd.sig=sqrt(var([ta.two.resid_sbd]));
        T.(data_file).stats.two.snr.avg=mean([ta.two.snr]);
        T.(data_file).stats.two.snr.sig=sqrt(var([ta.two.snr]));
        T.(data_file).stats.two.N = length([ta.two.resid_mbd]);

    else
        T.(data_file).stats.two.mbd.avg=mean([ta.one.resid_mbd]);
        T.(data_file).stats.two.mbd.sig=sqrt(var([ta.one.resid_mbd]));
        T.(data_file).stats.two.mbd.sig_theory=mean([ta.one.mbd_error]);
        T.(data_file).stats.two.sbd.avg=mean([ta.one.resid_sbd]);
        T.(data_file).stats.two.sbd.sig=sqrt(var([ta.one.resid_sbd]));
        T.(data_file).stats.two.snr.avg=mean([ta.one.snr]);
        T.(data_file).stats.two.snr.sig=sqrt(var([ta.one.snr]));
        T.(data_file).stats.two.N = length([ta.one.resid_mbd]);
    end

end

%% print data
% single-point source0

type_delay = 'mbd';

data_set_id = 1;


printTable4SingleSource1(true,T,type_delay,data_set_id);

data_set_id = 1:10;

printTable4SingleSourceIdRange(true,T,type_delay,data_set_id)


%% plot data
% close all
% single-point source
type_delay = 'mbd';

for data_set_id=1:10

    plotSingleSource1(true,T,type_delay,data_set_id,DATA_DIR{i_exp})

end
% single-point displacement (mas) and group delay relation (ps)
data_set_id=1:10;
plotSingleSrcDisplDelayRelation(true,T,type_delay,data_set_id,DATA_DIR{i_exp})

% plot data

%% print data: two source
printTable4DoubleSourceIdRange(true,T,type_delay,data_set_id)

%% plot data: two source
data_set_id=1:10;
plotDoubleSourceIdRange(true,T,type_delay,data_set_id,DATA_DIR{i_exp})

%%
% close all;
data_set_id=2:10;

plotDoubleSource(true,T,type_delay,data_set_id,DATA_DIR{i_exp})


%% print data
% single-point source
fprintf('delta Ra De (mas), true delay (ps), average fourfit mbd (ps), sigma fourfit mbd (ps), average fourfit sbd (ps), average snr, average sigma, N\n')

fn = fieldnames(T);
for i=1:length(fn)

    % delta (mas)
    x1= true.deltaRaDe(i);

    % true delay (ps)
    x2=true.delay(i)*10^3;

    % average fourfit mbd (ps)
    x3 = T.(fn{i}).stats.one.mbd.avg*10^6;

    % sigma fourfit mbd (ps)
    x4 = T.(fn{i}).stats.one.mbd.sig*10^6;

    % average fourfit sbd (ns)
    x5 = (T.(fn{i}).stats.one.sbd.avg*10^3-amb*10)*10^3;

    % sigma fourfit sbd (ns)
    x6 = T.(fn{i}).stats.one.sbd.sig*10^6;

    % average snr
    x7 = T.(fn{i}).stats.one.snr.avg;

    % average sigma
    x8 = T.(fn{i}).stats.one.snr.sig;

    % number of samples
    x9 = length(T.(fn{i}).one);

    fprintf('%.1f, %.3f, %.3f, %.3f, %.3f, %.3f, %.2f, %.1f, %d\n',x1, x2, x3, x4, x5, x6, x7, x8, x9)

end

%% plot
close all
% plotT(T.n00);
