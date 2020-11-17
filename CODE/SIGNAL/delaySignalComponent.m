function [p] = delaySignalComponent(p)

fprintf('delay source signal\n')
% p.x_source = delay_signal(p.x_source,p.delay_source_n0,p.delay_source_dn,p.delay_source_phi0);
[p.x_source] = delay3step(p.x_source, p.delay_source_n0, p.delay_source_dn, p.delay_source_phi0,  p.fractional_delay_filter_ntaps, p.fractional_delay_filter_stopBandAtt);

fprintf('delay system signal\n')
p.x_system = delay_signal(p.x_system,p.delay_system_n0,p.delay_system_dn,p.delay_system_phi0);
fprintf('delay pcal signal\n')
p.x_pcal = delay_signal(p.x_pcal,p.delay_pcal_n0,p.delay_pcal_dn,p.delay_pcal_phi0);

end

