function s=fit_line_to_phases(s_statPolSuband,stat,freq,pol)

Nst=length(s_statPolSuband);
iplot=1;
s=struct;
for ist=1:Nst
    
    pol=struct;
    Npol=length(s_statPolSuband(ist).pols);
    for ipol=1:Npol
        
        subband=struct;
        Nsb=length(s_statPolSuband(ist).pols(ipol).subband);
        for isb=1:Nsb
            
            scan=struct;
            Nscan=length(s_statPolSuband(ist).pols(ipol).subband(isb).scan);
            for iscan=1:Nscan          
                f=s_statPolSuband(ist).pols(ipol).subband(isb).scan(iscan).f;
                mjd=s_statPolSuband(ist).pols(ipol).subband(isb).scan(iscan).mjd;
                C=s_statPolSuband(ist).pols(ipol).subband(isb).scan(iscan).C_difx;
                t=(mjd-min(mjd))*24*60*60;
                
                ac=struct;
                Nac=length(t);
                for i_ac=1:Nac
                    p=unwrap(angle(C(:,i_ac)));
                    [ac(i_ac).curve, ac(i_ac).goodness, ac(i_ac).output] = fit(f',p,'poly1');               
                end
                scan(iscan).ac=ac;
            end
            subband(isb).scan=scan;
        end
        pol(ipol).subband=subband;       
    end
    s(ist).pol=pol;
end

end

