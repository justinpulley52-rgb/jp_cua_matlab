clear all
close all
clc

dt = 0.01;
t = 0:dt:2;
g = sin(2*pi*t);

y = (xcorr(g,g))*dt;
T = linspace(-2,2,length(y));

figure(1)
subplot(2,1,1)
plot(t,g)
grid on

subplot(2,1,2)
plot(T,y)
axis([-2 2 -1 1.5])
grid on


