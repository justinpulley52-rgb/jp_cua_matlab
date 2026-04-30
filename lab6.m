close all
clear all
clc

T = 1;
dt = 0.01; % time step size
N = 200;
t = linspace(0,(N*dt)-dt,N);

m = sin(6*t);
factor = 8;
% Ts = factor*dt; % sampling period
m_ds = downsample(m,factor);
% m_s = upsample(m_ds,factor);
k = 3; % bit per samples
L = 2^k; % quantization level
m_max = max(m_ds); % maximum message signal value
m_min = min(m_ds); % minimum message signal value
delta = (m_max-m_min)/L; % quantization interval
level_max = m_max - delta/2; % maximum level
level_min = m_min + delta/2; % minimum level
q_levels=level_min:delta:level_max; % quantization
m_level = round((m_ds-level_min)/delta); % quantization
m_level(m_level>(L-1)) = L-1; %extreme maximum fix
encoded = dec2bin(m_level,2);
m_quantized = (m_level.*delta) + level_min; % quantization
m_quantized(m_quantized>level_max) = level_max; % extreme maximum fix
m_quantized(m_quantized<level_min) = level_min; % extreme minimum fix
m_quantized_flat = kron(m_quantized, ones(1,factor));
m_quantized_up = upsample(m_quantized,factor);
bin_up = upsample(encoded,factor);

plot(t,m,'b')
hold on
bar(t,m_quantized_up,4,'r',EdgeColor='k',LineWidth=1.5)
text(t,m_quantized_up,bin_up,'HorizontalAlignment','center','VerticalAlignment','bottom')
title('Message Signal and Quantized Signal with Level L = 8')

encoded2 = reshape(encoded',1,[]);
disp(['The bitstream representing the PCM signal is ' encoded2])