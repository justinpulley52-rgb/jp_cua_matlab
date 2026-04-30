function [h] = piecewise(t,u,t0,dt)

half_u = u/2;
quarter_u = u/4;
firstcenter = t0 - quarter_u;
secondcenter = t0 + quarter_u;
h = rect(t,half_u,firstcenter,dt) - rect(t,half_u,secondcenter,dt);

end
