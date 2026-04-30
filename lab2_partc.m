close all
clear all
clc

dt = 0.001;
t = -0.5:dt:0.5-dt;
g = sin(10*2*pi*t);


df = 1;
f = -1/(2*dt):df:1/(2*dt)-df;
G = fftshift(fft(fftshift(g)))*dt;

figure(1)
subplot(2,1,1)
plot(t,g)
axis([-0.5 0.5 -1 1])
grid on

subplot(2,1,2)
plot(f,abs(G))
axis([-500 500 -0 0.6])

p_t = bandpower(g);
p_db = 10*log10(p_t/0.001)
p_f = bandpower(abs(G))/dt

% Total power of the signal g from time domain is 
% Total power of the signal g from frequency domain is 
