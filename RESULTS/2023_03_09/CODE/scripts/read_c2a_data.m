function [sdata] = read_c2a_data(db,pol)
% input:
%   db ... database infos to read in
%   pol ... polarization infos

% read data to table
Tdata = read_data_to_dable(db.c2a_file_name,db.c2a_data_format);

% get number of rows of table
[N_data_points,~]=size(Tdata);

% add polarization id to table
if strcmp(db.c2a_data_format,'corasc2_v6') || strcmp(db.c2a_data_format,'corasc2_with_channel_pcal') || strcmp(db.c2a_data_format,'corasc2_with_amplitude')
    pol_id=zeros(N_data_points,1);
    for ipol=1:length(pol.products)
        ipoll=pol.products{ipol};
        idi=strcmp(Tdata.pol_label,ipoll);
        pol_id(idi)=ipol;
    end
    Tdata.pol_id=pol_id;
end

% add datenum
for i=1:N_data_points
    y=Tdata.yyyy_start(i);
    m=1;
    doy=Tdata.doy_start(i);
    h=num2str(Tdata.hhmmss_start(i));
    if length(h)==6
        hh=str2double(h(1:2));
        mm=str2double(h(3:4));
        ss=str2double(h(5:6));
    elseif length(h)==5
        hh=str2double(h(1));
        mm=str2double(h(2:3));
        ss=str2double(h(4:5));
    elseif length(h)==4
        hh=0;
        mm=str2double(h(1:2));
        ss=str2double(h(3:4));
    elseif length(h)==3
        hh=0;
        mm=str2double(h(1));
        ss=str2double(h(2:3));
    elseif length(h)==2
        hh=0;
        mm=0;
        ss=str2double(h(1:2));
    elseif length(h)==1
        hh=0;
        mm=0;
        ss=str2double(h(1));
    end
    
    Tdata.datenum(i)=datenum([y,m,doy,hh,mm,ss]);
    
     [~, MM, dd, ~, ~] = datevec(datenum(y,m,doy));
    Tdata.datetime(i)=datetime(y,MM,dd,hh,mm,ss);
    Tdata.mjd(i)=mjuliandate(datevec(Tdata.datetime(i)));
    
end

% add corrected pcal data to table
if strcmp(db.c2a_data_format,'corasc2_with_channel_pcal') || strcmp(db.c2a_data_format,'corasc2_with_amplitude')
    sdata=struct;
    
%     VAR_str = {'pcal_ampl_ref','pcal_ampl_rem','pcal_phase_ref','pcal_phase_rem','pcal_phase_offset_ref','pcal_phase_offset_rem','res_ampl','res_phase'};
    VAR_str = Tdata.Properties.VariableNames;
    for i=1:N_data_points
        for j=1:length(VAR_str)
            var_str=VAR_str{j};
            if iscell(Tdata.(var_str)(i))
                val_sort = Tdata.(var_str){i};
            else
                val_sort = Tdata.(var_str)(i);
            end
            

%             if strfind(var_str,'pcal')
%                 val_orig = str2double(strsplit(Tdata.(var_str)(i)));
%                 val_sort = zeros(1,length(val_orig));
%                 val_sort(1:16) = val_orig(1:2:32);
%                 val_sort(1:2:32) = val_orig(1:16);
%                 val_sort(2:2:32) = val_orig(17:32);
%             end
%             if strfind(var_str,'res_')
%                 val_sort = str2double(strsplit(Tdata.(var_str){i}));
%             end                

            sdata(i).(var_str)=val_sort;

        end
    end
    
end

end

