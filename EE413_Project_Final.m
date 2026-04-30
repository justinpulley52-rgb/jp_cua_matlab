clear all
close all
clc


%% AM
dt = 0.001; % time step
fs=1/dt;
T = 1; % full span of time
t = 0:dt:T-dt; % seconds
f_m = 10; % Hz
f_c = 100; % Hz
A_m = 2;
A_c = 1; % gain of carrier
u = 1; % modulation index

% Transmitter
m_t = A_m.*sin(2*pi*f_m*t); % message signal in time domain
c_t = cos(2*pi*f_c*t); % carrier signal in time domain

% Amplitude Modulation
s_t = A_c.*(1+(u*m_t)).*c_t; % modulated signal in time domain

% Receiver
num_set = 3;
ns_t = zeros(num_set,length(s_t));
demod_t = zeros(num_set,length(s_t));
n=1;

for snr = [0.5 5 20]
    ns_t(n,:) = awgn(s_t,snr); % noise

    % Demodulation by Squaring Technique w/ LPF
    m_squared = ns_t(n,:).^2;
    df = 1/T;
    f = -1/(2*dt):df:1/(2*dt)-df; 
    W = f_m+1; % Bandwidth

    DEM_f = fftshift(fft(fftshift(m_squared)))*dt; 
    H_lpf = zeros(1,length(f));
    H_lpf ( (f >= -W) & (f <= W) ) = 1;

    DEM_f_lpf = DEM_f.*H_lpf;
    demod_t(n,:) = fftshift(ifft(fftshift(DEM_f_lpf)))/dt;
    n = n + 1;
end

df = 1/T;
f = -1/(2*dt):df:1/(2*dt)-df; 

M_f = fftshift(fft(fftshift(m_t)))*dt; % message signal in frequency domain
C_f = fftshift(fft(fftshift(c_t)))*dt; % carrier signal in frequency domain
S_f = fftshift(fft(fftshift(s_t)))*dt; % am signal in frequency domain
NS_f = fftshift(fft(fftshift(ns_t(2,:))))*dt; % noisy am signal in frequency domain
DM_f = fftshift(fft(fftshift(demod_t(3,:))))*dt; % demodulated signal in frequency domain

% Plots
figure(1)
subplot(5,2,1)
plot(t,m_t)
title('Message Signal')
xlabel('Time (s)')

subplot(5,2,2)
plot(f,abs(M_f))
title('Message Signal')
xlabel('Frequency (Hz)')

subplot(5,2,3)
plot(t,c_t)
title('Carrier Signal')
xlabel('Time (s)')

subplot(5,2,4)
plot(f,abs(C_f))
title('Carrier Signal')
xlabel('Frequency (Hz)')

subplot(5,2,5)
plot(t,s_t)
title('Modulated Signal')
xlabel('Time (s)')

subplot(5,2,6)
plot(f,abs(S_f))
title('Modulated Signal')
xlabel('Frequency (Hz)')

subplot(5,2,7)
plot(t,ns_t(2,:))
title('Noisy AM Signal, SNR = 5')
xlabel('Time (s)')

subplot(5,2,8)
plot(f,abs(NS_f))
title('Noisy AM Signal')
xlabel('Frequency (Hz)')

subplot(5,2,9)
plot(t,demod_t(3,:)-1)
title('Demodulated Signal')
xlabel('Time (s)')

subplot(5,2,10)
plot(f,abs(DM_f))
title('Demodulated Signal')
xlabel('Frequency (Hz)')

sgtitle('Amplitude Modulation and Demodulation')

% Perfomance Metric: Signal to Noise Ratio
figure(2)
subplot(4,2,1)
plot(t,ns_t(1,:))
title('AM Signal SNR = 0.5')
xlabel('Time (s)')

subplot(4,2,2)
plot(t,demod_t(1,:)-1)
title('Demodulated Signal SNR = 0.5')
xlabel('Time (s)')

subplot(4,2,3)
plot(t,ns_t(2,:))
title('AM Signal SNR = 5')
xlabel('Time (s)')

subplot(4,2,4)
plot(t,demod_t(2,:)-1)
title('Demodulated Signal SNR = 5')
xlabel('Time (s)')

subplot(4,2,5)
plot(t,ns_t(3,:))
title('AM Signal SNR = 20')
xlabel('Time (s)')

