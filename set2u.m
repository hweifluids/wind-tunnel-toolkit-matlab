function [p]= set2u()
% Get the relationship between WT controller setups and wind speed
% Fig 7

set=readtable("WTset.xlsx");
set.Power=set.Power*100; % change to percentage magnitude

% Plot the setup of wind tunnel controller and normalized wind speed

p=polyfit(set.Power,set.Velocity,2); 
fit_velocity=polyval(p,set.Power);

figure(7);
    plot(set.Power, set.Velocity, 'r-o');
    xlabel('WT controller setting (%)');
    ylabel('Wind speed (m/s)');
    xlim([0 100]); 
    grid on; hold on;
    plot(set.Power, fit_velocity, 'b-o');
    
end

