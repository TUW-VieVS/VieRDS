% ************************************************************************
%   Description:
%   Gives the Matrix needed to transform from the terrestrial to the
%   celestial system.
% 
%   Reference: 
%    - IERS Conventions plus updates (16 June 2009)
%    - MODEST-Handbook from JPL by Sovers and Jacobs (1994)
%    - Notice for the Fortran procedure nro_transf. by A.-M. Gontier for
%      the parital derivatives
%
%   Input:										
%      mjd                 Modified Julian Date, observation time UTC [d]
%      xp, yp, dut1        Earth rotation parameters in [rad] resp. [s]
%      dX,dY               Nutation corrections in [rad]
%      nutmod              character: 'IAU_2000A' or IAU_2006A' 
%                
%   Output:
%      t2c    (3,3,n)      terrrestrial to celestial matrices             
%      X      (n,1)        total value of celestial pole X [rad]
%                           (X = nutationmodel X + dX)
%      Y      (n,1)        total value of celestial pole Y [rad]
%                           (Y = nutationmodel Y + dY)
%      era    (n,1)        Earth rotation angle [rad]
%
%   External calls: 	
%      tai_utc.m, as2rad.m, xys2000a.m, xys2006a.m, rotm.m, drotm.m
%
%   Coded for VieVS: 
%   03 Jun 2009 by Lucia Plank
%
%   Revision: 
%   26 May 2010 by Lucia Plank: tt instead of mjd for s'
%   22 Jun 2012 by Lucia Plank: fatal sign error in dQdX corrected
% *************************************************************************
function [t2c, X, Y, era] = trs2crs(mjd, xp, yp, dut1, dX, dY, nutmod)

% global globluc globnee
n = length(mjd);

% assign 2*pi to variable
p2    = 2*pi;

% preallocate rotaiton matrix
t2c   = zeros(3,3,n);

% calc leap second [sec]
tmu = tai_utc(mjd);

% new time [mjd]
tt  = mjd + (32.184 + tmu)./86400;

% new time [days]
tjc =(tt-51544.5)./36525;  % time since J2000 in jul .centuries

% quantity s'
ss = as2rad(-47e-6*tjc);

% earth rotation angle 
ut   = mjd + dut1./86400;

% days since fundamental epoch
tu   = ut - 51544.5;     

% UT1 Julian day fraction
frac = ut - floor(ut) + 0.5;     

% other constant
fac  = 0.00273781191135448;
            
% Earth rotation angle
era = p2 * (frac + 0.7790572732640 + fac * tu );

% Earth rotation angle [rad]
era = mod(era,p2);              

% prec./nut. X,Y,S
switch nutmod
    
    case 'IAU_2000A'
        
        % [rad]
        [X,Y,S] = xys2000a (tt);
        
    case 'IAU_2006/2000A'
        
        % [rad]
        [X,Y,S] = xys2006a (tt);      
        
end

% apply nutation corrections of EOP series [rad]
X = X + (dX');   
Y = Y + (dY');
   
% build rotational matrices
for i=1:n
    
    % polar motion matrix:
    W     = rotm(-ss(i),3)* rotm(xp(i),2)* rotm(yp(i),1);

    % rotation around pole axis
    R     = rotm(-era(i),3);
    
    % precession/nutation matrix:
    v     = -sqrt(X(i)^2+Y(i)^2);
    E     = atan2((Y(i)/v),(X(i)/v));
    z     = sqrt(1-(X(i)^2+Y(i)^2));
    d     = atan2(v,z);
    PN    = rotm(-E,3)*rotm(-d,2)*rotm(E,3)*rotm(S(i),3);
    
    % whole transformation matrix:
    t2c(:,:,i) = PN * R * W;

end
