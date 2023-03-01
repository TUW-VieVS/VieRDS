function [h,m,ss] = deg2hms(d)
% converts degrees to hour minutes seconds
%
% input:
%   d ... degree (°)
%
% output:
%   h ... hour
%   m ... minute
%   ss ... seconds

% hours
hs = d/360*24;

% hour
h = floor(hs);

% delta hours
dhs = hs-h;

% minutes
ms = dhs*60;

% minute
m = floor(ms);

% delta minutes
dms = ms-m;

% seconds
ss = dms*60;

end