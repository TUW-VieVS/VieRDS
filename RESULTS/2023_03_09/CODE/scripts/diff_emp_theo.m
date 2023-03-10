function diff_emp_theo(fdata,Fsetup,param,param_theo)
figure; hold on;
Nfs=length(Fsetup);
for i=1:Nfs
    x=[fdata(i).(param)];
    y=[fdata(i).(param_theo)];
    if strcmp(param,'resid_mbd')
        if strcmp(Fsetup{i},'VGOS992') && strcmp(param,'resid_mbd')
            x=[fdata(i).(param)]-mean([fdata(i).(param)]);
        end
        ylabel('\Delta\tau_{mbd} (ps)')
        x=x*10^6;
        y=y*10^6;
    end
    
%     l=-6.5:0.01:6.5;
    sigma_emp(i)=sqrt(var(x));
    sigma_theo(i)=mean(y);
%     y = normpdf(l,mean(x),sigma(i));
    plot(i,sigma_emp(i),'kx','MarkerSize',9,'LineWidth',3);
    plot(i,sigma_theo(i),'ko','MarkerSize',9,'LineWidth',3);
    grid on;
end
% Fsetup_ext=cell(1,Nfs);
% for i=1:Nfs
%     Fsetup_ext{i}=[Fsetup{i}(5:end),sprintf(' \\sigma: %.2f ps', sigma(i))];
% end
% legend(Fsetup_ext,'Location','west')
% xticks(-6:6)
set(gca,'FontSize',12)
xlabel('Fsetup')
xticklabels(Fsetup)

end

