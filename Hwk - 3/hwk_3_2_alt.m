
A=[0 1; -.89 1.8];

B=[0;1];

H=[1 0];

Q=.1;

G=eye(2);

w=sqrt(.1)*randn(2,100); %Process noise

R=.1;



v=sqrt(.1)*randn(1,100); 

u=ones(1,100);

x=zeros(2,100);

for k=1:99

x(:,k+1)=A*x(:,k)+B*u(k)+G*w(:,k);

z(k)=H*x(:,k)+v(k);

end

z(100)=H*x(:,100)+v(100);

estx_minus=[0;0];

P=[2 0;0 3];

estx=zeros(2,100);

for k=1:100

Pminus=A*P*A'+G*Q*G';

estx_minus=A*estx_minus+B*u(k);

P=inv(inv(Pminus)+H'*inv(R)*H);

K=P*H'*inv(R); %Kalman Gain

estx(:,k)=estx_minus+K*(z(k)-H*estx_minus);

end

plot(1:100,x(1,:),1:100,estx(1,:));

plot(1:100,x(2,:),1:100,estx(2,:));
