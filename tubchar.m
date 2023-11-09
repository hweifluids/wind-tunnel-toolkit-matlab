function [U_mean,intensity,Lx] = tubchar(t_V,monitor_window,figon)
% Get intensity, length scale, and plt corrcoef and xcorrcoef
% Fig 8-9

% Get the basic components
tabsize=size(t_V);
dt=t_V(tabsize(1),1)/(tabsize(1)-1);
U_mean=mean(t_V(:,2));
disp(sprintf('The mean velocity is %g.',U_mean));
fluc=t_V(:,2)-U_mean;
n1=size(fluc);n=n1(1);
clear n1;
U_rms=((sum(fluc.^2))/(n-1))^0.5;
disp(sprintf('The RMS is %g.',U_rms));
intensity=U_rms/U_mean;
intensity_pctg=intensity*100;
disp(sprintf('The turbulence intensity is %g%%.',intensity_pctg));
clear intensity_pctg;

% Calculate Skewness and Kurtosis
sk=skewness(fluc); kur=kurtosis(fluc);
disp(sprintf('The Skewness is %g, kurtosis is %g.',sk,kur));

% Plot corrcoef
mon_win=n/2; % monitor window of time domain
mon_final=monitor_window;
self=fluc(1:mon_win); %corf=zeros(mon_win,1);
for i=1:1:mon_final
    compa=fluc(i:mon_win+i-1);
    corftemp=corrcoef(compa,self);
    corf(i)=corftemp(1,2); 
    xlabel('time code');
    ylabel('correlation coefficient');
end

figure(8);
plot(t_V(1:mon_final,1),corf, 'b-','LineWidth',2);
    xlabel('time code');
    ylabel('correlation coefficient (Pearson method)');
% Calculate integral length scale with TAYLOR'S HYPERTHESIS with xcorr
[acf, lags] = xcorr(fluc(1:mon_final), 'coeff');
acf(1:mon_final)=[]; lags(1:mon_final)=[];
zero_crossings = find(acf < 0, 1, 'first');
if isempty(zero_crossings)
   error('Auto-correlation function does not cross zero, integral scale cannot be determined.');
end
T_scale = abs(lags(zero_crossings))*dt;
% Plot cross correlation
figure(9);
    plot(lags*dt,acf, 'r-','LineWidth',2); hold on; y=ylim;
    line([T_scale T_scale], y, 'Color', 'red');
    xlabel('time code');
    ylabel('autocorrelation coefficient');

Lx = U_mean*T_scale;
disp(sprintf('The turbulence integral length is %g meter, based on Tylor frozen hyperthesis.',Lx));

% Choose if the figures are displayed
if figon~=1
    if ishandle(8)
        close(8);
    end
    if ishandle(9)
        close(9);
    end
end

end