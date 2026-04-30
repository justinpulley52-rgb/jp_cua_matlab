clear all
close all
clc

%% Compute Fourier Series
figure(1)
u = 4; % pulse width
t0 = 6; % center of rect pulse
dt = 0.01; % time step
t = -11:dt:11; % time
numpulses = 3;
T = 7;
w = 2*pi/T;
t1 = -3;

g1 = rect(t,u,-6,dt);
g2 = rect(t,u,1,dt);
g3 = rect(t,u,8,dt);
g = g1+g2+g3;
g = (g.*6)-2;


%% calculate the integral and sum
%define the integral interval 
a = t1; 
b = T + t1; 
j = find( (t>=a) & (t<=b) );   

%% calculate the complex exponential form
subplot(2,2,1)
sum1 = 0;
n_lim = 8;
for n=-n_lim:n_lim     
    D_n = (1/T).*trapz(g(j).*exp(-1i.*n.*w.*t(j)))*dt;   
    result1 = D_n.*exp(1i.*n.*w.*t);     
    sum1 = sum1 + result1; 
end 
% fprintf('The result of sum is \t\t%.5f\n',sum); 
hold on
plot(t,g,'b')
grid on
plot(t,sum1)
axis([-11 11 -3 5]);
title('Complex Exponential Form with n_l_i_m = 8');

%% calculate the complex exponential form
subplot(2,2,3)
sum2 = 0;
n_lim = 19;
for n=-n_lim:n_lim     
    D_n = (1/T).*trapz(g(j).*exp(-1i.*n.*w.*t(j)))*dt;   
    result1 = D_n.*exp(1i.*n.*w.*t);     
    sum2 = sum2 + result1; 
end 
% fprintf('The result of sum is \t\t%.5f\n',sum); 
hold on
plot(t,g,'b')
grid on
plot(t,sum2)
axis([-11 11 -3 5]);
title('Complex Exponential Form with n_l_i_m = 19');

%% calculate the trignometric form
subplot(2,2,2)
sum3 = 0;
n_lim = 10;
a_0 = (1/T).*trapz(g(j))*dt;
for n=1:n_lim     
    a_n = (2/T).*trapz(g(j).*cos(n.*w.*t(j)))*dt;
    b_n = (2/T).*trapz(g(j).*sin(n.*w.*t(j)))*dt;
    result2 = (a_n.*cos(n.*w.*t))+(b_n.*sin(n.*w.*t));
    sum3 = sum3 + result2; 
end
g_approx = a_0 + sum3;
% fprintf('The result of sum is \t\t%.5f\n',sum); 
hold on
plot(t,g,'b')
grid on
plot(t,g_approx)
axis([-11 11 -3 5]);
title('Trigonometric Form with n_l_i_m = 10');

%% calculate the trignometric form
subplot(2,2,4)
sum3 = 0;
n_lim = 30;
a_0 = (1/T).*trapz(g(j))*dt;
for n=1:n_lim     
    a_n = (2/T).*trapz(g(j).*cos(n.*w.*t(j)))*dt;
    b_n = (2/T).*trapz(g(j).*sin(n.*w.*t(j)))*dt;
    result2 = (a_n.*cos(n.*w.*t))+(b_n.*sin(n.*w.*t));
    sum3 = sum3 + result2; 
end
g_approx = a_0 + sum3;
% fprintf('The result of sum is \t\t%.5f\n',sum); 
hold on
plot(t,g,'b')
grid on
plot(t,g_approx)
axis([-11 11 -3 5]);
title('Trigonometric Form with n_l_i_m = 30');


%% Computute Fourier Transform
figure(2)
u = 2; % pulse width
t0 = 0; % center of rectangular pulse
dt = 0.01; % step size
T = 20; % period
t = -T/2:dt:(T/2)-dt; % time
df = 1/T; % frequency step size
f = (-1/(2*dt)):df:(1/(2*dt))-df; % frequency


g = 0.5*rect(t,u,t0,dt); % rectangular pulse
G_f = fftshift(fft(fftshift(g)))*dt; % Fourier Transform of g(t)
g_t = fftshift(ifft(fftshift(G_f)))/dt; % Inverse Fourier Transform of G(f)

subplot(2,2,1)
plot(t,g)
axis([-10 10 0 1]);
title('Rectangular Pulse');
xlabel('Time (sec)');
hold on

subplot(2,2,2)
plot(t,g_t)
axis([-10 10 0 1]);
xlabel('Time (sec)');
title('Inverse Fourier Transform')

mag_G = abs(G_f);
subplot(2,2,3)
plot(f,mag_G)
axis([-2 2 0 1]);
xlabel('Frequency (Hz)');
title('Magnitude of the Spectrum');

phase_G = angle(G_f);
subplot(2,2,4)
stem(f,phase_G)
axis([-2 2 -4 4]);
xlabel('Frequency (Hz)');
title('Phase (in rad) of the Spectrum');
