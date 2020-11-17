function [yy, mm, dd, HH, MM, SS] = vdifdate2date( hyf2000 , s )
% calculate date of half years from 2000 plus seconds
% input:
%   hyf2000 ... half years from 2000 (e.g. hyf2000 = 3 --> 2001/6/1)
%   s ... seconds from half years from 2000 (e.g. s = 53 --> hyf2000 + s = 2001/6/1 00:00:53)
% output:
%   date

yyyy    = 2000 + floor(hyf2000/2);
MM      = mod(hyf2000,2)*6;
doy     = 1+s/(24*60*60);
hh      = floor(s/(60*60));
mm      = floor(s/60);

if MM == 0 % seconds start from 1. January
    [yy, mm, dd, HH, MM, SS] = datevec(datenum(yyyy,1,doy));
else % seconds start from 1. July
    [yy, mm, dd, HH, MM, SS] = datevec(datenum(yyyy,6,doy));
end
    
    

end

