function [db] = define_input_databases(session_label,data_version,data_file)

if strcmp(session_label,'VO1021')
    if data_version==3
        db.c2a_file_name='data/C2A_0059581_all.txt';
        db.c2a_data_format='corasc2_with_channel_pcal';
    end
    
end

if contains(session_label,'mcs')
    if data_version==3
        db.c2a_file_name=['data/snr_37/',session_label];
        db.c2a_data_format='corasc2_with_channel_pcal';
    end
end

if contains(session_label,'VGOSM')
    db.c2a_file_name=data_file;
    if data_version==3
        db.c2a_data_format='corasc2_with_channel_pcal';
    end
    if data_version==4
        db.c2a_data_format= 'corasc2_with_amplitude';
    end
end

end

