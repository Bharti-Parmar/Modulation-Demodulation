%% inputs example:,,,,,,,,,,,,,,,,,
%% Fc=20  , 20
%% Fs=160 , 320
%% Fm=0.4 , 0.5
 
clc;  %clear command window
clear all;  %clear our workspace
close all;  %closes all other workable windows

% Modulation Process
Fc=input('Enter the frequency of Carrier(Khz)=');    % carrier frequency of 20 kHz
Fs=input('Enter the sampling rate(per ms)=');          % sampling rate of 160 samples per ms
Fm=input('Enter the frequency of modulating signal(Khz)=');    % modulating frequency of 0.4 kHz

set(0,'defaultlinelinewidth',2);


t = 0:1/Fs:10;                  % t of 10 seconds
c = cos(2*pi*Fc*t);             % carrier signal
m = cos(2*pi*Fm*t);             % modulating signal
s = c + 0.25*cos(2*pi*(Fc+Fm)*t) + 0.25*cos(2*pi*(Fc-Fm)*t); % AM 50% mod
dsb_sc = ammod(m,Fc,Fs);        % DSB-SC signal


figure;         %creates a new window for demodulation


subplot(4,1,1);
plot(t, m);
title('Modulating Signal');
xlabel('time (s)'); 
ylabel('amplitude');
subplot(4,1,2);
plot(t, c);
title('Carrier Signal');
xlabel('time (s)');
ylabel('amplitude');
subplot(4,1,3);
plot(t, s);
title('AM Signal'); 
xlabel('time (s)'); 
ylabel('amplitude');
subplot(4,1,4);
plot(t, dsb_sc);
title('DSB-SC Signal');
xlabel('time (s)');
ylabel('amplitude');

% Non-Coherent Detection Step 1: Envelope Detection
Vc(1) = 0;                              % initial capacitor voltage
for i = 2:length(s)
    if s(i) > Vc(i-1)                   % diode on (charging)
        Vc(i) = s(i);
    else                                % diode off (discharging)
        Vc(i) = Vc(i-1) - 0.025*Vc(i-1);
    end
end

% Non-Coherent Detection Step 2: Low Pass RC Filter
h = fir1(100, 0.0125, 'low');            % 1 kHz cut-off frequency
foutputc = filter(h,1,Vc);


Vd(1) = 0;
for i = 2:length(dsb_sc)
    if dsb_sc(i) > Vd(i-1)              % diode on (charging)
        Vd(i) = dsb_sc(i);
    else                                % diode off (discharging)
        Vd(i) = Vd(i-1) - 0.025*Vd(i-1);
    end
end


figure;


subplot(3,1,1);
plot(t, Vc);
title('Envelope detector output of AM signal');
xlabel('time (s)'); 
ylabel('amplitude');
grid on;

subplot(3,1,2);
plot(t, foutputc);
title('Non-coherent demodulated AM signal'); 
xlabel('time (s)'); 
ylabel('amplitude');
grid on;
subplot(3,1,3);
plot(t, Vd);
title('Envelope detector output of DSB-SC signal'); 
xlabel('time (s)');
ylabel('amplitude');
grid on;