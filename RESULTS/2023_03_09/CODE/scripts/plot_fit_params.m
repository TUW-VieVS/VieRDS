function [s]=plot_fit_params(s_in,stat,freq,pols)
Nst=length(s_in);
iplot=1;
s=struct;
for ist=1:Nst
    
    pol=struct;
    Npol=length(s_in(ist).pol);
    for ipol=1:Npol
        
        subband=struct;
        Nsb=length(s_in(ist).pol(ipol).subband);
        Amm=zeros(1,Nsb);
        for isb=1:Nsb
            
            scan=struct;
            Nscan=length(s_in(ist).pol(ipol).subband(isb).scan);
            Am=zeros(1,Nscan);
            RES=[];
            for iscan=1:Nscan          
                
                s_tmp=s_in(ist).pol(ipol).subband(isb).scan(iscan).ac;
                
                Nac=length(s_tmp);
                A=zeros(1,Nac);
                h=zeros(1,Nac);
                res=zeros(Nac,s_tmp(1).output.numobs);
%                 if s_tmp(1).output.numobs==7
%                     disp('asdf')
%                 end
                for iac=1:Nac
                    
                    A(iac)=s_tmp(iac).goodness.rmse;
                    res(iac,:)=s_tmp(iac).output.residuals;
%                     [h(iac),~] = chi2gof(s_tmp(iac).output.residuals,'NBins',6,'Alpha',0.001);
%                     if h(iac)==1
%                         fprintf('ist: %d, ipol: %d, isb: %d, iscan: %d, iac: %d, residuals are not normal distributed\n',ist,ipol,isb,iscan,iac)
%                     end
                end
                Am(iscan)=mean(A);
                RES=[RES;res];
            end
            Amm(isb)=mean(Am);
            subband(isb).res=RES;
        end
%         figure;
%         plot(rad2deg(Amm));
%         xlabel('subband id')
%         ylabel('mean phase rmse (deg)')
%         title(sprintf('%s, %s',stat.c2{ist},pols.label{ipol}))
        
        pol(ipol).subband=subband;       

    end
    
    s(ist).pol=pol;
    
end

end

