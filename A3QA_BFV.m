%BFVdu Analysis: Fourier Analysis of Blood Flow Velocity Signals
%Sharon Cai - cais12
%Ariel Motsenyat - motsenya 

load('BFVdata_assignment3.mat','BFVdu'); % load BFVdu
xBFV = BFVdu;

N = length(xBFV); % # of samples
Fs = 100; % sampling freq used to collect blood-flow velocity 
%% 1. plot magnitude spectrum of entire signal BFVdu
[Mx_BFV,ph_BFV,f_BFV] = fourier_dt(xBFV,Fs,'full'); %compute mag spectra

figure
plot(f_BFV,Mx_BFV)
xlim([-20 20]) 
xlabel('Frequency (Hz)');
ylabel('|X(f)| (mV)')
title('Magnitude Spectrum of entire signal BFV') 
%% 2. plot magnitude spectrum of portion of signal BFVdu from 1 to L
x_LBFV = xBFV(1:320); %resize, L = 320
length(x_LBFV);

[Mx_LBFV,ph_LBFV,f_LBFV] = fourier_dt(x_LBFV,Fs,'full');

figure
plot(f_LBFV,Mx_LBFV)
xlim([-20 20])
xlabel('Frequency (Hz)');
ylabel('|X(f)| (mV)')
title('Magnitude Spectrum of BFV | Signal to Length L = 320')
%% 3. plot magnitude spectrum of portion of signal BFVdu from 1 to L with zero-padding of length L
L = length(x_LBFV);
x_zpBFV = [x_LBFV; zeros(L,1)];

[Mx_zpBFV,ph_zpBFV,f_zpBFV] = fourier_dt(x_zpBFV,Fs,'full');

figure
plot(f_zpBFV,Mx_zpBFV)
xlim([-20 20])
xlabel('Frequency (Hz)');
ylabel('|X(f)| (mV)')
title('Zero-Padded Magenitude Spectrum of BFV ')
%% comparison graph for L = 320 (task 2) and entire BFV signal (task 1)
figure
plot(f_BFV,Mx_BFV, 'k') %full
hold on
plot(f_LBFV,Mx_LBFV, 'r') %1:L
xlim([-20 20])
xlabel('Frequency (Hz)');
ylabel('|X(f)| (mV)')
title('Full BFV vs BFV with L = 320 Magnitude Spectrum');
legend('Magnitude Spectrum of BFV', 'Magnitude Spectrum of BFV | L = 320');
%% %comparison graph for L = 320 and zero padded (task 3)
figure %plotting all 3 for comparison 
plot(f_BFV,Mx_BFV, 'k'); %full
hold on
plot(f_LBFV,Mx_LBFV, 'r'); %1:L
hold off
hold on
plot(f_zpBFV,Mx_zpBFV, 'b') %zero-padded
hold off
xlim([-10 10]); 
xlabel('Frequency (Hz)');
ylabel('|X(f)| (mV)')
title('Full BFV vs BFV with L = 320 vs 0-Padded BFV Magnitude Spectrum'); 
legend('Magnitude Spectrum of BFV', 'Magnitude Spectrum of BFV | L = 320', 'Magnitude Spectrum of BFV | L = 320 | 0-Padded'); 
%% spectrogram BFV
winlen = 60;  % length of the windowed segments
overlap = 10; % # of samples overlapping for each window position
NFFT = 400;   % # of points in the FFT (signal is zero-padded to this length)

figure
[s_BFV,F_BFV,t_BFV] = spectrogram(xBFV,winlen,overlap,NFFT,Fs);
imagesc(t_BFV,F_BFV,abs(s_BFV)/winlen)
axis xy
ylim([0 30])
title('BFV Spectrogram')
ylabel('f (Hz)')
xlabel('t (s)')
cb1 = colorbar;
cb1.Label.String = '|X(f)| (mV)';