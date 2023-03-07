function [p] = signal_operations_wrapper(params_common,p,contr)
% telescope based operations

% signal creation:
%   - telescope signals
%       - system noise
%       - pcal signal

%%%%%%%% telescope

fprintf('Generate telescope signals\n')
% telescope signals
p = telescope_signals(p);


%%%%%%%% source

% source signal: allocate to new variable in here
p.x_source = params_common.x_source;

% delete params_common.x_source signal to reduce memory usage because it is
% saved to p.x_source anyway.
params_common.x_source = [];

% check if MPS is activated
if p.mpsd_i==1

    % per source signal
    for isrc = 1:p.number_of_MPS

        % non-zero or zero baseline simulation
        if contr.zero_bl == 0

            % non-zero baseline algorithms (delay and delay rate) will be applied
            fprintf('non-zero baseline simulation selected: station delay and delay rate will be applied\n')

            % check if delay rate application is turned on
            if p.delay_rate_application_YN == 1
                % assign kinematic params from MPS struct for delay_rate_application to "global" station params
                p.p_tm = p.MPS(isrc).p_tm;

                fprintf('Delay rate application for MPS %d\n',isrc)
                % delay rate application
                p.x_source(isrc,:) = delay_rate_application(p.x_source(isrc,:), p);
            else
                % print
                fprintf('Non-zero baseline simulation is actived but delay rate application is deactivated.\n')
            end

            % check if relative delays are activated
            if p.relative_delays_YN == 1
                % cehck if absolute delays are activated
                if p.delay3step_YN == 1
                    error('You have actived relative delays and absolute delays at the same time. This does probably not make sense')
                end

                % assign kinematic params from MPS struct for delay3step to "global" station struct
                p.signal_arrives_at_station = p.MPS(isrc).signal_arrives_at_station;

                fprintf('Relative Delay application for MPS %d\n',isrc)
                % delay source signal by relative delays
                [p.x_source(isrc,:)] = delay3step(p.x_source(isrc,:), p.signal_arrives_at_station.dsample_delay_rounded, p.signal_arrives_at_station.dsample_frac_delay, p.signal_arrives_at_station.dphase_offset_fa,  p.fractional_delay_filter_ntaps, p.fractional_delay_filter_stopBandAtt, 1);

            end

            % check if delay application is turned on
            if p.delay3step_YN == 1
                % assign kinematic params from MPS struct for delay3step to "global" station struct
                p.signal_arrives_at_station = p.MPS(isrc).signal_arrives_at_station;

                % delay source signal
                fprintf('Delay application for MPS %d\n',isrc)
                %     p.x_source = delay_source_signal(p.x_source,p);
                [p.x_source(isrc,:)] = delay3step(p.x_source(isrc,:), p.signal_arrives_at_station.sample_delay_rounded, p.signal_arrives_at_station.sample_frac_delay, p.signal_arrives_at_station.phase_offset_fa,  p.fractional_delay_filter_ntaps, p.fractional_delay_filter_stopBandAtt,1 );

            else
                % print
                fprintf('Non-zero baseline simulation is actived but delay application is deactived.\n')
            end


        end

        % the application of a specific delay and phase offset is only possible
        % for one source signal component. Hence, it is not possible for MPS
        % data. But this can be implemented by adding additional columns in the
        % .src file.
        if p.number_of_MPS == 1
            % delay signal component (includes als phase offset)
            [p] = delaySignalComponent(p);

            % phase offset signal component (in addition to the integer sample delay, fractional sample delay and phase offset application, there can be also a phase offset to the signal: this enables non-linear group delays for broadband)
            [p] = phaseOffSignalComponent(p);
        end

        % source signal adjustment (transform to standard normal distribution and scale by sigma)
        p.x_source(isrc,:) = sourcesignal_adjustment(p.x_source(isrc,:), p.MPS(isrc).sigma_targetsource,p.signal_type_target_source);

        % the application of a arbmag filter is only possible
        % for one source signal component. Hence, it is not possible for MPS
        % data. But this can be implemented by adding additional columns in the
        % .src file.
        if p.number_of_MPS == 1
            % filter signal component (arbitrary magnitude filter signal type)
            [p] = filterSignalComponent(p);
        end
    end

    % superposition of source signals
    if p.number_of_MPS > 1

        % vector addition
        p.x_source = sum(p.x_source, 1);

    end

else
    % non MPS simulation
    
    % non-zero or zero baseline simulation
    if contr.zero_bl == 0

        % non-zero baseline algorithms (delay and delay rate) will be applied
        fprintf('non-zero baseline simulation selected: station delay and delay rate will be applied\n')

        % delay rate application
        fprintf('Delay rate application\n')
        p.x_source = delay_rate_application(p.x_source, p);

        % delay source signal
        %     p.x_source = delay_source_signal(p.x_source,p);
        fprintf('Delay application')
        [p.x_source] = delay3step(p.x_source, p.signal_arrives_at_station.sample_delay_rounded, p.signal_arrives_at_station.sample_frac_delay, p.signal_arrives_at_station.phase_offset_fa,  p.fractional_delay_filter_ntaps, p.fractional_delay_filter_stopBandAtt, 1);

    end

    % delay signal component (includes als phase offset)
    [p] = delaySignalComponent(p);

    % phase offset signal component (in addition to the integer sample delay, fractional sample delay and phase offset application, there can be also a phase offset to the signal: this enables non-linear group delays for broadband)
    [p] = phaseOffSignalComponent(p);

    % source signal adjustment
    p.x_source = sourcesignal_adjustment(p.x_source, p.sigma_targetsource,p.signal_type_target_source);

    % filter signal component
    [p] = filterSignalComponent(p);

end

%%%%%%%% superposition

% superposition of station signals
p.x_ideal = signal_superposition_station(p.x_source, p.x_system, p.x_pcal);

p.x_system = [];
p.x_source = [];

% delay superpositioned signal
p.x_ideal = delay_signal(p.x_ideal,p.delay_super_n0,p.delay_super_dn,p.delay_super_phi0);

% pcal
if p.phaseoff_super ~= 0
    % time domain approach with hilbert transform
    fim = 'neil-robertson-blog-method';
    [p.x_ideal] = phaseOffsetMethods(p.x_ideal,p.phaseoff_super,fim);
end

% filter superposition signal
[p.x_filt] = filterSignal(p.x_ideal,p);

% empty signals
p.x_ideal = [];


% quantization
p.x_quant = quantization(p.x_filt, p.number_of_bits, p.qfact);

p.x_filt = [];

end

