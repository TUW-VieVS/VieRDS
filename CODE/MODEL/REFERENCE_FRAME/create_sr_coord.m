function [s_crf_sph, s_crf_cart, take_CRF_coord] = create_sr_coord(p, r)
% create source coordinate vector (spherical and cartesian)
%
% input:
%   p ... params struct
%   r ... struct with CRF databases
%
% output:
%   s_crf_sph ... 2D vector with spherical coordinates (RA, DE) in rad
%   s_crf_cart ... 3D vector with cartesian coordinates [x,y,z] with unit length
%   take_CRF_coord ... flag for CRF database (yes: take or no:take not) 

% print warning that s_crf_cart as input is not supported
if isfield(p,'s_crf_cart')
    warning('s_crf_cart as input is not supported, please use spherical coordinates (s_crf_sph)')
end

% take explicitly set CRF coordinates
if isfield(p,'s_crf_sph')
      
    % assign to more specif variable name 
    s_crf_sph = p.s_crf_sph;
    
    % set flag to 0
    take_CRF_coord = 0;
else
    
    % set flag to 1
    take_CRF_coord = 1;
    
end

% assign to short variable name
srn = p.source_name;

% get source coordinates
if take_CRF_coord == 1

    % index: find station name in CRF DB
    i_fs = strcmp(srn, r.IVS_source_name{1});
    
    % get ra coordinate [rad]
    ra = r.crf(i_fs).vievsCrf.ra;
    
    % get de coordinate [rad]
    de = r.crf(i_fs).vievsCrf.de;
    
    % create s_crf_sph variable
    s_crf_sph = [ra, de]';

end

% sr: reshape to correct dimensions
s_crf_sph = reshape(s_crf_sph,[2,1]);

% calculate cartesian coordinates for source from spherical coordinates (lenght = 1)
[s_crf_cart(1), s_crf_cart(2), s_crf_cart(3)] = sph2cart(s_crf_sph(1), s_crf_sph(2), 1);

% check length
if norm(s_crf_cart)~=1
    warning('s0 does not have length 1 ... danger')
end

end

