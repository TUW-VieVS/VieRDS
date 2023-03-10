function surface_plots(s_statPolSuband,stat,freq,pol)

i_subplot=0;
i_phaseplot=1;
i_amplitudeplot=0;
i_unwrap=1;

if i_subplot==1
    figure; hold on;grid on;
end

Nst=length(s_statPolSuband);
iplot=1;
for ist=1:1%Nst

    for ipol=1
        
        for isb=[2,10,18,26]
    
            iscan=1;
            
            f=s_statPolSuband(ist).pols(ipol).subband(isb).scan(iscan).f;
            mjd=s_statPolSuband(ist).pols(ipol).subband(isb).scan(iscan).mjd;
            C=s_statPolSuband(ist).pols(ipol).subband(isb).scan(iscan).C_difx;

            P=rad2deg(angle(C));
            A=abs(C);

            t=(mjd-min(mjd))*24*60*60;
            f=f*1e-6;
            [X,Y] = meshgrid(t,f);
            
            if i_unwrap==1
               
                for i_ac=1:length(t)
                    P(:,i_ac)=rad2deg(unwrap(angle(C(:,i_ac))));
                end
               
            end
            
            if i_phaseplot==1
                if i_subplot==1
                    subplot(Nst,2,iplot);iplot=iplot+1;
                else
                    figure; 
                end
                su=surf(Y,X,P);
                xlabel('freq (MHz)')
                ylabel('time (sec)')
                zlabel('phase (deg)')
                
                view(0,0)
                if i_unwrap~=1
                    zlim([-180,180]);
                end
    %             set(gca,'FontSize',15);
    %             title(sprintf('%s',stat.c2{ist}))
            end
            
            if i_amplitudeplot==1
                if i_subplot==1
                    subplot(Nst,2,iplot);iplot=iplot+1;hold on;
                else
                    figure;hold on;
                end
                su=surf(Y,X,A);
                s2=surf(Y,X,0.011*ones(length(f),length(t)),'FaceAlpha',0.2,'FaceColor','k');
                s3=surf(Y,X,0.0343*ones(length(f),length(t)),'FaceAlpha',0.2,'FaceColor','k');
                s2.EdgeColor = 'none';
                s3.EdgeColor = 'none';

                xlabel('freq (MHz)')
                ylabel('time (sec)')
                zlabel('amplitude')
                zlim([0.001,0.5]);
                set(gca, 'ZScale', 'log')
    %             set(gca,'FontSize',15);
                title(sprintf('%s',stat.c2{ist}))
                view(-37,28)
            end


        end
    end
end
end

