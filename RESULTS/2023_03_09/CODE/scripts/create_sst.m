function [sst] = create_sst(sdata,stations,datatypes)

sst=struct;

Nst=length(stations);

if ~iscell(stations)
    stations={stations};
    Nst=1;
end

Ndtype=length(datatypes);

if ~iscell(datatypes)
    datatypes={datatypes};
    Ndtype=1;
end

FN=fieldnames(sdata);
NFN=length(FN);

for jst=1:Nst
    
    station=stations{jst};
    Ndata=length(sdata);
    
    
    %% get row id
    ist=zeros(Ndata,1);
    id=zeros(Ndata,1);
    idbl=zeros(Ndata,1);
    a=[];
    ibl=0;
    for i=1:Ndata
        a=strfind(sdata(i).baseline,station);
        if a > 0
            ist(i)=1;
        end
        if isempty(a)
            ist(i)=0;
        end
        
        if a==1
            ibl=1;
        end
        if a>1
            ibl=2;
        end
        if a<1
            ibl=0;
        end
        if isempty(a)
            ibl=0;
        end
        
        if ibl~=0
            idbl(i)=ibl;
            id(i)=1;
            
        end
        
    end
    
    Ndatai=sum(id);
    idf=find(id);
    for i=1:Ndatai
        j=idf(i);
        for idtype=1:Ndtype
            datatype=datatypes{idtype};
            if idbl(j)==1
                dstr=[datatype,'_ref'];
            end
            if idbl(j)==2
                dstr=[datatype,'_rem'];
            end
            if contains(dstr,'res_ampl') || contains(dstr,'res_phase')
                dstr=dstr(1:end-4);
            end
            d=sdata(j).(dstr);
            si(i).(datatype)=d;
            si(i).ch=1:32;
            
        end
        for ifn=1:NFN
            cfni=FN{ifn};
            if contains(cfni,'ref') || contains(cfni,'rem')
                cfno=cfni(1:end-4);
                if contains(cfni,'ref') && idbl(j)==2
                    continue;
                end
                if contains(cfni,'rem') && idbl(j)==1
                    continue;
                end
            else
                cfno=cfni;
            end
            if contains([datatypes{:}],cfno)
                continue;
            end
            if contains(cfni,'pol_label')
                pol_dir = sdata(j).(cfni);
                si(i).pol_dir=pol_dir(idbl(j));
            end
            si(i).(cfno)=sdata(j).(cfni);
        end
    end
        
    Nsi=length(si);
    i=1;
    while i<=Nsi
        id1=find(si(i).datenum==[si.datenum]);
        id2=strfind([si.pol_dir],si(i).pol_dir);
        iinterse=intersect(id1,id2);
        si(iinterse(iinterse~=i))=[];
        Nsi=length(si);
        i=i+1;
    end
    
    sst.(station)=si;
    
    
end

