function [] = pdf_plot(t_V,figon)
% Fig 4

% Downgrade data
t = t_V(:,1); timeseq=t_V(:,2);

% Calculating PDF and distribution fitting
[pdf_values, pdf_points] = ksdensity(timeseq);

pd = fitdist(timeseq, 'Normal');
x_values = min(timeseq):0.01:max(timeseq);
normal_pdf = pdf(pd, x_values);


% Figure
figure(4);
tiledlayout(1,2) 

% Time domain
subplot(1, 3, [1 2]);
plot(t, timeseq,'-r', 'LineWidth', 1.5);
%title('Time Domain Signal');
xlabel('Time (s)'); ylabel('Wind speed (m/s)');
xlim([0, 0.02]); ylim([0, 20]);
ax1 = subplot(1, 3, [1 2]);
set(ax1, 'FontSize', 10);


% PDF plotting
subplot(1, 3, 3);
fill_area = fill([pdf_values fliplr(pdf_values)], [zeros(size(pdf_points)) fliplr(pdf_points)], [0.8 0.9 1]);
hold on;
plot(pdf_values,pdf_points,'-b', 'LineWidth', 1.5);
hold on;
plot(normal_pdf,x_values,  '--r')
%title('PDF');
%ylabel('Signal Value');
xlabel('Probability Density');
ylim([0, 20]);
set(gca, 'YColor', 'none');
ax2 = subplot(1, 3, 3);
set(ax2, 'FontSize', 10);

if figon~=1
    if ishandle(4)
        close(4);
    end
end

end

