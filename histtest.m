clear all
close all
clc

% x = randn(1000,1);  
% [count,centers]=hist(x,100)
% bin_size = centers(2)-centers(1)
% area = sum(count)*bin_size;
% density = count/area;
% bar(centers,density,1);
% x=1:10
% y=zeros(10,10)
% y(:,1)=x'

% Input number of angles and nominal range and frequency
% Mf=input('Enter # of frequencies: ');
% f1=input('Enter start frequency (Hz): ');
Mf = 300;
f1 = 10e9;
f2 = 15e6;
fv = f1+(0:Mf-1)*f2;