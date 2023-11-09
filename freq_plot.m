function [] = freq_plot(t_V,figon)
% Fig 2-3

global freq
lgt=size(t_V,1);
dt=t_V(lgt,1)/(lgt-1);
Y = fft(t_V(:,2));
N = length(t_V);
Fs = 1/dt; % freq for sampling
f = (0:N-1)*(Fs/N); % freq axis

%plot FFT
figure(2);
plot(f, abs(Y), 'b-');
xlabel('Frequency (Hz)');
ylabel('Magnitude');
%title('FFT of Velocity');
xlim([0 freq]); ylim([-1000 20000]); grid on;

% plot PSD
[pxx, f] = pwelch(t_V(:,2), [], [], [], Fs); 
windowSize = 50; %smoothing
b = (1/windowSize)*ones(1, windowSize); 
smoothedPxx = conv(pxx, b, 'same'); 

figure(3); % plotting
semilogx(f, 10*log10(pxx), 'b-', 'LineWidth', 1.5); hold on;
semilogx(f, 10*log10(smoothedPxx), 'r-', 'LineWidth', 2);
xlabel('Frequency (Hz)');
ylabel('PSD (dB/Hz)');
% title('Power Spectral Density of Velocity');
legend('Original PSD', 'Smoothed PSD');
xlim([10 freq/2]); ylim([-50 5]); grid on;

if figon~=1
    if ishandle(2)
        close(2);
    end
    if ishandle(3)
    close(3);
    end
end
end
