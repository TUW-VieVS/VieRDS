clear all;
format long

% convert source coordinates

% 0333+321,
% from: http://ivsopar.obspm.fr/radiosources/search.php?source=0333%2B321,
% ra (deg)

for id = 1

    source(id).name = '0333+321';
    source(id).ra.deg = 54.1254483658357;
    source(id).de.deg = 32.3081511171028;
    
    % offset
    for id_off=1
        % ra milliarcsec offset
        source(id).ra.offset(id_off).milliarcsec = 50.0;
        % de milliarcsec offset
        source(id).de.offset(id_off).milliarcsec = 50.0;
        
        % ra: deg2hms
        [source(id).ra.hms(1),source(id).ra.hms(2),source(id).ra.hms(3)] = deg2hms(source(id).ra.deg);
        source(id).ra.deg_test = rad2deg(hms2rad(source(id).ra.hms(1),source(id).ra.hms(2),source(id).ra.hms(3)));
        source(id).ra.deg_delta = source(id).ra.deg_test - source(id).ra.deg;
        
        % milliarcsec offset
        source(id).ra.offset(id_off).arcsec = source(id).ra.offset(id_off).milliarcsec*10^-3;
        source(id).ra.offset(id_off).deg = dms2degrees([0,0,source(id).ra.offset(id_off).arcsec]);
        source(id).ra.offset(id_off).deg_new =  source(id).ra.deg+source(id).ra.offset(id_off).deg;
        [source(id).ra.offset(id_off).hms(1),source(id).ra.offset(id_off).hms(2),source(id).ra.offset(id_off).hms(3)] = deg2hms(source(id).ra.offset(id_off).deg_new);
        
        % de: degrees2dms
        source(id).de.dms=degrees2dms(source(id).de.deg);
        source(id).de.offset(id_off).arcsec = source(id).de.offset(id_off).milliarcsec*10^-3;
        source(id).de.offset(id_off).deg = dms2degrees([0,0,source(id).de.offset(id_off).arcsec]);
        source(id).de.offset(id_off).deg_new =  source(id).de.deg+source(id).de.offset(id_off).deg;
        source(id).de.offset(id_off).dms=degrees2dms(source(id).de.offset(id_off).deg_new);
        
        if id_off == 1
            fprintf('%s\n',source(id).name)
            fprintf('%02dh%02dm%02.12fs, %02dd%02d''%02.12f"  \n',source(id).ra.hms, source(id).de.dms)            
        end
        fprintf('%02dh%02dm%02.12fs, %02dd%02d''%02.12f"  \n',source(id).ra.offset(id_off).hms, source(id).de.offset(id_off).dms) 
    end
end
