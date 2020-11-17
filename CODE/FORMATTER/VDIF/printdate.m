function printdate( yy, mm, dd, HH, MM, SS )
% print date

dateStr = datestr([yy, mm, dd, HH, MM, SS]);
mjd = mjuliandate(yy,mm,dd,HH,MM,SS);
fprintf('\n')
fprintf('  Time tag %s, mjd: %f\n',dateStr,mjd)
fprintf('\n')
end

