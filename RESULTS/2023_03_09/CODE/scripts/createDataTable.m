function [Tdata,Tfile,Tpoli,pol_label,sch] = createDataTable(fn_data,data_format,fn_filelist,fn_pol2file)

% read data
Tdata = readData(fn_data,data_format);
[N_data_points,N_params]=size(Tdata);
Tfile=[];
Tpoli=[];
pol_label={'XX','XY','YX','YY'};

if strcmp(data_format,'corasc2_v4')
    Tfile = readtable(fn_filelist,'ReadVariableNames',0);
    % Tfile.Properties.VariableNames = {'scan_name','file_name'};
    Tfile.Properties.VariableNames = {'file_name'};

    Tpoli = readtable(fn_pol2file,'ReadVariableNames',0);
    
    % add polarization to table
    % polarization label
    % XX = 1
    % XY = 2
    % YX = 3
    % YY = 4
    [N_poli_dp,~]=size(Tpoli);

    % assign file names to Tdata
    Tdata.file_name = Tfile.file_name;
    pol_id = zeros(1,N_data_points);

    for i=1:N_poli_dp
        str_i=Tpoli.Var29{i};
        if isempty(str_i)
            fprintf('ffres2pcp DEBUG problem line: %d\n',i)
            Tpoli.file_name{i}='ERR';
        else
            str_i(end-1:end)=[];
            Tpoli.file_name{i}=str_i;
            pol_string = Tpoli.Var1{i};
            pol_prod_i=pol_string(strfind(pol_string,'-P')+3:strfind(pol_string,'-P')+4);

            T_index=find(ismember(Tdata.file_name,str_i));
            pol_id(T_index) = find(strcmp(pol_prod_i,pol_label));

        end

    end

    Tdata.pol_id=pol_id';

end

if strcmp(data_format,'corasc2_v6') || strcmp(data_format,'corasc2_with_channel_pcal')
    pol_id=zeros(N_data_points,1);
    for ipol=1:length(pol_label)
        ipoll=pol_label{ipol};
        idi=strcmp(Tdata.pol_label,ipoll);
        pol_id(idi)=ipol;
    end
    Tdata.pol_id=pol_id;

end

if strcmp(data_format,'corasc2_with_channel_pcal')
    sch=struct;
    
    VAR_str = {'pcal_ampl_ref','pcal_ampl_rem','pcal_phase_ref','pcal_phase_rem','pcal_phase_offset_ref','pcal_phase_offset_rem','res_ampl','res_phase'};
    
    for i=1:N_data_points
        for j=1:length(VAR_str)
            var_str=VAR_str{j};
            if strfind(var_str,'pcal')
                val_orig = str2double(strsplit(Tdata.(var_str){i}));
                val_sort = zeros(1,length(val_orig));
                val_sort(1:16) = val_orig(1:2:32);
                val_sort(1:2:32) = val_orig(1:16);
                val_sort(2:2:32) = val_orig(17:32);
            else
                val_sort = str2double(strsplit(Tdata.(var_str){i}));
            end                

            sch(i).(var_str)=val_sort;

        end
    end
    
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

end

