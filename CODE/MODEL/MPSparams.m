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
    [s.mps_J] = mps2channel(s.fa, s.fb, s.multi_point_source_data(:,1), s.multi_point_source_data(:,2));
     
    % data matrix
    s.MPS = createMPSstruct(s.mps_J, s.multi_point_source_data);
    
    % amplitude ...
    
    % reference in time and space: retarded geocenter delay at reference points
    if ~isempty(fieldnames(ref_frame))
        
        % calculate params in space-time reference for each point source
        
        % number of point sources
        N = length(s.MPS);
        
        for i = 1:N

            % a priori source coordinates
            s.s_crf_sph = [s.MPS(i).RA_rad, s.MPS(i).DE_rad]';
            
            % calculate p_tm struct per souce
            s = modelparams_referenceframe(s, ref_frame, controling);   
            
            s.MPS(i).p_tm = s.p_tm;
            
        end
    end

end

end

