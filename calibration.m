function [p] = calibration(figon)
% Calibration of hot-wire probe with database
% Fig 5-6, sub Fig7

% read calibration table
Ca00=readmatrix("calibration\Ca00.txt"); Ca05=readmatrix("calibration\Ca05.txt");
Ca08=readmatrix("calibration\Ca08.txt"); Ca11=readmatrix("calibration\Ca11.txt");
Ca15=readmatrix("calibration\Ca15.txt"); Ca25=readmatrix("calibration\Ca25.txt");
Ca30=readmatrix("calibration\Ca30.txt"); Ca35=readmatrix("calibration\Ca35.txt");
Ca40=readmatrix("calibration\Ca40.txt");

% write database Ca
set_volt_spd=zeros(3,9);
set_volt_spd(1,:)=[0;5;8;11;15;25;30;35;40];
set_volt_spd(2,1)=mean(Ca00(:,2)); set_volt_spd(2,2)=mean(Ca05(:,2));
set_volt_spd(2,3)=mean(Ca08(:,2)); set_volt_spd(2,4)=mean(Ca11(:,2));
set_volt_spd(2,5)=mean(Ca15(:,2)); set_volt_spd(2,6)=mean(Ca25(:,2));
set_volt_spd(2,7)=mean(Ca30(:,2)); set_volt_spd(2,8)=mean(Ca35(:,2));
set_volt_spd(2,9)=mean(Ca40(:,2)); 

p_pow=set2u();
for i=1:9
set_volt_spd(3,i)=polyval(p_pow,set_volt_spd(1,i));
if set_volt_spd(3,i) < 0
    set_volt_spd(3,i)=0;
end
end

Ca={Ca00,Ca05,Ca08,Ca11,Ca15,Ca25,Ca30,Ca35,Ca40};
clear Ca00 Ca05 Ca08 Ca11 Ca15 Ca25 Ca30 Ca35 Ca40;

% Mapping with king's law
set_volt2_spd05(1,:)=set_volt_spd(1,:); 
set_volt2_spd05(2,:)=set_volt_spd(2,:).^2; set_volt2_spd05(3,:)=set_volt_spd(3,:).^0.5;
spd05=set_volt2_spd05(3,:); volt2=set_volt2_spd05(2,:);
p=polyfit(spd05,volt2,1); fit_volt2=polyval(p,spd05);

figure(5);
    plot(spd05,volt2,'r-o');
        xlabel('square root of speed (m^{0.5}\cdots^{-0.5})');
        ylabel('square of voltage (V^2)');
        hold on; grid on;
    plot(spd05,fit_volt2,'b--');

exp1=sprintf('The relation is: E^2 = %g(U^{0.5}) + %g',p(1),p(2));
disp(exp1); 

% Remap with original setup and speed
figure(6);
    plot(set_volt_spd(2,:),set_volt_spd(3,:),'r-o');
        ylabel('wind speed m·s^{-1}');
        xlabel('voltage (V)');
        hold on; grid on;
    plot(set_volt_spd(2,:),((set_volt_spd(2,:).^2-p(2))/p(1)).^2,'b--');

clear volt2 spd05 exp1 fit_volt2 ans;

% Choose if the figures are displayed
if figon~=1
    if ishandle(5)
        close(5);
    end
    if ishandle(6)
        close(6);
    end
    if ishandle(7)
        close(7);
    end
end

end

