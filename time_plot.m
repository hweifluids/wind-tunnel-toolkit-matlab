function [] = time_plot(t_V,figon)
% Plot time domain (original signal)
% Fig 1

figure(1);
    plot(t_V(:,1), t_V(:,2), 'b-');
    xlabel('time (s)'); ylabel('Speed (m·s^{-1})');
    xlim([0 20]); ylim([0 20]);
if figon~=1
    if ishandle(1)
        close(1);
    end
end
end
