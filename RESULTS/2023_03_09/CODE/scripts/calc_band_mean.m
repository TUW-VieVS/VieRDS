function [A,B,C,D] = calc_band_mean(val)
A=mean(val(1:8));
B=mean(val(9:15));
C=mean(val(16:24));
D=mean(val(25:32));
end

