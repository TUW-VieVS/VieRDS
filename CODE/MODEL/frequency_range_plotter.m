function frequency_range_plotter( params )
% Function to plot frequency range of all stations

nSt = length(params.station_names);

figure;hold on;grid on;
p = zeros(nSt,1);
for iSt = 1:nSt
    
    p(iSt) = plot([params.fa_doppler(iSt),params.fb_doppler(iSt)],[1,1]*iSt,'LineWidth',10);
        xlabel('Frequency Hz')
    yticks([1:nSt ])
    yticklabels({})
    title('Observed Passbands')
    ylim([1-0.5,nSt+0.5])
    xlim([params.fa_ext,params.fb_ext])
    legend_cell_string{iSt} = [params.station_names{iSt},' doppler'];

end
% legend(p , params.station_names)

for iSt = nSt+1:2*nSt
    
    p(iSt) = plot([params.fa(iSt-nSt),params.fb(iSt-nSt)],[1,1]*(iSt-nSt)-0.1,'LineWidth',10);
%         xlabel('Frequency Hz')
    yticks([1:nSt ])
    yticklabels({})
%     title('Observed Passbands')
    ylim([1-0.5,nSt+0.5])
    legend_cell_string{iSt} = [params.station_names{iSt-nSt},''];
end
legend(p , legend_cell_string)

end

