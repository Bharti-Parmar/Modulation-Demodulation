
clc;  %clear command window
clear all;  %clear our workspace
close all;  %closes all other workable windows
t=0:0.001:1;
set(0,'defaultlinelinewidth',2); %set width of the curve
A=5;                             %Amplitude of signal
fm=input('Message frequency=');  %Accepting input value
fc=input('Carrier frequency=');  %Accepting input value (fc >= 2*fm)
mi=input('Modulation Index=');   %Modulation Index
Sm=A*sin(2*pi*fm*t);             %Message Signal
subplot(4,1,1);      %Plotting frame divided in to 4 rows and this fig appear at 1st
plot(t,Sm);
xlabel('Time');
ylabel('Amplitude');
title('Message Signal');
grid on;
Sc=A*sin(2*pi*fc*t);           %Carrier Signal
subplot(4,1,2);
plot(t,Sc);                    %plot x v/s y axes
xlabel('Time');
ylabel('Amplitude');
title('Carrier Signal');
grid on;               % puts major grid among ticks in the axes

%AM Signal, Amplitude of Carrier changes to (A+Message)
Sfm=(A+mi*Sm).*sin(2*pi*fc*t);
subplot(4,1,3);
plot(t,Sfm);
xlabel('Time');
ylabel('Amplitude');
title('AM Signal');
grid on;


