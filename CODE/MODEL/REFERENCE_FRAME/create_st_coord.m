function [X_trf, take_TRF_coord] = create_st_coord(p, r)
% create TRF station coordinates vector
%
% input:
%   p ... params struct
%   r ... struct with TRF databases
%
% output:
%   X_trf ... vector with station coordinates from TRF database [m]
%   take_TRF_coord ... flag for TRF database (yes: take or no:take not)


% create TRF flag
if isfield(p, 'X_trf')
    
    % assign to X_trf variable
    X_trf = p.X_trf;
    
    % set flag to 0
    take_TRF_coord = 0;

else
    % set flag to 1
    take_TRF_coord = 1;
    
end

% assign to short variable name
stn = p.station_name_trf_coord;

% get station coordinates from external database
if take_TRF_coord == 1
    
    % index: find station name in TRF DB
    i_fld = strcmp(stn, r.lc2{1});
    
    if sum(i_fld) == 0
        warning('Cannot find station in TRF database: %s', stn)
    end
    
    if sum(i_fld) > 1
        warning('Several entries in TRF database for station: %s',stn)
        warning('   The first entry will be taken')
        Nfld = length(i_fld);
        i_fld_1 = zeros(1,Nfld);
        ind_fld = find(i_fld == 1);
        i_fld_1(ind_fld(1)) = 1;
        i_fld = i_fld_1;
    end
    
    % extract x-coordinate
    x = r.trf(i_fld).vievsTrf.break(1).x;
    
    % extract y-coordinate
    y = r.trf(i_fld).vievsTrf.break(1).y;
    
    % extract z-coordinate
    z = r.trf(i_fld).vievsTrf.break(1).z;
    
    % create X_trf variable
    X_trf = [x, y, z]';
    
end

% st: reshape to correct dimensions
X_trf = reshape(X_trf,[3,1]);

end

