function x_delay = delay_source_signal(x_source, p)

if strcmp(p.signal_type_target_source, 'gaussian-white-noise')
    % signal is delayed by padding with noise of integer sample delay
    % length. this avoid circular delay shifts (signal wraps)
    
    % rounded sample delay. applies a phase slope against frequency with
    % zero phase at lower frequency limit. and since it is an integer
    % sample delay, the phase slope is an integer multiple of 2*pi over a
    % frequency length of fs (n*2*pi/fs phase slope)
    
    n0 = p.signal_arrives_at_station.sample_delay_rounded;
    fprintf('rounded sample delay: %d\n',n0)
    
    % check if there is a non-zero rounded sample delay
    if n0 ~= 0
        [x_delay] = integerDelay(x_source,n0);
    else
        x_delay = x_source;
    end
else
    
    % circshift for non noise signals
    x_delay = circshift(x_source,n0);
    
end

% fractional sample delay. applies the remaining delay (integer delay -
% input delay) via a circular shift implemented with a complex phase
% rotation. the applied phase sloped is something between 0 and
% pm 2*pi/fs. Since this application yields non-symmetric frequency
% spectrum, when transformed to the time domain only a symmetric
% spectrum is created to get a real valued signal

dn0 = p.signal_arrives_at_station.sample_frac_delay;
fprintf('fractional sample delay: %f\n',dn0)

% check if there is a non-zero fractional sample delay
if dn0 ~= 0
    
    % fractional delay application
    
    % cummulativ fractional delay testing (sbd value of fourfit doesn't look correct, work around with cummulativ fractional delay applications)
    if 1==0
        %%
        for i=1:2
            ntaps = 101;
            dn01 = dn0;
            if mod(i/2,1)~= 0
                dn01 = -dn0;
            end
            dn01
            [y] = fractional_delay_application_fir_plus_filter_delay_correction(x,dn,r);
        end
        %%
    end
    
    
    % default
    if 1==1
        ntaps = p.fractional_delay_filter_ntaps;
        r = p.fractional_delay_filter_stopBandAtt;
        
        x_delay = fractional_delay_application_fir_plus_filter_delay_correction(x_delay,dn0,ntaps,r);
    end
    
end

% apply constant phase offset to to all spectral components. Since the
% integer and fractional delay application only applies a phase slope
% which means that the phase is zero at the lower frequency limit.
% (like a line without a y-shift at zero). To account for this
% cirumstance, and it is required to enable multiband delays, a
% constant phase offset has to be applied to all spectral components.
% This is realized with a complex phase rotation of a constant factor

% phase offset
phi0 = p.signal_arrives_at_station.phase_offset_fa;

tauphi0 = p.signal_arrives_at_station.tau_phase_offset_fa;
fprintf('phi0: %f (°) %f (ns)\n',wrapTo180(rad2deg(phi0)), tauphi0*1e9)

if phi0 ~= 0
    
    % time domain approach with hilbert transform
    fim = 'neil-robertson-blog-method';
%     [x_delay] = phaseOffsetMethods(x_delay,phi0,fim);
    
end


end

