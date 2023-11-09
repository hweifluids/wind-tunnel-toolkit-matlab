function [] = VMD_plot(t_V,window,NumIMF,stat_on,figon)
global freq;
%Fig 10-11

% VMD_plot(t_V,200,18,1,1)
t_V_win=t_V(1:window,:);

if stat_on==1 % remove static component (highest order mode)
U_mean=mean(t_V_win(:,2));
t_V_win(:,2)=t_V_win(:,2)-U_mean;
end

% for NumIMF=5:20
figure(10)
[imf,res]=vmd(t_V_win(:,2),'NumIMF',NumIMF,'Display',0); 
[p,q] = ndgrid(t_V_win(:,1),1:size(imf,2)); 
plot3(p(:,:),q(:,:),imf(:,:))
grid on
xlabel('Time (s)')
ylabel('Mode Number')
zlabel('Mode Amplitude')
% end % test purpose

AmpIMF=zeros(NumIMF,1); CtrIMF=zeros(NumIMF,1);
for i=1:NumIMF
    AmpIMF(i)=sum(abs(imf(:,i)))/(window/6000);
    %AmpIMF(i)=mean(imf(:,i));
    CtrIMF(i)=Ctr_FFT(imf(:,i));
end
Amp_Sum=sum(AmpIMF);
for i=1:NumIMF
    Rel_AmpIMF(i)=AmpIMF(i)/Amp_Sum;
end

figure(11)

subplot(1, 2, 1);
plot(Rel_AmpIMF(1:NumIMF-1)*100,1:NumIMF-1,"o-r");
grid on;
%title('Normalized power of modals'); 
xlabel('Normalized power of modals (%)'); ylabel('Mode Number');
xlim([0 35]); ylim([0 NumIMF]);

subplot(1, 2, 2);
plot(CtrIMF(1:NumIMF-1),1:NumIMF-1,"o-r");
set(gca, 'XScale', 'log', 'XTick', [500, 1000, 2000], 'XTickLabel', {'500', '1000', '2000'}); grid on;
xlabel('Central frequency of modals (Hz)'); ylabel('Mode Number');
%title('Central frequency of modals'); 
xlim([200 3000]); ylim([0 NumIMF]);

if figon~=1
    if ishandle(10)
        close(10);
    end
    if ishandle(11)
        close(11);
    end
end

end