subplot(4,2,6)
plot(t,demod_t(3,:)-1)
title('Demodulated Signal SNR = 20')
xlabel('Time (s)')

sgtitle('AM Performance Metric: Signal-to-Noise Ratio')

P_c = (A_m.^2)./2;
AM_P = P_c.*(1+(u.^2/2));
Pow_Con = AM_P-P_c;

%% FM
fs = 1000;
dt = 1/fs;
T = 1;
t = 0:dt:T-dt;
A_m = 2;
A_c = 2;
f_m = 10;
f_c = 100;
w_m = 2.*pi.*f_m;
w_c = 2*pi*f_c;
df = 1/T;
f = -1/(2*dt):df:1/(2*dt)-df; 
delta_f = 300;
kf = 2.*pi.*30;

% Transmitter
m_t = A_m.*cos(2.*pi.*f_m.*t);
c_t = cos(w_c.*t);
m_b = tril(ones(length(m_t)));
m_c = m_t.*m_b;
sum_m = sum(m_c,2); 
s_t = A_c*cos(w_c.*t + (kf.*sum_m'.*dt));

% Receiver
num_set = 3;
ns_t = zeros(num_set,length(s_t));
demod_t = zeros(num_set,length(s_t));
n=1;

for snr = [0.5 5 20]
    ns_t(n,:) = awgn(s_t,snr); % noise

    % Demodulation
    demod_t(n,:) = demod(ns_t(n,:),f_c,fs,'fm');
    n = n + 1;
end

M_f = fftshift(fft(fftshift(m_t)))*dt; % message signal in frequency domain
C_f = fftshift(fft(fftshift(c_t)))*dt; % carrier signal in frequency domain
S_f = fftshift(fft(fftshift(s_t)))*dt; % fm signal in frequency domain
NS_f = fftshift(fft(fftshift(ns_t(3,:))))*dt; % noisy fm signal in frequency domain
DM_f = fftshift(fft(fftshift(demod_t(3,:))))*dt; % demodulated signal in frequency domain

% Plots
figure(3)
subplot(5,2,1)
plot(t,m_t)
title('Message Signal')
xlabel('Time (s)')

subplot(5,2,2)
plot(f,abs(M_f))
title('Message Signal')
xlabel('Frequency (Hz)')

subplot(5,2,3)
plot(t,c_t)
title('Carrier Signal')
xlabel('Time (s)')

subplot(5,2,4)
plot(f,abs(C_f))
title('Carrier Signal')
xlabel('Frequency (Hz)')

subplot(5,2,5)
plot(t,s_t)
title('Modulated Signal')
xlabel('Time (s)')

subplot(5,2,6)
plot(f,abs(S_f))
title('Modulated Signal')
xlabel('Frequency (Hz)')

subplot(5,2,7)
plot(t,ns_t(2,:))
title('Noisy FM Signal, SNR = 5')
xlabel('Time (s)')

subplot(5,2,8)
plot(f,abs(NS_f))
title('Noisy FM Signal')
xlabel('Frequency (Hz)')

subplot(5,2,9)
plot(t,demod_t(2,:))
title('Demodulated Signal')
xlabel('Time (s)')

subplot(5,2,10)
plot(f,abs(DM_f))
title('Demodulated Signal')
xlabel('Frequency (Hz)')

sgtitle('Frequency Modulation and Demodulation')

% Perfomance Metric: Signal to Noise Ratio
figure(4)
subplot(4,2,1)
plot(t,ns_t(1,:))
title('FM Signal SNR = 0.5')
xlabel('Time (s)')

subplot(4,2,2)
plot(t,demod_t(1,:))
title('Demodulated Signal SNR = 0.5')
xlabel('Time (s)')

subplot(4,2,3)
plot(t,ns_t(2,:))
title('FM Signal SNR = 5')
xlabel('Time (s)')

subplot(4,2,4)
plot(t,demod_t(2,:))
title('Demodulated Signal SNR = 5')
xlabel('Time (s)')

subplot(4,2,5)
plot(t,ns_t(3,:))
title('FM Signal SNR = 20')
xlabel('Time (s)')

subplot(4,2,6)
plot(t,demod_t(3,:))
title('Demodulated Signal SNR = 20')
xlabel('Time (s)')

sgtitle('FM Performance Metric: Signal-to-Noise Ratio')