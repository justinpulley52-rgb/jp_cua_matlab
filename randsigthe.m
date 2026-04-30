clear all
close all
clc



% circle centered at 1,1
radius = 1; %radius of circle
n = 100000; % number of monticarlo runs
x=2.*rand(1,n);
y=2.*rand(1,n);
cent_x = 1;
cent_y = 1;

outRad = radius<(sqrt(((x-cent_x).^2)+((y-cent_y).^2)));
inRad = radius>(sqrt(((x-cent_x).^2)+((y-cent_y).^2)));

hold on
plot(x(outRad),y(outRad),'b*');
plot(x(~outRad),y(~outRad),'r*')

n_outRad = sum(double(outRad));
n_inRad = sum(double(inRad));

areaCircle = 4.*(n_inRad./(n));
%squares area-circle area


