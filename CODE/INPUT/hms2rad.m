function [alpha] = hms2rad(h, min, sec)
% angle conversion: hours, minutes, seconds to radians
%
% input:
%   h ... hour
%   min ... minute
%   sec ... second
%
% output:
%   alpha ... angle in radians (rad)

alpha = 2*pi/24*(h+min/60+sec/60^2);

end