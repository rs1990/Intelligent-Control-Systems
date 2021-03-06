clc;
clear all;
close all;

x=zeros(2,100);
xn=zeros(2,100); 
A=[0    1
  -0.89 1.8];
B=[0 
   1]; 
u=ones(100,1);
t=1:100; 
for i=1:99 
x(:,i+1)=A*x(:,i)+B*u(i);  
end 
plot(t,x(1,:),t,x(2,:));
hold on;
plot(t,x(2,:),'r');
grid; 
title('System States Without Noise') 


w = 0.2*rand(2,100);
for i=1:99 
x(:,i+1)=A*x(:,i)+B*u(i)+w(i);  
end 
plot(t,x(1,:),t,x(2,:));
hold on;
plot(t,x(2,:),'r');
grid; 
title('System States Without Noise') 

% A = [0 1; -1 0];        % State transition matrix
% B = [0; 1];  
% C = [0 1];  
% D = 0;                  % Input, output, feed-around
% 
% % Set up the input signal, initial conditions, etc.
% x0 = [0;0];             % Initial state (N=2)
% Ns = 1 : 50;                % Number of sample times to simulate
% u = [1, zeros(1,50)]; % Input signal (an impulse at time 0)
% y = zeros(50,1);        % Preallocate output signal for n=0:500
% 
% % Perform the system simulation:
% x = x0;                % Set initial state
% for n=1:50-1           % Iterate through time
%   y(n) = C*x + D*u(n); % Output for time n-1
%   x = A*x + B*u(n);    % State transitions to time n
% end
% y' % print the output y (transposed)
% plot(Ns,y)
% 


