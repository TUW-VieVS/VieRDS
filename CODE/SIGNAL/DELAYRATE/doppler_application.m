function sta = doppler_application(sta)
% application of Doppler frequency shift
% Input:
%   sta ... station struct
% Output:
%   sta ... (updated) station struct
% Updated variable:
%   x_source

% doppler shift value
df_doppler = sta.Fmodulation;

% if signal needs to be corrected
if df_doppler ~= 0
    
    % create vector with time samples
    t = timesamples(sta.sampling_frequency, sta.scan_length);

    % apply modulation
    sta.x_source = modulation( t, sta.x_source, df_doppler );
    
end

end

