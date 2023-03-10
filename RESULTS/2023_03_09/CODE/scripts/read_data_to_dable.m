function [T] = read_data_to_dable(data_file,data_format)

if strcmp(data_format,'hops_aedit_pwrite')
    T = readtable(data_file,'ReadVariableNames',0);% read data
    T.Properties.VariableNames = {'scan_name','source_name','notimportant','integration_time','snr','qcode'};
end

if strcmp(data_format,'corasc2_v1')
    T = readtable(data_file,'ReadVariableNames',0);% read data
    T.Properties.VariableNames = {'scan_name' 'yyyy_frt' 'doy_frt' 'hhmmss_frt' 'yyyy_start' 'doy_start' 'hhmmss_start' 'yyyy_stop' 'doy_stop' 'integration_time' 'hhmmss_stop' 'qcode' 'apriori_delay_frt' 'apriori_rate_frt' 'apriori_accel_frt' 'tot_mbd' 'tot_sbd' 'tot_rate' 'resid_mbd' 'resid_sbd' 'resid_rate' 'mbd_error' 'sbd_error' 'rate_error' 'snr'};
end

if strcmp(data_format,'corasc2_v2')
    T = readtable(data_file,'ReadVariableNames',0);% read data
    T.Properties.VariableNames = {'scan_name' 'source_name' 'yyyy_frt' 'doy_frt' 'hhmmss_frt' 'yyyy_start' 'doy_start' 'hhmmss_start' 'yyyy_stop' 'doy_stop' 'hhmmss_stop' 'integration_time' 'qcode' 'apriori_delay_frt' 'apriori_rate_frt' 'apriori_accel_frt' 'tot_mbd' 'tot_sbd' 'tot_rate' 'resid_mbd' 'resid_sbd' 'resid_rate' 'mbd_error' 'sbd_error' 'rate_error' 'snr'};
end

if strcmp(data_format,'corasc2_v3')
    T = readtable(data_file,'ReadVariableNames',0);% read data
    T.Properties.VariableNames = {'scan_name' 'source_name' 'yyyy_frt' 'doy_frt' 'hhmmss_frt' 'yyyy_start' 'doy_start' 'hhmmss_start' 'yyyy_stop' 'doy_stop' 'hhmmss_stop' 'integration_time' 'qcode' 'apriori_delay_frt' 'apriori_rate_frt' 'apriori_accel_frt' 'tot_mbd' 'tot_sbd' 'tot_rate' 'resid_mbd' 'resid_sbd' 'resid_rate' 'mbd_error' 'sbd_error' 'rate_error' 'snr' 'baseline'};
end

if strcmp(data_format,'corasc2_v4')
    T = readtable(data_file,'ReadVariableNames',0);% read data
    T.Properties.VariableNames = {'scan_name' 'source_name' 'yyyy_frt' 'doy_frt' 'hhmmss_frt' 'yyyy_start' 'doy_start' 'hhmmss_start' 'yyyy_stop' 'doy_stop' 'hhmmss_stop' 'integration_time' 'qcode' 'apriori_delay_frt' 'apriori_rate_frt' 'apriori_accel_frt' 'tot_mbd' 'tot_sbd' 'tot_rate' 'resid_mbd' 'resid_sbd' 'resid_rate' 'mbd_error' 'sbd_error' 'rate_error' 'snr' 'baseline' 'prob_false' 'totphase' 'totphase_ref' 'resphase' 'tec_error'};
end

if strcmp(data_format,'corasc2_v5')
    T = readtable(data_file,'ReadVariableNames',0);% read data
    T.Properties.VariableNames = {'date' 'name' 'scan_name' 'source_name' 'yyyy_frt' 'doy_frt' 'hhmmss_frt' 'yyyy_start' 'doy_start' 'hhmmss_start' 'yyyy_stop' 'doy_stop' 'hhmmss_stop' 'integration_time' 'qcode' 'apriori_delay_frt' 'apriori_rate_frt' 'apriori_accel_frt' 'tot_mbd' 'tot_sbd' 'tot_rate' 'resid_mbd' 'resid_sbd' 'resid_rate' 'mbd_error' 'sbd_error' 'rate_error' 'snr' 'baseline' 'prob_false' 'totphase' 'totphase_ref' 'resphase' 'tec_error'};
