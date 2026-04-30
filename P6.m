clear all
close
clc

syms a b t s

%% Part A
num = [6 204];
den = [1 10 34 0];
[r,p,k] = residue(num,den)

%% Part B
x = (sin(a*t)+cos(b*t))*heaviside(t);
X = laplace(x)

Xs = (a*s^2)/(s^2+b^2);
xt = ilaplace(Xs)

%% Part C
y = (t-1)*heaviside(t-1)-(t-2)*heaviside(t-2)-heaviside(t-4);
Y = laplace(y)
