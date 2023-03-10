function normaldist(fdata,Fsetup,param)
figure; hold on;
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
    
    l=-6.5:0.01:6.5;
    sigma(i)=sqrt(var(x));
    y = normpdf(l,mean(x),sigma(i));
    plot(l,y,'LineWidth',3);
    grid on;
end
Fsetup_ext=cell(1,Nfs);
for i=1:Nfs
    Fsetup_ext{i}=[Fsetup{i}(5:end),sprintf(' \\sigma: %.2f ps', sigma(i))];
end
legend(Fsetup_ext,'Location','west')
xticks(-6:6)
set(gca,'FontSize',12)

end

