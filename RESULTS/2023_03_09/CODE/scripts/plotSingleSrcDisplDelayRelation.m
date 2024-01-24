function plotSingleSrcDisplDelayRelation(true,T,type_delay,data_set_id,exp_str)

if strcmp(type_delay, 'mbd')
    fprintf('Delay Type: Multiband delay:\n')
end

fn = fieldnames(T);


fprintf('displacement (mas), true delay (ps), estimated delay (ps), true-est. (ps), sample variance (ps), theoretical variance (ps), average snr, number of samples\n')

% i = data_set_id;
for i = data_set_id

    % true delta Ra, De
    x(i) = true.deltaRaDe(i);

    % true delay (ps)
    y0(i)=true.delay(i)*10^3;
    
    % average fourfit mbd (ps)
    ym(i) = T.(fn{i}).stats.one.(type_delay).avg*10^6;
    
    % diff (ps)
    dym(i) = y0(i)-ym(i);

    
    % sigma fourfit mbd (ps)
    err(i) = T.(fn{i}).stats.one.(type_delay).sig*10^6;

end

figure;
plot(x,y0,'o','MarkerEdgeColor','k','MarkerFaceColor','k')
xlabel('displacement Ra, De (mas)','Interpreter','latex');
ylabel('group delay (ps)','Interpreter','latex');
xticks(x)
xticklabels({'0','','', '', '', '0.5','1','2','3','4'})
title(sprintf('%s', exp_str))

set(gca,'FontSize',15);
grid on;
saveas(gcf,sprintf('/home/jgruber1/software/soft/VieRDS/RESULTS/2023_03_09/PICS/all/%s_disp_groupdel', exp_str),'epsc')



figure;
errorbar(x,dym,err,'o','MarkerEdgeColor','k','MarkerFaceColor','k','LineWidth',2,'Color','k')
xlabel('displacement Ra, De (mas)','Interpreter','latex');
ylabel('$\Delta$ group delay (ps)','Interpreter','latex');
xticks(x)
xticklabels({'0','','', '', '', '0.5','1','2','3','4'})
title(sprintf('%s', exp_str))
saveas(gcf,sprintf('/home/jgruber1/software/soft/VieRDS/RESULTS/2023_03_09/PICS/all/%s_disp_delta', exp_str),'epsc')

set(gca,'FontSize',15);
grid on;

end