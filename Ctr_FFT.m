function [center_frequency] = Ctr_FFT(signal)
global freq;

U_mean=mean(signal);
fluc=signal-U_mean;
N = length(fluc);            
signal_fft = fft(fluc);      
signal_fft = abs(signal_fft/N); 

f = freq*(0:(N/2))/N;
P1 = signal_fft(1:N/2+1);
[~, max_index] = max(P1);
center_frequency = f(max_index);

end
