function [s] = MPSparams(s)
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
     
    % add main source component to MPS struct ... 
    
    % data matrix
    s.MPS = createMPSstruct(s.mps_J, s.multi_point_source_data);
    
    % amplitude ...
    
    % geocenter delay ... 

end

end

