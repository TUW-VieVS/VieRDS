function histfit_subplot(fdata,Fsetup,param)
figure;
Nfs=length(Fsetup);
for i=1:Nfs
    x=[fdata(i).(param)];
    if strcmp(param,'resid_mbd')
        if strcmp(Fsetup{i},'VGOS992') && strcmp(param,'resid_mbd')
            x=[fdata(i).(param)]-mean([fdata(i).(param)]);
        end
        xlabel('\Delta\tau_{mbd} (ps)')
        x=x*10^6;
    end
    axi = subplot(2,3,i);
    h=histfit(axi, x);
    h(1).FaceColor = [211,211,211]/256;
    h(2).Color = [255,165,0]/255; %[255,0,0]/255,[211,211,211]/256;[255,165,0]/255
    h(2).LineWidth = 3;
    title(axi,['setup: ',sprintf(Fsetup{i})])
    grid on;
    if strcmp(param,'resid_mbd')        
        if strcmp(Fsetup{i},'VGOS992')
            xlim([-6,6])
        else
            xlim([-6,6])
        end
        ylim([0,100])
    end
end
end

