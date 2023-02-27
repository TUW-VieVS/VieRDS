function [y] = delay_rate_application(x,p)
% wrapper for delay rate applications
% supported algorithms:
%   - non uniform fft:
%       - frequency shift that depends on frequency (the higher the
%       frequency the larger is the shift of frequency)
%       - advantage: equal to doppler shift in reality. it is possible to
%       simulate frequency at sky frequencies with frequency dependent
%       frequency shift
%       - disadvantage: algorithm does not account for changing delay rates (doppler shifts)
%       - work-around: block wise nufft doppler shift application over time
%       with changing doppler shifts on signal
%       - between blocks a phase offset is introduced to account for the
%       delay introduced by the delay rates of each block beforehand
%       - size of interval can be controlled, error is usually less than
%       10 ps for 1e-1 sec interval and less than 1 ps for 1e-3 sec
%       interval (for delta velocities of 700 m/s ... very high)
%       - little error will also be introduced due to symmetric ifft (would
%       not be the case for frequency correlators)
%   - single side band modulation:
%       - constant frequency shift for all frequency components
%       - delay correction due to phase wrapping after 1/f0 
%
% input:
%   x ... input signal
%   p ... station struct
%
% output:
%   y ... output signal (x with delay rate)


% single non-uniform fft
if strcmp(p.delay_rate_application_method,'single-non-uniform-fft')
    
    % delay rate value that lies in the middle of the scan interval
    dates = -[p.p_tm.signal_arrival_station_center_sample(:).datenum]; % all given dates
    drs = -[p.p_tm.signal_arrival_station_center_sample(:).delay_rate]; % all gives delay rate values
    
    % take first entry
    dates = dates(1);
    drs = drs(1);
    Ndates = length(dates); % number of dates
    if Ndates <= 1 % if only one value exists ...
        %         date0 = dates(1); % ... take the first one
        dr0 = drs(1);
    else
        date0 = dates(1)+days(diff([dates(1),dates(end)])/2); % calculate date that lies in the middle
        dr0 = interp1(dates,drs,date0,'spline','extrap'); % interpolate to get delay rate value in the middle
    end
        
    if dr0 ~= 0        
        % execute nufft wrapper
        [y] = nufft_wrapper(x,dr0,p.sampling_frequency,p.fa);
    else
        y = x;
    end
    
end

% multiple non-uniform ffts
if strcmp(p.delay_rate_application_method,'multiple-non-uniform-fft')
    
    drs = -[p.p_tm.signal_arrival_station_center_sample(:).delay_rate];
    ddrs = -[p.p_tm.signal_arrival_station_center_sample(:).delta_delay_rate];
    dr0 = drs(1);
    
    % two step nufft application is used to avoid high delay rates. high
    % delay rates often yield fast phase changes, that are problematic if
    % the phase wraps. To avoid this, first a single delay rate application
    % is applied. after this only the delta delay rates which have very
    % smalle phase angle rates.
    
    % one single nufft of full length signal with first delay rate value
    [x] = nufft_wrapper(x,dr0,p.sampling_frequency,p.fa);
    
    % several nufft to adjust for delay rate changes
    [y] = nufft_wrapper(x,ddrs,p.sampling_frequency,p.fa);
    
end

% single side band modulation
if strcmp(p.delay_rate_application_method,'single-side-band-modulation')   
    
    % check if multi-point source simulation is activated
    if s.mpsd_i == 1
        
        % for each point-source
        for i = 1:p.number_of_MPS
            
        end

    else
        dtau = [p.p_tm.signal_arrival_station_center_sample(:).delta_tau_geocenter];
        dates = [p.p_tm.signal_arrival_station_center_sample(:).datetime];
        
        Ns = length(x);
        Tx = p.sampling_interval;
        
        % query points for interpolation
        xq = dates(1)+seconds((0:Ns-1)*Tx);
        
        % delay interpolation
        dtaui = interp1(dates,dtau,xq,'pchip','extrap');
        
        fprintf('Single-sideband modulation:\n')
        [y] = single_side_band_modulation(x,p.f0,dtaui,p.sampling_interval);
    end
        
end

end

