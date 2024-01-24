function plotSingleSource1(true,T,type_delay,data_set_id,exp_str)

if strcmp(type_delay, 'mbd')
    fprintf('Delay Type: Multiband delay:\n')
end

fn = fieldnames(T);
i = data_set_id;
fprintf('Dataset: %s\n\n',fn{i})

% true delay (ps)
y0=true.delay(i)*10^3;

% samples
y = [T.(fn{i}).one.(['resid_',type_delay])]*10^6;

% estimated
% average fourfit mbd (ps)
ym = T.(fn{i}).stats.one.(type_delay).avg*10^6;

% number of samples
N = length(T.(fn{i}).one);

%% plot
line_width = 2;

if strcmp(exp_str,'X_8MHz')
    k_scale = 10^-3;
else
    k_scale = 1;
end

figure;
hold on;
grid on;
plot(1:N, y*k_scale,'o','Color','k','MarkerFaceColor','k')
% plot(1:N, y0*ones(1,N)*k_scale,'Color','k','LineWidth',line_width)
% plot(1:N, ym*ones(1,N)*k_scale,'--','Color','k','LineWidth',line_width)

if y0>=ym
    y0_label = 'top';
    ym_label = 'bottom';
else
    y0_label = 'bottom';
    ym_label = 'top';
end

yline(y0*k_scale,'-','$\tilde{\tau}$','LineWidth',line_width,'Interpreter','latex','FontSize',25,'LabelVerticalAlignment',y0_label);
yline(ym*k_scale,'--','$\bar{\tau}$','LineWidth',line_width,'Interpreter','latex','FontSize',25,'LabelVerticalAlignment',ym_label);

xlim([1,N])
if strcmp(exp_str,'VGOS480_32MHz')
    yticks(y0+(-1:0.5:1))
    ylim(y0+[-1,1])
    ylabel('(ps)','Interpreter','latex');
end

if strcmp(exp_str,'X_8MHz')

    ylabel('(ns)','Interpreter','latex');
end


xlabel('random sample','Interpreter','latex');
title(sprintf('%s, (%1.1f) mas', exp_str, true.deltaRaDe(i)))

set(gca,'FontSize',15);
saveas(gcf,sprintf('/home/jgruber1/software/soft/VieRDS/RESULTS/2023_03_09/PICS/all/%s_%1.1f', exp_str, true.deltaRaDe(i)),'epsc')

%%

fprintf('%f \n', y0-ym)
end