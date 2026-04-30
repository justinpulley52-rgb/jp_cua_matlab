function [g] = rect(t,u,t0,dt)

% t --> time
% u --> pulse width
% dt --> step size
% t0 --> center of rect pulse


g = zeros(1,length(t));

g( (t > t0 -(u/2)) & (t < t0 + (u/2)) ) = 1;

end