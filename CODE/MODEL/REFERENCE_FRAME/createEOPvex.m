function EOP_vex= createEOPvex(EOP_daily)
% creates a structure required for the EOP vex file section
%
% input:
%   EOP_daily ... struct with daily EOP values
%
% output:
%   EOP_vex ... struct with EOP values for the EOP vex file section

EOP_vex = struct;

% MJD
EOP_vex.mjd = EOP_daily.MJD;

% XP: convert from rad to arcsec
EOP_vex.xp_arcsec = rad2arcsec(EOP_daily.XP);

% YP: convert from rad to arcsec
EOP_vex.yp_arcsec = rad2arcsec(EOP_daily.YP);

% DUT1
EOP_vex.dut1 = EOP_daily.DUT1;

% LEAP
EOP_vex.leap = EOP_daily.LEAP;

% mjd to date
EOP_vex.date = datestr(EOP_daily.MJD+datenum('Nov 17, 1858,00:00'),'dd-mmm-yyyy');

% mjd to year
EOP_vex.year = year(datetime(EOP_vex.date));

% mjd to day of year
EOP_vex.doy = day( datetime(EOP_vex.date) , 'dayofyear' );

end