end

if strcmp(data_format,'corasc2_v6')
    T = readtable(data_file,'ReadVariableNames',0);% read data
    T.Properties.VariableNames = {'filename' 'pol_label' 'date' 'name' 'scan_name' 'source_name' 'yyyy_frt' 'doy_frt' 'hhmmss_frt' 'yyyy_start' 'doy_start' 'hhmmss_start' 'yyyy_stop' 'doy_stop' 'hhmmss_stop' 'integration_time' 'qcode' 'apriori_delay_frt' 'apriori_rate_frt' 'apriori_accel_frt' 'tot_mbd' 'tot_sbd' 'tot_rate' 'resid_mbd' 'resid_sbd' 'resid_rate' 'mbd_error' 'sbd_error' 'rate_error' 'snr' 'baseline' 'prob_false' 'totphase' 'totphase_ref' 'resphase' 'tec_error'};
end

if strcmp(data_format,'corasc2_with_channel_pcal')
    T = readtable(data_file,'ReadVariableNames',0,'Delimiter',',');% read data
    T.Properties.VariableNames = {'filename' 'pol_label' 'date' 'name' 'scan_name' 'source_name' 'yyyy_frt' 'doy_frt' 'hhmmss_frt' 'yyyy_start' 'doy_start' 'hhmmss_start' 'yyyy_stop' 'doy_stop' 'hhmmss_stop' 'integration_time' 'qcode' 'apriori_delay_frt' 'apriori_rate_frt' 'apriori_accel_frt' 'tot_mbd' 'tot_sbd' 'tot_rate' 'resid_mbd' 'resid_sbd' 'resid_rate' 'mbd_error' 'sbd_error' 'rate_error' 'snr' 'baseline' 'prob_false' 'totphase' 'totphase_ref' 'resphase' 'tec_error' 'pcal_ampl_ref' 'pcal_ampl_rem' 'pcal_phase_ref' 'pcal_phase_rem' 'pcal_phase_offset_ref' 'pcal_phase_offset_rem' 'res_ampl' 'res_phase'}; 
end

if strcmp(data_format,'corasc2_with_amplitude')
    T = readtable(data_file,'ReadVariableNames',0,'Delimiter',',');% read data
    T.Properties.VariableNames = {'filename' 'pol_label' 'date' 'name' 'scan_name' 'source_name' 'yyyy_frt' 'doy_frt' 'hhmmss_frt' 'yyyy_start' 'doy_start' 'hhmmss_start' 'yyyy_stop' 'doy_stop' 'hhmmss_stop' 'integration_time' 'qcode' 'apriori_delay_frt' 'apriori_rate_frt' 'apriori_accel_frt' 'tot_mbd' 'tot_sbd' 'tot_rate' 'resid_mbd' 'resid_sbd' 'resid_rate' 'mbd_error' 'sbd_error' 'rate_error' 'snr' 'baseline' 'prob_false' 'totphase' 'totphase_ref' 'resphase' 'tec_error'  'ambiguity' 'amplitude' 'inc_seg_ampl' 'inc_chan_ampl' 'pcal_ampl_ref' 'pcal_ampl_rem' 'pcal_phase_ref' 'pcal_phase_rem' 'pcal_phase_offset_ref' 'pcal_phase_offset_rem' 'res_ampl' 'res_phase' 'nlags'}; 
end

% new format 20.8.2021
% echo -n "${1}, ${2}, $date, $name, $scan_name, $source_name, $yyyy, $doy, $hhmmss, $yyyy_start, $doy_start, $hhmmss_start, $yyyy_stop, $doy_stop, $hhmmss_stop, $intg_time, $qcode, $adelay_frt, $arate_frt, $aaccel_frt, $tot_mbd, $tot_sbd, $tot_rate, $resid_mbd, $resid_sbd, $resid_rate, $mbd_error, $sbd_error, $rate_error, $snr, $ref_name $rem_name, $prob_false, $totphase, $totphase_ref, $resphase, $tec_error, $ambiguity, $amplitude, $inc_seg_ampl, $inc_chan_ampl, " >
end



