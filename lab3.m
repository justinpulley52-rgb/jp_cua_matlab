clear all
close all
clc

dt = 0.001; % time step
T = 1; % full span pf time?
t = -T/2:dt:(T/2)-dt; % seconds
f_m = 8; % Hz
f_c = 60; % Hz
A_c = 3; % gain of carrier
u = 0.9; % modulation index

m_t = sin(2*pi*f_m*t); % message signal in time domain
c_t = cos(2*pi*f_c*t); % carrier signal in time domain
s_t = A_c.*(1+(u*m_t)).*c_t; % modulated signal in time domain

figure(1)
subplot(3,1,1)
plot(t,m_t)
xlabel('Time (s)')
ylabel('Amplitude')
title('Message Signal f_m = 8 Hz')
xticks([-0.5 -0.4 -0.3 -0.2 -0.1 0 0.1 0.2 0.3 0.4 0.5])
yticks([-1 0 1])

subplot(3,1,2)
plot(t,c_t)
xlabel('Time (s)')
ylabel('Amplitude')
title('Carrier Signal f_c = 60 Hz')
xticks([-0.5 -0.4 -0.3 -0.2 -0.1 0 0.1 0.2 0.3 0.4 0.5])
yticks([-1 0 1])

subplot(3,1,3)
plot(t,s_t,'r')
xlabel('Time (s)')
ylabel('Amplitude')
title('Modulated Signal')
xticks([-0.5 -0.4 -0.3 -0.2 -0.1 0 0.1 0.2 0.3 0.4 0.5])
yticks([-5 0 5])

df = 1/T;
f = -1/(2*dt):df:1/(2*dt)-df; 

M_f = fftshift(fft(fftshift(m_t)))*dt; % message signal in frequency domain
C_f = fftshift(fft(fftshift(c_t)))*dt; % carrier signal in frequency domain
S_f = fftshift(fft(fftshift(s_t)))*dt; % modulated signal in frequency domain

figure(2)
subplot(3,1,1)
plot(f,abs(M_f))
xlabel('Frequency (Hz)')
title('Message Signal in Fourier Domain')
xticks([-8 0 8])
yticks([0 0.1 0.2 0.3 0.4 0.5 0.6])

subplot(3,1,2)
plot(f,abs(C_f))
xlabel('Frequency (Hz)')
title('Carrier Signal in Fourier Domain')
xticks([-60 0 60])
yticks([0 0.1 0.2 0.3 0.4 0.5 0.6])

subplot(3,1,3)
plot(f,abs(S_f),'r')
xlabel('Frequency (Hz)')
title('Modulated Signal in Fourier Domain')
xticks([-68 -52 52 68])
yticks([0 0.5 1 1.5])