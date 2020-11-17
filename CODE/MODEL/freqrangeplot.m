function freqrangeplot( params , color_map )
% Function to plot frequency range of all stations

nSt = length(params.station_names);

p = zeros(nSt,1);
figure;hold on;grid on;

for iSt = 1:nSt
    p(iSt) = rectangle('Position',[params.fa(iSt),0.1+iSt,params.fb(iSt)-params.fa(iSt),0.4],'FaceColor',color_map(iSt,:),'LineWidth',2);
    p(iSt) = rectangle('Position',[params.fa_doppler(iSt),0.5+iSt,params.fb_doppler(iSt)-params.fa_doppler(iSt),0.4],'FaceColor',color_map(iSt,:), 'LineStyle','--','LineWidth',2);
    text(params.fb_max+(params.fb_max-params.fa_min)*33/100,iSt+0.5,params.station_names{iSt},'FontWeight','bold')
end

xlabel('Frequency Hz')
yticks(1:nSt)
yticklabels({})
title('scheduled (solid) and observed (dashed) passbands')
% xlim([params.fa_min,params.fb_max+(params.fb_max-params.fa_min)*30/100])


end

