function [tA,tau,i] = determineSignalArrivalTime(t0,T,D,DR)
% determine the signal arrival for a station
% 
% definitions:
%
%   the wave front goes through the geo-center at scan start data (pure
%   convention, could be any date; but the following formulares are based
%   on this convention)
%
%   formular for retarded baseline delay:
%
%       tau = t2-t1 = tau_gc_1(t1)-tau_gc_2(t2)
%           tau ... retarded baseline delay (the real measured one)
%           t2 ... signal arrival time at station 2
%           t1 ... signal arrival time at station 1
%           tau_gc_1(t1) ... geocenter delay of station 1 at t1
%           tau_gc_2(t2) ... geocenter delay of station 2 at t2
%
%   formular for extrapolation from t2 to t1 for station 1 (only linear
%   component is used; works only for linear delay rates in the time span
%   of tau
%
%       tau_gc_1(t1) = tau_gc_1(t2) - tau*dr_gc_1(t2)
%           tau_gc_1(t2) ... geocenter delay of station 1 at t2
%           dr_gc_1(t2) ... delay rate of station 1 at t2
%       
%   formular to determine tau based on geocenter delays and rate at t2
%
%       tau = (tau_gc_1(t2) - tau_gc_2(t2))/(1+dr_gc_1(t2))
%
%   station 2 is considered to be the reference station is placed at the
%   geocenter
%
%       tau = tau_gc_1(t2)/(1+dr_gc_1(t2))
%
%
% input:
%
%   t0 ... date of scan start (definition: wave front goes through geocenter)
%   T ... array with dates
%   D ... array with delays
%   DR ... array with delay rates
%
% output:
%
%   tA ... date of signal arrival time
%   tau ... retarded baseline delay, difference between signal arrival time
%   at station and arrival time at geo-center
%   i ... corresponding entry in time parameter struct

% scan start
fprintf('Scan start %s (wave-front goes through geo center)\n', t0 )
i = T==t0; % corresponding entry in time parameter struct

% geocenter delay at t0
tau_gc_t2 = D(i);

% geocenter delay rate at t0
dr_gc_t2 = DR(i);

% retarded baseline delay
tau = tau_gc_t2 / (1+dr_gc_t2); % difference of arrival times

% signal arrival time
tA = t0-seconds(tau); % signal arrival time at station

end

