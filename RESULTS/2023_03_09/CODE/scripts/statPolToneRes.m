function [s]=statPolToneRes(s_in,stat,freq,pols)
Nst=length(s_in);
iplot=1;
s=struct;
for ist=1:Nst
    
    pol=struct;
    Npol=length(s_in(ist).pol);
    
    for ipol=1:Npol
        
        Nsb=length(s_in(ist).pol(ipol).subband);
        itone_all=1;
        tone=struct;
        
        for isb=1:Nsb
            
            [~,Ntones]=size(s_in(ist).pol(ipol).subband(isb).res);
            
            for itone=1:Ntones  
                res=s_in(ist).pol(ipol).subband(isb).res(:,itone);  
                tone(itone_all).res=res;
                itone_all=itone_all+1;
            end
            
        end
        
        pol(ipol).tone=tone;       

    end
    
    s(ist).pol=pol;
    
end

end

