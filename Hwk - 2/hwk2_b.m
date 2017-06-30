clc;
clear all;
close all;
FileName = ['homework 2 data 2.xls']
x = xlsread(FileName);
x2=x(:,3);
win=1000;k=1;
for i=1:8
    k;
    temp=k+win-1;
    y(:,i)=fft(x2(k:k+win-1),1024);
    py=y.*conj(y)/1024.*conj(y)/1024;
    k=k+win;
    
    figure(1)
    subplot(2,4,i);
    waterfall(abs(py'))
    title('Iterations of DFT using Bin ');
    hold on;
    axis([0,100,0,10,0,400])
    w=1000*(0:1023)/1024;
   
    py=y.*conj(y)/1024.*conj(y)/1024.*conj(y)/1024;
    figure(2)
    plot3(ones(1,1024).*i,w',abs(py))
    hold on
    grid on;
    title('DFT of Bins');
    xlabel('second');
    ylabel('Freq Hz');
    zlabel('Magnitude');

end


