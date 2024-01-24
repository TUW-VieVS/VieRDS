function plotDoubleSource(true,T,type_delay,data_set_id,exp_str)

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
    snr_avg = T.(fn{i}).stats.two.snr.avg;

    % number of samples
    N = T.(fn{i}).stats.two.N;

    line_width = 2;
    
    y=[T.(fn{i}).two.(['resid_',type_delay])]*10^6;
    y0=true_0(i);
    y01=true_1(i);
    y02=true_2(i);

    ym=est(i);

    figure;
    hold on;
    grid on;
    plot(1:N, y,'o','Color','k','MarkerFaceColor','k')

%     plot(1:N, y01*ones(1,N),'Color','k','LineWidth',line_width)
    yline(y01,'-','$\tilde{\tau_{1}}$','LineWidth',line_width,'Interpreter','latex','FontSize',25);
    yline(y02,'-','$\tilde{\tau_{2}}$','LineWidth',line_width,'Interpreter','latex','FontSize',25);
    yline(ym,'--','$\bar{\tau}$','LineWidth',line_width,'Interpreter','latex','FontSize',25);

    xlim([1,N])

    if i<5
%         ylim([-670,-620])
% %         yticks(y0+(-1:0.5:1))
    end
    
    xlabel('random sample','Interpreter','latex');
    ylabel('group delay (ps)','Interpreter','latex');
    title(sprintf('%s, (0.0, %1.1f) mas', exp_str, displacement(i)))
    set(gca,'FontSize',15);
    saveas(gcf,sprintf('/home/jgruber1/software/soft/VieRDS/RESULTS/2023_03_09/PICS/all/%s_disp_0_%1.1f', exp_str, displacement(i)),'epsc')

end



end