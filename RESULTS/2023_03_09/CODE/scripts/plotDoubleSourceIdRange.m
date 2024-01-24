function plotDoubleSourceIdRange(true,T,type_delay,data_set_id,exp_str)

if strcmp(type_delay, 'mbd')
    fprintf('Delay Type: Multiband delay:\n')
end

fn = fieldnames(T);


fprintf('displacement (mas), true delay 1 (ps), true delay 2 (ps), avg. true (ps), estimated delay (ps), true-est. (ps), sample variance (ps), theoretical variance (ps), average snr, number of samples\n')

% i = data_set_id;
for i = data_set_id

    % true delta Ra, De
    displacement(i) = true.deltaRaDe(i);

    % true delay (ps)
    true_1(i) = true.delay(1)*10^3;

    % true delay (ps)
    true_2(i) = true.delay(i)*10^3;

    % true delay (ps)
    true_0(i) = mean([true_1(i),true_2(i)]);
    
    % average fourfit mbd (ps)
    est(i) = T.(fn{i}).stats.two.(type_delay).avg*10^6;
    
    % diff (ps)
    dest(i) = true_0(i)-est(i);
    
    % sigma fourfit mbd (ps)
    err(i) = T.(fn{i}).stats.two.(type_delay).sig*10^6;

    % theory variance (ps)
    err_theory = T.(fn{i}).stats.two.(type_delay).sig_theory*10^6;
    
    % average snr
    snr_avg(i) = T.(fn{i}).stats.two.snr.avg;
    
    % number of samples
    N = length(T.(fn{i}).stats.two.N);
    
%     fprintf('%1.1f, %.3f, %.3f, %.3f, %.3f, %.3f, %.3f, %.3f, %.2f, %d\n',displacement(i), true_1(i), true_2(i), true_0(i), est(i), dest(i), err, err_theory, snr_avg, N)
end

figure;

hold on;
plot(displacement,true_1-true_0,'o','MarkerEdgeColor','#a9a9a9','MarkerFaceColor','#a9a9a9','LineWidth',0.6,'Color','#a9a9a9')
plot(displacement,true_2-true_0,'o','MarkerEdgeColor','#a9a9a9','MarkerFaceColor','#a9a9a9','LineWidth',0.6,'Color','#d3d3d3')
errorbar(displacement,dest,err,'o','MarkerEdgeColor','k','MarkerFaceColor','k','LineWidth',2,'Color','k')

xlabel('displacement Ra, De (mas)','Interpreter','latex');
ylabel('$\Delta$ group delay (ps)','Interpreter','latex');
xticks(displacement)
xticklabels({'0','','', '', '', '0.5','1','2','3','4'})
title(sprintf('%s', exp_str))

set(gca,'FontSize',15);
grid on;

saveas(gcf,sprintf('/home/jgruber1/software/soft/VieRDS/RESULTS/2023_03_09/PICS/all/%s_disp_true_delta', exp_str),'epsc')


figure
plot(displacement,snr_avg,'k','LineWidth',2);%,'o','MarkerEdgeColor','r','MarkerFaceColor','#a9a9a9','LineWidth',0.6,'Color','#a9a9a9')
xlabel('displacement Ra, De (mas)','Interpreter','latex');
ylabel('SNR','Interpreter','latex');
xticks(displacement)
xticklabels({'0','','', '', '', '0.5','1','2','3','4'})
title(sprintf('%s', exp_str))

set(gca,'FontSize',15);
grid on;
saveas(gcf,sprintf('/home/jgruber1/software/soft/VieRDS/RESULTS/2023_03_09/PICS/all/%s_disp_SNR', exp_str),'epsc')


end