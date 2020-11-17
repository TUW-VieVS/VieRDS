function [params] = modelparams_basics(params)

% sampling interval in sec
params.sampling_interval        = 1/params.sampling_frequency; 

% number of samples of total scan
params.num_samples_scan         = ceil(params.sampling_frequency*params.scan_length); 

% new scan length
scan_length = params.num_samples_scan/params.sampling_frequency;

if scan_length~=params.scan_length
    warning('scan length is adjusted in order to get integer number of samples')
    fprintf('scan length: %f ns (old)\n',params.scan_length*1e9)
    fprintf('scan length: %f ns (new)\n', scan_length*1e9)
    params.scan_length = scan_length;
end

% spectral resolution based on the baseband bandwidth and the length of the signal in Hz
params.spectral_resolution      = 1/params.scan_length; 

% lowest frequency of bandwidth signal [Hz]
params.fa                       = params.f0 - params.bandwidth/2;

% highest frequency of bandwidth signal [Hz]
params.fb                       = params.f0 + params.bandwidth/2;

if isfield( params , 's_crf_sph' )
    
    % DE: check range of value, more than +/s 90°
    RA_plus = 0;
    if abs(params.s_crf_sph(2)) > pi/2
        if params.s_crf_sph(2) > pi/2 && params.s_crf_sph(2) <= pi
            params.s_crf_sph(2) = pi/2-mod(params.s_crf_sph(2),pi/2);
            RA_plus = pi;
        else
            params.s_crf_sph(2) = -pi/2-mod(params.s_crf_sph(2),pi/2);
            RA_plus = pi;            
        end 
    end
    
    % in case |DE| is larger than 90° use opposite RA
    params.s_crf_sph(1) = params.s_crf_sph(1)+RA_plus;
    
    % RA: check range of value, larger than 2*pi
    if params.s_crf_sph(1) >= 2*pi
        
        % print warning
        fprintf('input RA: %f\n', params.s_crf_sph(1))
        
        % calculate new RA
        params.s_crf_sph(1) = mod(params.s_crf_sph(1),2*pi);
        fprintf('new RA: %f\n', params.s_crf_sph(1));
        
    end
    
    % RA: check range of value, smaller than 0
    if params.s_crf_sph(1) < 0
        
        % print warning
        fprintf('input RA: %f\n', params.s_crf_sph(1))
        
        % calculate new RA
        if params.s_crf_sph(1) <= -2*pi
            params.s_crf_sph(1) = mod(params.s_crf_sph(1),-2*pi);
        end
        params.s_crf_sph(1) = 2*pi+params.s_crf_sph(1);
        fprintf('new RA: %f\n', params.s_crf_sph(1));

    end     
    
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

