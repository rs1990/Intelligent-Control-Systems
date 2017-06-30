clc;
clear all;
close all;
FileName = ['homework 2 data 3.xls']
samples = xlsread(FileName);
x = samples(:,3);
win=500;
time = 0.001;
for k = 500:6001
    t=k-win+1;
    y(:,k)=fft(x(t:k),512);
    py(:,k)=y(:,k).*conj(y(:,k));
   
   

end
 w=1000*(0:511)/512;  
 figure(1)
    waterfall(w,x,abs(py)');
    title('Iterations of DFT using moving window ');
    hold on;
    grid on;
    title('DFT ');
    xlabel('freq');
    ylabel('time');
    zlabel('DFT');
