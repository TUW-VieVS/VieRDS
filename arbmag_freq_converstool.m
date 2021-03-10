% create arbmag filter text file for all channels

% channels center frequencies:
f0=[3000.4, 3032.4, 3064.4, 3192.4, 3288.4, 3352.4, 3416.4, 3448.4, 5240.4, 5272.4, 5304.4, 5432.4, 5528.4, 5592.4, 5656.4, 5688.4, 6360.4, 6392.4, 6424.4, 6552.4, 6648.4, 6712.4, 6776.4, 6808.4, 10200.4, 10232.4, 10264.4, 10392.4, 10488.4, 10552.4, 10616.4, 10648.4];

% reference text file
textfile='K2.txt';
% corresponding center freq
fref=[3016.30];

% read file
D = dlmread(textfile);

fm=D(:,1)*10^3;
Am=D(:,2);

df=fm-fref;

F=[];
A=[];
for i=1:length(f0)
    fi=f0(i);
    fii=fi+df;
    F = [F;fii];
    A = [A;Am];
end

figure;plot(A)

FA=[F*10^-3,A];

dlmwrite('K2bb.txt',FA,'delimiter',' ','precision',6);