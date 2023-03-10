function [s] = read_difx_pcal(fname)
fid = fopen(fname);
tline = fgetl(fid);
s=struct;
iline=1;
while ischar(tline)
%     disp(tline)
    C=strsplit(tline,' ');
    st=C{1};
    mjd=C{2};
    fs=C{5};
    D=C(7:end);
    Ndata=length(D)/4;
    f=zeros(1,Ndata);
    p=cell(1,Ndata);
    d=zeros(1,Ndata);
    for i=1:Ndata
        f(i)=str2double(D{(i-1)*4+1})*1e6;
        p(i)=D((i-1)*4+2);
        d(i)=str2double(D{(i-1)*4+3})+1i*str2double(D{(i-1)*4+4});
    end
    s(iline).mjd=str2double(mjd);
    s(iline).f=f;
    s(iline).p=p;
    s(iline).d=d;
    iline=iline+1;
    tline = fgetl(fid);
end
fclose(fid);
end

