function [g] = rect(t,u,t0,dt)

% t --> time
% u --> pulse width
% dt --> step size
% t0 --> center of rect pulse

% %%function inputs
% t = -11:dt:11;
% u = 4;
% t0 = 6;
% dt = 0.01;

% T0 = 7;
% t1 = 2; % so T0 + t1 < 11

% w0 = 2*pi./T0;

g = zeros(1,length(t));

% % Way 1
% for idx = 1:length(g)
%     if (t(idx) == t0 - (u/2)) | (t(idx) == t0 + (u/2))
%         g(idx) = 0.5;
%     elseif (t(idx) < t0 + (u/2)) & (t(idx) > t0 -(u/2))
%         g(idx) = 1;
%     else
%         g(idx) = 0;
%     end
% end

% % Way 2
% j = (t > t0 -(u/2)) & (t < t0 + (u/2)); 
% i = (t == t0 - (u/2)) | (t == t0 +(u/2));
% g(j) = 1;
% g(i) = 0.5;

% % Way 3
% j = find((t > t0 -(u/2)) & (t < t0 + (u/2))); 
% i = find((t == t0 - (u/2)) | (t == t0 +(u/2)));
% g(j) = 1;
% g(i) = 0.5;

%Way 4
g( (t > t0 -(u/2)) & (t < t0 + (u/2)) ) = 1;
g( (t == t0 - (u/2)) | (t == t0 +(u/2)) ) = 0.5;

% plot(t,g)
% grid on
end