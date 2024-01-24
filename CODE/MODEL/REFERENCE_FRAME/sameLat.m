function X2 = sameLat(X1,dy)
% calculate station on same latitude
% X1 ... reference station
% dy ... difference in y-coordinate between X1 and X2
x1 = X1(1);
y1 = X1(2);
z = X1(3);

y2 = y1-dy;

r_lat = sqrt(x1.^2 + y1.^2);
x2 = sqrt(r_lat.^2 - y2.^2);

X2 = [x2, y2, z];
end

