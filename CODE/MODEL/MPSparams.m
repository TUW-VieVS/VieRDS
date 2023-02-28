function [s] = MPSparams(s, controling, ref_frame )
% multi-point source (MPS) param calculation
%
% input:
%   s ... params struct
%
% output:
%   s ... params struct

if s.mpsd_i == 1

    % MPS channel allocation
    s.mps_J = mps2channel(s.fa, s.fb, s.multi_point_source_data(:,2), s.multi_point_source_data(:,3));

    % data struct
    [s.MPS, s.mpsd_i] = createMPSstruct(s.mps_J, s.multi_point_source_data);

    if s.mpsd_i == 1

        % number of point sources
        N = length(s.MPS);
    
        % assign to struct
        s.number_of_MPS = N;
    
        % amplitude
        for i = 1:N
            
            % flux density to temperature
            s.MPS(i).temp_targetsource = fluxdensity2temperature( s.MPS(i).Sf , s.effective_area_telescope );
    
            % source power
            s.MPS(i).power_targetsource   = temp2power ( s.MPS(i).temp_targetsource , s.bandwidth );
            
            % sigma, only valid if signal is a gaussian noise
            s.MPS(i).sigma_targetsource   = sqrt(s.MPS(i).power_targetsource);
    
        end
        
        % reference in time and space: retarded geocenter delay at reference points
        if ~isempty(fieldnames(ref_frame))
            
            % calculate params in space-time reference for each point source                     
            for i = 1:N
    
                % a priori source coordinates
                s.s_crf_sph = [s.MPS(i).RA_rad, s.MPS(i).DE_rad]';
                
                % basic source specs per station
                [s] = source_specs_per_station_basic(s);
                
                % calculate p_tm struct per souce
                tmp = modelparams_referenceframe(s, ref_frame, controling);   
                
                % source coordinates
                s.MPS(i).s_crf_sph = tmp.s_crf_sph;
    
                % CRF flag
                s.MPS(i).take_CRF_coord = tmp.take_CRF_coord;
    
                % signal arrival time at station
                s.MPS(i).signal_arrival_time = tmp.signal_arrival_time;
                s.MPS(i).signal_arrival_time_offset = tmp.signal_arrival_time_offset;
                s.MPS(i).index_for_ptm_signal_arrivaL_time = tmp.index_for_ptm_signal_arrivaL_time;
    
                % kinematic model params
                s.MPS(i).p_tm = tmp.p_tm;
    
                % delay (time dependent)
                [s.MPS(i).tau, s.MPS(i).signal_arrives_at_station  ] = modelparams_delaytau_MPS(s.MPS(i).p_tm, s.sampling_interval, s.delay_rate_interpolation_interval, s.delay_rate_interpolation_method, s.MPS(i).index_for_ptm_signal_arrivaL_time, s.fa);
                
            end
        end
    end
end

end

