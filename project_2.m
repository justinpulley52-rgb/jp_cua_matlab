clear all
close all
clc

%% Unit Response
figure(1)
num = 1;
den = [1 8 0];
G = tf(num,den); % Transfer function of motor, G

for K = [7 16 80]
    
    T = feedback(G*K,1); % Total Transfer Function, T
    hold on
    if K == 7
        step(T,'k')
    elseif K == 16
        step(T,'--b')
    else
        step(T,'--g')
    end
end

hold off
legend('K = 7','K = 16','K = 80');
axis([0 6 0 1.4]);
grid on

%% Ramp Response
   
num = 1;
den = [1 0];
rampmod = tf(num,den);

figure(2)
for K = [7 16 80]
    T = feedback(G*K,1); % Total Transfer Function, T
    T2 = series(T,rampmod); % Modified transfer function for ramp
    hold on
    if K == 7
        step(T2,'k')
    elseif K == 16
        step(T2,'--b')
    else
        step(T2,'--g')
    end 
end

hold off
title('Unit Ramp Response');
legend('K = 7','K = 16','K = 80');
axis([0 6 0 5]);
grid on

%% Parabolic Response
num = 2;
den = [1 0 0];
paramod = tf(num,den);

figure(3)
for K = [7 16 80]
    T = feedback(G*K,1); % Total Transfer Function, T
    T3 = series(T,paramod); % Modified transfer function for parabolic
    hold on
    if K == 7
        step(T3,'k')
    elseif K == 16
        step(T3,'--b')
    else
        step(T3,'--g')
    end 
end

hold off
title('Parabolic Response');
legend('K = 7','K = 16','K = 80');
axis([0 6 0 25]);
grid on

%% System Outputs
syms s t
for K = [7 16 80]
    Gs = 1/(s*(s+8));
    Ts = (K*Gs)/(1+(K*Gs));
    
    stepinput_s = laplace(heaviside(t));
    stepoutput_t = ilaplace(Ts*stepinput_s)
    
    rampinput_s = laplace(t*heaviside(t));
    rampoutput_t = ilaplace(Ts*rampinput_s)
    
    parainput_s = laplace((t^2)*heaviside(t));
    paraoutput_s = ilaplace(Ts*parainput_s)
end
