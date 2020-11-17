function [y] = sourcesignal_filter(p)
% applies filter on source signal
%
% input:
%   p ... station struct
% 
% output:
%   y ... filtered source signal

y = p.x_source;

if isfield(p,'arb_mag_filter_object')
    % arbitrary magnitude filter will be applied on source signal
    fprintf('arbitrary magnitude filter will be applied on source signal\n')
    y = filter(p.arb_mag_filter_object.Numerator,1,p.x_source);
    
    ntaps = length(p.arb_mag_filter_object.Numerator);
    y = circshift(y,-(ntaps-1)/2);
end

end

