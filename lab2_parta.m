clear all 
close all
clc

dt = 0.02; % dt --> step size
t = -2:dt:12-dt; % t --> time
u = 2; % u --> pulse width
t0 = 1; % t0 --> center of rect pulse


h1_t = rect(t,u,t0,dt);
h2_t = piecewise(t,u,t0,dt);


g_t = rect(t,2,1,dt) + piecewise(t,2,4,dt) + rect(t,2,7,dt) + piecewise(t,2,10,dt);

y1 = (xcorr(g_t,h1_t))*dt;
y1 = y1(600:1300);
T = linspace(-2,12,length(y1));

y2 = xcorr(g_t,h2_t)*dt;
y2 = y2(600:1300);

xt = -2:1:12;
yt = -1:1:2;

figure(1)
subplot(3,2,1)
plot(t,h1_t)
grid on
axis([-2 12 -1 2])
xticks(xt)
yticks(yt)

subplot(3,2,2)
plot(t,h2_t)
grid on
axis([-2 12 -1 2])
xticks(xt)
yticks(yt)

subplot(3,2,3)
plot(t,g_t)
grid on
axis([-2 12 -1 2])

subplot(3,2,4)
plot(t,g_t)
grid on
axis([-2 12 -1 2])
xticks(xt)
yticks(yt)

subplot(3,2,5)
plot(T,y1)
grid on
axis([-2 12 -1 2])
xticks(xt)
yticks(yt)

subplot(3,2,6)
plot(T,y2)
grid on
xticks(xt)
yticks(yt)

figure(2)