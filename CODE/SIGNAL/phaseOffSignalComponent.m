function [p] = phaseOffSignalComponent(p)
% apply phase offset for individual signal component 
% in addition to the integer sample delay, fractional sample delay and phase offset application
% there can be also a phase offset to the signal: this enables non-linear group delays 
% for broadband


% source
if p.phaseoff_source ~= 0   
    fprintf('Phase offset: %f (°)\n',wrapTo180(rad2deg(p.phaseoff_source)));
    % time domain approach with hilbert transform
    fim = 'neil-robertson-blog-method';     
    [p.x_source] = phaseOffsetMethods(p.x_source,p.phaseoff_source,fim);
end

% system
if p.phaseoff_system ~= 0   
    fprintf('Phase offset: %f (°)\n',wrapTo180(rad2deg(p.phaseoff_system)));
    % time domain approach with hilbert transform
    fim = 'neil-robertson-blog-method';     
    [p.x_system] = phaseOffsetMethods(p.x_system,p.phaseoff_system,fim);
end

% pcal
if p.phaseoff_pcal ~= 0   
    fprintf('Phase offset: %f (°)\n',wrapTo180(rad2deg(p.phaseoff_pcal)));
    % time domain approach with hilbert transform
    fim = 'neil-robertson-blog-method';     
    [p.x_pcal] = phaseOffsetMethods(p.x_pcal,p.phaseoff_pcal,fim);
end

end

