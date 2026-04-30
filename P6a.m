clear all
close
clc

% %% a
% num = [6 204];
% den = [1 10 34 0];
% [r,p,k] = residue(num,den)
% 
% %% b
% syms a t b
% x = sin(a*t)+cos(b*t);
% X = laplace(x)
% 
% %% b
% syms a s b
% Xs = (a*s^2)/(s^2+b^2);
% xt = ilaplace(Xs)
% 
%% c
syms t w
x = (t-1)*heaviside(t-1)-(t-2)*heaviside(t-2)-heaviside(t-4);
X = laplace(x)
