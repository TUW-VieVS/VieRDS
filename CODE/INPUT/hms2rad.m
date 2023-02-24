function [a] = hms2rad(h, m, s)
% angle conversion: hours, minutes, seconds to radians
%
% input:
%   h ... hour
%   m ... minute
%   s ... second
%
% output:
%   a ... angle in radians (rad)

a = 2*pi/24*(h+m/60+s/60^2);

end