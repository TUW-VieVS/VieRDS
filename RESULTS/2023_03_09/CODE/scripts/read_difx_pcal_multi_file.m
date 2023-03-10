function [s] = read_difx_pcal_multi_file(fname)
fid = fopen(fname);
tline = fgetl(fid);
s=struct;
iline=1;
mjd_old=0;
first_entry=1;
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
    if first_entry==1
        s(iline).mjd=str2double(mjd);
        s(iline).f=f;
        s(iline).p=p;
        s(iline).d=d;
        first_entry=999;
    else
        if str2double(mjd_old)~=str2double(mjd)
            iline=iline+1;
            s(iline).mjd=str2double(mjd);
            s(iline).f=f;
            s(iline).p=p;
            s(iline).d=d;
        else
            s(iline).f=[s(iline).f,f];
            s(iline).p=[s(iline).p,p];
            s(iline).d=[s(iline).d,d];
        end        
    end  
    
    
    mjd_old=mjd;
    tline = fgetl(fid);
end
fclose(fid);
