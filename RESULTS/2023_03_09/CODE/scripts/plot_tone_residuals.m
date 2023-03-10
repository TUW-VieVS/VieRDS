function plot_tone_residuals(s_in,stat,freq,pols)
Nst=length(s_in);
iplot=1;
s=struct;
for ist=1:Nst
    
    pol=struct;
    Npol=length(s_in(ist).pol);
    
    for ipol=1:Npol
        
        Ntone=length(s_in(ist).pol(ipol).tone);
        figure;hold on; grid on;
        for itone=1:Ntone
            
            res=s_in(ist).pol(ipol).tone(itone).res;  
            Nres=length(res);
            plot(itone*ones(Nres,1),rad2deg(res),'.k')
            
        end
        
        title(sprintf('%s, %s',stat.c2{ist},pols.label{ipol}))
        xlabel('tone id')
        ylabel('phase error (deg)')
    end
        
end

end


