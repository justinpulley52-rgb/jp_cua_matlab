clear; 
close all; 
clc;   

%% parameters 
T = 0.08; 
dt = 1e-4; 
df = 1/T;   
t = -T/2:dt:T/2-dt; %T/dt samples 
f = -1/(2*dt):df:1/(2*dt)-df; %T/dt samples   

A = 1; fc = 300; %Hz 
kp = pi; 
kf = 160*pi;   

%% Message Signal 
% m = ;   

%% Phase Modulation 
% s_pm = ; 
s_pmFT = fftshift(fft(fftshift(s_pm)))*dt; 

%% Frequency Modulation 
% s_fm = ; 
% s_fmFT = fftshift(fft(fftshift(s_fm)))*dt;   

%% Demodulation using Differentiation 
B_m = 100; %Bandwidth of the message signal Hz 
%design a simple lowpass filter with bandwidth B_m Hz 
h = fir1(80,B_m*dt); %using a Hamming window to design filter   

s_derivative = diff([s_fm(1) s_fm])/dt; %derivative; adjust to get the same length 
s_derivative = s_derivative/(A*kf); s_rec = s_derivative.*(s_derivative>0); %rectifier; multiply with logic 1 or 0 
M = filter(h,1,s_rec);   

%% plot figure; 
subplot(2,1,1); 
plot(t,m,'Linewidth',2); 
xlabel('{\it t}(sec)'); 
ylabel('m(t)'); 
title('Message Signal'); 
subplot(2,1,2); 
plot(t,M,'Linewidth',2); 
xlabel('{\it t}(sec)'); 
ylabel('M(t)'); 
title('Demodulated FM Signal');   

figure; 
subplot(2,2,1); 
plot(t,s_pm,'Linewidth',2); 
xlabel('{\it t}(sec)'); 
ylabel('s_{PM}(t)'); 
title('PM Signal'); 
subplot(2,2,2); 
plot(f,abs(s_pmFT),'Linewidth',2); 
xlabel('f(Hz)'); ylabel('S_{PM}(f)'); 
title('PM Amplitude Spectrum'); 
subplot(2,2,3); 
plot(t,s_fm,'Linewidth',2); 
xlabel('{\it t}(sec)'); 
ylabel('s_{FM}(t)'); 
title('FM Signal'); 
subplot(2,2,4); 
plot(f,abs(s_fmFT),'Linewidth',2); 
xlabel('f(Hz)'); 
ylabel('S_{FM}(f)'); 
title('FM Amplitude Spectrum'); 