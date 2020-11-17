function [ hyf2000 , s ] = date2vdifdate( yyyy, mm, dd, hh, min, ss )
% calculate date in vdif header format (hyf2000, sec)
% Input:
%   yyyy ... year
%   mm ... month
%   dd ... day
%   hh ... hour
%   min ... minute
%   ss ... seconds
% Output:
%   hyf2000 ... half years from 2000 (e.g. hyf2000 = 3 --> 2001/6/1)
%   s ... seconds from half years from 2000 (e.g. s = 53 --> hyf2000 + s = 2001/6/1 00:00:53)

hyf2000 = (yyyy-2000)*2;
s = (day(datetime([yyyy, mm, dd, hh, min, ss]),'dayofyear') - 1 ) * 24*60*60 + (hh*60*60) + (min*60) + ss;

if mm > 6
    hyf2000 = hyf2000 + 1;
    s = ( (day(datetime([yyyy, mm, dd, hh, min, ss]),'dayofyear') - 1 ) * 24*60*60 ) - ( (day(datetime([yyyy, 7 , 1 , 0 , 0 , 0 ]),'dayofyear') - 1 ) * 24*60*60 ) + (hh*60*60) + (min*60) + ss;

end

end

