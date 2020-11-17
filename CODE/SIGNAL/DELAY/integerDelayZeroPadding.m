function [y] = integerDelayZeroPadding(x,n0)
% apply integer delay
%
% input:
%   x ... signal
%   n0 ... integer delay
%
% output:
%   y ... delayed signal

% check input
if mod(n0,1)~=0
    warning('non-integer delay, but routine needs integer delay')
end

% noise for padding
x_pad = zeros(1,abs(n0));

if n0 > 0
    
    % positive delay
    y =  [x(1+abs(n0):end), x_pad];
    
elseif n0 < 0
    
    % negative delay
    y = [x_pad, x(1:length(x)-abs(n0))];
    
end

end