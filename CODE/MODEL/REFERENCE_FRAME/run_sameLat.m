clear; close all

% calculate station on same latitude
% Input: coordinates station 1, diff y coordinate station 1 and 2

R = physconst('EarthRadius');
X1 = [ R , R , 0 ];
dy = 10;

X2 = sameLat(X1,dy);
