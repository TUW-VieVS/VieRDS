function EOP_tm = calcEOP_tm(t_m, MJD, XP, YP, DUT1, DX, DY, intp_method )
% calculates EOP for each input time stemps
%
% input:
%   t_m ... reference time stemps (time-model)
%   MJD ... vector of MJD [mjd]
%   XP ... vector of XP [rad]
%   YP ... vector of YP [rad]
%   DUT1 ... vector of DUT1 [s]
%   DX ... vector of DX [rad]
%   DY ... vector of DY [rad]
%   intp_method ... interpolation method
%
% output:
%   EOP_tm ... struct with:
%       MJD_tm ... vector with mjd of t_m
%       XP_tm ... vector of XP wrt. t_m
%       YP_tm ...   -//-
%       DUT1_tm ... -//-
%       DX_tm ...   -//-
%       DY_tm ...   -//-

% preallocate struct
EOP_tm = struct;

% index for loop
i = 1;

% loop through time-model vector
for it = t_m
    
    % assign datetime to EOP_tm struct
    EOP_tm(i).t = it;
    
    % datevec
    d = datevec(it);
    
    % assign mjd vector to EOP_tm struct
    EOP_tm(i).mjd = modjuldat(d(1),d(2),d(3),d(4),d(5),d(6));
    
    % interpolate for each t_m element
    [ EOP_tm(i).xp, EOP_tm(i).yp, EOP_tm(i).dut1, EOP_tm(i).dX, EOP_tm(i).dY ] = eopinterp( EOP_tm(i).mjd, MJD, XP, YP, DUT1, DX, DY, intp_method );
    
    % increase counter
    i = i+1;
    
end

end

