function plotT(T)
if isfield(T,'two')

    figure;
    title('resid_{sbd}')
    hold on;
    plot([T.one(:).resid_sbd])
    plot([T.two(:).resid_sbd])
    % plot(ones(1,length(id_one))*true_delay*10^6)
    ylabel('usec')

    figure;
    title('resid_{mbd}')
    hold on;
    plot([T.one(:).resid_mbd]*10^6)
    plot([T.two(:).resid_mbd]*10^6)
    ylabel('ps')

    figure;
    title('snr')
    hold on;
    plot([T.one(:).snr]*10^3)
    plot([T.two(:).snr]*10^3)
else
    figure;
    title('resid_{sbd}')
    hold on;
    plot([T.one(:).resid_sbd])
    % plot(ones(1,length(id_one))*true_delay*10^6)
    ylabel('usec')

    figure;
    title('resid_{mbd}')
    hold on;
    plot([T.one(:).resid_mbd]*10^6)
    ylabel('ps')

    figure;
    title('snr')
    hold on;
    plot([T.one(:).snr]*10^3)

    figure;
    histfit([T.one(:).resid_mbd]*10^6,10)
    xlabel('ps')

end
end