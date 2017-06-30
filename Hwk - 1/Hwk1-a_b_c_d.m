%% Date: 31 Jan, 2014, INTELLIGENT CONTROL SYSTEMS - ASSIGNMENT 1
%                       (Remarks: Plot 23 not showing properly, matrix dimension error)


         % Import data into matlab.
stock_prices = b;                   % import data from excell and save it in an array.
data = size(b);                     % save the size of the data array.
data = data(1);                     % select data from column 1.
win_size = 20
%
         %compute and plot the moving average
sum = 0;                            % initiate sum = 0.
mov_avg = size(stock_prices);       % set range of moving average. 
for i = 1:data                      % setting up loop to calculate the sum.
sum = sum + stock_prices(i);        % calculating the sum with each stock price iteratively.
if i <= win_size                    % check if the value of i is less than the window size.
mov_avg(i) = sum/i;                 % calculate the moving average.
else
sum = sum - stock_prices(i-win_size);% sum is the diff of final sum and stock prices* window moving backwards.
mov_avg(i) = sum/win_size;          % moving average of particular iteration is sum/window.
end
end
%%
          %plot the stock minus the 20 day moving average
figure(1);
plot(stock_prices);
title('1-A: stock prices at closing and 20 day moving average');
hold on;
plot(mov_avg);                           % plot moving average for each iteration.
          %plot the stock minus the 20 day moving average
figure(2);
plot(stock_prices-mov_avg');             % plot the difference of the moving average abd the stock prices.
hold on;
title('1-B: stock prices at closing minus 20 day moving average');
%%
          %Calculating the moving variance
mov_var = size(stock_prices);            % Assign the size of the moving variance matrix.
sum = 0;                                 % Reset sum to 0.
for i = 1:data                           % Set the number of iterations.
sum = sum+(stock_prices(i)-mov_avg(i))^2;% calculate the sum for the moving variance.
if i <= win_size                         %if the index is less than the window size, don't subtract old data
mov_var(i) = sum/i;                      % calculate the moving variance              
else
sum = sum-(stock_prices(i-win_size)-mov_avg(i-win_size))^2;% calculate the sum for moving variance.
mov_var(i) = sum / win_size;             % calculate the moving variance
end
end
%%
          %plot the moving variance
figure(3);
plot(mov_var);                           % plot the moving variance.
title('1-C: Moving Variance');

%%
          %calculate boolinger bands
%[mid,uppr,lowr] = bollinger(stock_prices, 20 , 0, 3);

[mid,uppr,lowr]= bollinger(stock_prices);
Bollinger3 = [mid, uppr,lowr];

%%
          %compute the 20 day deviation (deviation) from the variance
deviation=sqrt(mov_var);

          %plot the closing price, 20 day mov_avg.

% figure(4);
% plot(stock_prices);                      % plot stock prices.
% hold on;
% plot(mov_avg);                           % plot the moving average.
% hold on;
% title('1-D: stock prices at closing , 20 day moving average, and Bollinger Bands');
% 
% figure(5);
% plot(Bollinger)
% hold on;
% title('1-D : Bollinger Bands of stock_prices')

%%
          %compute and plot the 20 day moving skew
mov_skew = size(stock_prices);
sum = 0;
for i = 1:data
sum = sum+(stock_prices(i)-mov_avg(i))^3;
if i <= win_size %if the index is less than the window size, don't subtract old data
mov_skew(i) = sum/(i*deviation(i)^3);
else
sum = sum-(stock_prices(i-win_size)-mov_avg(i-win_size))^3;
mov_skew(i) = sum/(win_size*deviation(i)^3);
end
end
%%
figure(6);
plot(mov_skew);
title('2-A: 20 day Moving Skew');

%%
          %compute the 20 day moving kurtosis
mov_kurt = size(stock_prices);
% k = kurtosis(mov_kurt)
sum = 0;
for i = 1:data
sum = sum+(stock_prices(i)-mov_avg(i))^4;
if i <= win_size            % check if the index is less than the window size,
mov_kurt(i) = sum/(i*deviation(i)^4);
else
sum = sum-(stock_prices(i-win_size)-mov_avg(i-win_size))^4;
mov_kurt(i) = sum/(win_size*deviation(i)^4);
end
end

%%
          %plot the 20 day moving kurtosis
figure(7);
plot(mov_kurt);
title('2-B: 20 day moving kurtosis');

%%
          %compute and plot the autocorrelation
auto_cor = size(stock_prices);
for n = 1:data - win_size
sum = 0;
for k = 1:win_size
sum=stock_prices(k)*stock_prices(k+n);
end
auto_cor(n)=sum/win_size;
end
%%

figure(8);
plot(auto_cor);
title('3-A: Autocorrelation');

%%
          %compute and plot the autocovariance
auto_cov=size(stock_prices);
for n=1:data - win_size
sum=0;
for k=1:win_size
sum=(stock_prices(k)-mov_avg(k))*(stock_prices(k+n)-mov_avg(k+n));
end
auto_cov(n)=sum/win_size;
end
%%
figure(9);
plot(auto_cov);
title('3-B: Autocovariance');

%%
          %compute and plot the DFT
DFT = fft(stock_prices',data);

%%
figure(10);
k = 1:data;
plot(k,abs(DFT));
axis([0,data,0,100]);
title('4-A: DFT');

%%
          %compute and plot the  - 20 day moving average
DFT2 = fft(stock_prices',data);
DFT2 = DFT2 - mov_avg;

%%
figure(11);
k = 1:data;
plot(k,abs(DFT2));
axis([0,data,0,100]);
title('4-B: DFT minus 20 day moving average');

%%
          %compute and plot the moving window DFT
DFT3 = fft(mov_avg',data);

%%

figure(12);
k = 1:data;
plot(k,abs(DFT3));
axis([0,data,0,100]);
title('4-C: moving window DFT');
%

% L = [1:254];
% w = 2*pi*(L-1)/254; % Frequency being scaled to be within 2pi
% time = L(:,1);
% price = L(:,2);
% for k = 1:254 
%     Sum = 0;
%     
%     if k-win_size+1 < 0
%     for n = 1:k
%         Sum = Sum + price(n)*exp(-1i*2*pi*(k-1)*(n-1)/254);
%         cost(k,n) = Sum;
%     end
%     else
%      for n = 1:254
%         Sum = Sum + price(n)*exp(-1i*2*pi*(k-1)*(n-1)/254);
%         cost(k,n) = Sum;
%      end
%     end
% end
% 
% figure(14)
% mesh(win_size,time,abs(cost))
% hold on;
%%
          %compute and plot the fixed bin DFT

DFT4 = [];
for i = 1:data/win_size
    DFT4 = [DFT4, fft(stock_prices((i - 1)*win_size+1:i*win_size))];
end

%%
figure(13);
dim = size(DFT4);
k = 1:dim(2);
plot(k,abs(DFT4));
axis([0,data,0,1])
title('4-D: Fixed bin DFT');