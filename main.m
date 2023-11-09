
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%   _   _  __  __   __        __  _____   ___       ____    _   _   _   _   ____    
%  | | | | \ \/ /   \ \      / / | ____| |_ _|     / __ \  | \ | | | | | | / ___|  
%  | |_| |  \  /     \ \ /\ / /  |  _|    | |     / / _` | |  \| | | | | | \___ \ 
%  |  _  |  /  \      \ V  V /   | |___   | |    | | (_| | | |\  | | |_| |  ___) |
%  |_| |_| /_/\_\      \_/\_/    |_____| |___|    \ \__,_| |_| \_|  \___/  |____/ 
%                                                  \____/                         
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  
%       %%%   Wishing you a passion for fluid dynamics as perpetual as   %%%
%       %%%   cascading turbulence, reaching to the ENDs of the world.   %%%
%
%       This MATLAB Programm is for low-speed wind tunnel data post-processing.
%       Sorry for the trash-bin-liked function workspace.
%
%       Version:    07 November 2023 (MATLAB R2022a)
%       Author:     Huanxia WEI @ NUS CDE
%       Contact:    huanxia.wei@u.nus.edu
%
%       ABSOLUTLY FREE for use, modification, and distribution ! ^w^
%       FORBIDDEN for CA use, do it by yourself !!!
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Main data reader (time domain) and initial setups
RAWDATA=readtable("Cy6000.xlsx"); % path to xlsx raw data
global freq; freq=6000; % sampling frequency
fig_enabler=[1,1,1,1,1]; % Time, Calibration, Corrcoef, Frequency, PDF.

% Calibration for hot-wire and wind tunnel
p_cali=calibration(fig_enabler(2)); 

% Transfer Voltage to WT Speed
tabsize=size(RAWDATA,1); t_V=zeros(tabsize,2); t_V(:,1)=RAWDATA.Var1;
for i=1:tabsize t_V(i,2)=((((RAWDATA.Var2(i))^2)-p_cali(2))/p_cali(1))^2; end
clear i;

% Plot time domain (original signal)
time_plot(t_V,fig_enabler(1));

% plot FFT and PSD
freq_plot(t_V,fig_enabler(4));
% peak_freq = Ctr_FFT(t_V(:,2)) % catcher for frequency of peak

% plot probability density function (PDF) with function
pdf_plot(t_V,fig_enabler(5));

% Turbulence intensity, Taylored length scale, and plt corrcoef and xcorrcoef
[U_mean,Tu_in,Tu_Lx]=tubchar(t_V,50,fig_enabler(3));

% Variational Mode Decomposition (VMD)
VMD_plot(t_V,200,18,1,1)
