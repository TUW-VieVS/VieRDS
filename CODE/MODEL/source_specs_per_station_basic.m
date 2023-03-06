function [params] = source_specs_per_station_basic(params)
% source specifications per station

if isfield( params , 's_crf_sph' )
    % RA: transform ra [rad] to hour
    params.source_ra_h = floor( params.s_crf_sph(1)*24/(2*pi) );

    % RA: transfrom ra [rad] to min
    params.source_ra_m = floor( (params.s_crf_sph(1)*24/(2*pi) - params.source_ra_h ) *60 );

    % RA: transfrom ra [rad] to s
    params.source_ra_s = ((params.s_crf_sph(1)*24/(2*pi) - params.source_ra_h ) *60- params.source_ra_m ) *60 ;

    % RA: xxhxxmxx.xxxxxs
    params.source_ra_str = sprintf('%02.0fh%02.0fm%02.5fs',params.source_ra_h, params.source_ra_m, params.source_ra_s );


    % transform de [rad] to dms vec
    params.source_de_dmsvec = degrees2dms(abs(params.s_crf_sph(2))*180/pi); % work with positiv values in degree2dms function
    params.source_de_dmsvec(1) = sign(params.s_crf_sph(2))*params.source_de_dmsvec(1); % assign sign to first entry

    % xxdxx'xx.xxxxx''
    params.source_de_str = sprintf('%02.0fd%02.0f''%02.5f"',params.source_de_dmsvec(1), params.source_de_dmsvec(2), params.source_de_dmsvec(3) );
end
end