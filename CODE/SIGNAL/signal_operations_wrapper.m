function [p] = signal_operations_wrapper(params_common,p,contr)
% telescope based operations

% signal creation:
%   - telescope signals
%       - system noise
%       - pcal signal

%%%%%%%% telescope

% telescope signals
p = telescope_signals(p);


%%%%%%%% source

% source signal: allocate to new variable in here
p.x_source = params_common.x_source;

% non-zero or zero baseline simulation
if contr.zero_bl == 0

    % non-zero baseline algorithms (delay and delay rate) will be applied
    fprintf('non-zero baseline simulation selected: station delay and delay rate will be applied\n')
   
    % delay rate application
    p.x_source = delay_rate_application(params_common.x_source, p);    
    
    % delay source signal
%     p.x_source = delay_source_signal(p.x_source,p);
    [p.x_source] = delay3step(p.x_source, p.signal_arrives_at_station.sample_delay_rounded, p.signal_arrives_at_station.sample_frac_delay, p.signal_arrives_at_station.phase_offset_fa,  p.fractional_delay_filter_ntaps, p.fractional_delay_filter_stopBandAtt);
    
end

% delay signal component (includes als phase offset)
[p] = delaySignalComponent(p);

% phase offset signal component (in addition to the integer sample delay, fractional sample delay and phase offset application, there can be also a phase offset to the signal: this enables non-linear group delays for broadband)
[p] = phaseOffSignalComponent(p);

% source signal adjustment
p.x_source = sourcesignal_adjustment(p.x_source, p.sigma_targetsource,p.signal_type_target_source);

% filter signal component
[p] = filterSignalComponent(p);

%%%%%%%% superposition

% superposition of station signals
p.x_ideal = signal_superposition_station(p.x_source, p.x_system, p.x_pcal);

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
p.x_system = [];
p.x_source = [];

% quantization
p.x_quant = quantization(p.x_filt, p.number_of_bits, p.qfact);

p.x_filt = [];

end

