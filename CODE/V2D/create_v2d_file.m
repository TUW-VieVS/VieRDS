function create_v2d_file(v2d,vex,nChan,tInt,antenna,subintNS)
% create v2d file
% input
%   v2d ... name of v2d file
%   vex ... name of vex file
%   nChan ... DiFX procesing number of channels
%   tInt ... DiFX processing integration time
%   antenna ... antenna struct with
%       station_code ... two letter station names
%       format ... baseband data format
%       filelist ... name of filelist
%       sampling ... sampling format
%       phaseCalInt ... phase cal interval
%       toneSelection ... tone selection parameter

% number of antennas
N = length(antenna);

% create file
fid = fopen(sprintf('%s.v2d',v2d),'w');

% print lines in file
fprintf(fid, 'vex=%s\n',vex);
fprintf(fid, 'antennas=');
for i=1:N
    fprintf(fid, '%s',antenna(i).antenna);
    if i~=N
        fprintf(fid,',');
    end
end
fprintf(fid,'\n');

fprintf(fid,'minLength=1\n');
fprintf(fid,'tweakIntTime = true\n');

fprintf(fid,'\n');

fprintf(fid,'SETUP default\n');
fprintf(fid,'{\n');
fprintf(fid,'nChan = %f\n',nChan);
fprintf(fid,'tInt = %f\n',tInt);
fprintf(fid,'subintNS = %f\n',subintNS);
fprintf(fid,'}\n');
fprintf(fid,'\n');


for i=1:N
    fprintf(fid, 'ANTENNA %s',antenna(i).antenna);
    fprintf(fid,'\n');
    fprintf(fid,'{\n');
    fprintf(fid, 'filelist=%s.filelist',antenna(i).antenna);
    fprintf(fid,'\n');
    fprintf(fid, 'toneSelection=all\n');
    fprintf(fid,'\n');
    fprintf(fid,'}\n');
    fprintf(fid,'\n');
end

fclose(fid);

end

