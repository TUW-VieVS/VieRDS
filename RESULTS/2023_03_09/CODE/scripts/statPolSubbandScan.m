function [s_statPolSuband] = statPolSubbandScan(s_stat,stat,freq,pol)
Nst=length(stat.c2);
Npol=length(pol.label);
% loop over stations
for ist=1:Nst
    % loop over polarizations
    pols=struct;
    for ipol=1:Npol
        % loop over tones
        Ntones=length(s_stat(ist).pols(ipol).tone);
        itonesb=1;
        subband=struct;
        for itone=1:Ntones
            s_tmp=s_stat(ist).pols(ipol).tone(itone);
            i_subband=s_tmp.i_subband;
            if itone~=1
                if i_subband~=i_subband_old
                    itonesb=1;
                end
            end
            Nscans=length(s_tmp.scan);
            scan=struct;
            for iscan=1:Nscans
                f=unique(s_tmp.scan(iscan).F_difx);
                if length(f)~=1
                    warning('something wrong')
                end
                subband(i_subband).scan(iscan).f(itonesb)=f;
                if itonesb>1
                    if sum(s_tmp.scan(iscan).mjd_difx~=subband(i_subband).scan(iscan).mjd)~=0
                        warning('something wrong')
                    end
                end
                subband(i_subband).scan(iscan).mjd=s_tmp.scan(iscan).mjd_difx;
                subband(i_subband).scan(iscan).C_difx(itonesb,:)=s_tmp.scan(iscan).C_difx ;               
            end
            itonesb=itonesb+1;
            i_subband_old=i_subband;
        end
        pols(ipol).subband=subband;
    end
    s_statPolSuband(ist).pols=pols;
    
end
end

