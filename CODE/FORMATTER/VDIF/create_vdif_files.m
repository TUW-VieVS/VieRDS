function SIM_sta = create_vdif_files(CH_ind, SIM_sta, controling)
% create vdif files
% input:
%   CH_ind ... channel info per station
%   SIM_sta ... cell with station struct per element


% station names and number of stations
[ stations, NSt ] = station_struct_label( CH_ind );

% vdif file per station
for iSt = 1:NSt
    
    % channel index
    ch_ind = CH_ind.(stations{iSt});
    
    % number of channels
    NCh = length(ch_ind);
    
    % number of samples from first channel
    NSa = SIM_sta{ch_ind(1),1}.(stations{iSt}).num_samples_scan;
    
    % preallocate
    SAMPLES = zeros( NCh, NSa );
    
    % store simulated samples channel wise in SAMPLES
    for iCh = 1:NCh
        SAMPLES(iCh,:) = SIM_sta{ch_ind(iCh),1}.(stations{iSt}).x_quant;
        SIM_sta{ch_ind(iCh),1}.(stations{iSt}).x_quant = [];
    end
    
    % special label vdif file name
%     special_label = 'test';
%     SIM_sta{ch_ind(1),1}.(stations{iSt}).special_label = 'feb';

    % vdif file name (values from first channel):
    vdif_file_name = create_vdif_filename(SIM_sta{ch_ind(1),1}.(stations{iSt}).station_name, SIM_sta{ch_ind(1),1}.(stations{iSt}).sampling_frequency*10^-6, SIM_sta{ch_ind(1),1}.(stations{iSt}).number_of_bits, NCh, SIM_sta{ch_ind(1),1}.(stations{iSt}).scan_length, SIM_sta{ch_ind(1),1}.(stations{iSt}).vdif_special_label_str, SIM_sta{ch_ind(1),1}.(stations{iSt}).vdif_special_label_int);
    
    % vdif file name according to OUT folder
    output_dir = [controling.output_folder_long];
    
    % convert range of values
    SAMPLES= matlab2vdif_samples(SAMPLES);
    
    % create vdif file
    vdif = writeVDIF( output_dir,vdif_file_name , SIM_sta{ch_ind(1),1}.(stations{iSt}).frame_length_byte , SIM_sta{ch_ind(1),1}.(stations{iSt}).header_length_byte , SIM_sta{ch_ind(1),1}.(stations{iSt}).date_vec , SIM_sta{ch_ind(1),1}.(stations{iSt}).scan_length , SIM_sta{ch_ind(1),1}.(stations{iSt}).sampling_frequency , SIM_sta{ch_ind(1),1}.(stations{iSt}).vdif_version_number , NCh , SIM_sta{ch_ind(1),1}.(stations{iSt}).number_of_bits , SIM_sta{ch_ind(1),1}.(stations{iSt}).station_name , SAMPLES );
    
    % print empty line
    fprintf('\n')
    
    % vsum
    vsum_bbs(vdif_file_name, vdif.filesize_bit/8, 1, 0, vdif.frame_length_byte, NaN, vdif.number_of_bits_per_sample, vdif.hyf2000  , vdif.mjd, vdif.second_start, 0, vdif.second_end, vdif.number_frames_file, 0)
    
    % print empty line
    fprintf('\n')
end

end

