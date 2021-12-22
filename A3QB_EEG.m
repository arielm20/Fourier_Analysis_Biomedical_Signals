%EEG Analysis
%Ariel Motsenyat - motsenya 
%Sharon Cai - cais12

load EEGdata_assignment3.mat

%Part 1
t1 = 0:1/Fs:(length(EEG1)-1)/Fs; %time array of EEG1
t2 = 0:1/Fs:(length(EEG2)-1)/Fs; %time array of EEG2

[MEEG1, phEEG1, fEEG1] = fourier_dt(EEG1, Fs, 'full'); %2-sided spectra of eeg1
[MEEG2, phEEG2, fEEG2] = fourier_dt(EEG2, Fs, 'full'); %2-sided spectra of eeg2

figure
subplot(2,1,1)
plot(fEEG1,MEEG1)
xlim([0 30])
ylabel('|X(f)| (mV)')
title('EEG1')
subplot(2,1,2)
plot(fEEG2,MEEG2)
xlim([0 30])
ylabel('|X(f)| (mV)')
title('EEG2')
xlabel('f (Hz)')

%Part 2
%find indices of frequencies
f0_i1 = find(fEEG1 >= 0, 1);
f3_i1 = find(fEEG1 < 3, 1, 'last');
f8_i1 = find(fEEG1 < 8, 1, 'last'); 
f13_i1 = find(fEEG1 < 13, 1, 'last');
f25_i1 = find(fEEG1 < 25, 1, 'last');
f100_i1 = find(fEEG1 <= 100, 1, 'last');

f0_i2 = find(fEEG2 >= 0, 1);
f3_i2 = find(fEEG2 < 3, 1, 'last');
f8_i2 = find(fEEG2 < 8, 1, 'last'); 
f13_i2 = find(fEEG2 < 13, 1, 'last');
f25_i2 = find(fEEG2 < 25, 1, 'last');
f100_i2 = find(fEEG2 <= 100, 1, 'last');

%calculate band power of each EEG freq. band
delta_P1 = sum(MEEG1(f0_i1:f3_i1).^2);
theta_P1 = sum(MEEG1(f3_i1+1:f8_i1).^2);
alpha_P1 = sum(MEEG1(f8_i1+1:f13_i1).^2);
betta_P1 = sum(MEEG1(f13_i1+1:f25_i1).^2);
gamma_P1 = sum(MEEG1(f25_i1+1:f100_i1).^2);

delta_P2 = sum(MEEG2(f0_i2:f3_i2).^2);
theta_P2 = sum(MEEG2(f3_i2+1:f8_i2).^2);
alpha_P2 = sum(MEEG2(f8_i2+1:f13_i2).^2);
betta_P2 = sum(MEEG2(f13_i2+1:f25_i2).^2);
gamma_P2 = sum(MEEG2(f25_i2+1:f100_i2).^2);

P_EEG1 = [delta_P1 theta_P1 alpha_P1 betta_P1 gamma_P1];
P_EEG2 = [delta_P2 theta_P2 alpha_P2 betta_P2 gamma_P2];

figure
bands = categorical({'delta', 'theta', 'alpha', 'beta', 'gamma'});
bands = reordercats(bands,{'delta', 'theta', 'alpha', 'beta', 'gamma'});
bar(bands, P_EEG1)
xlabel('Frequency Bands')
ylabel('Band Power (mV^2)')
title('EEG1')

figure
bands = categorical({'delta', 'theta', 'alpha', 'beta', 'gamma'});
bands = reordercats(bands,{'delta', 'theta', 'alpha', 'beta', 'gamma'});
bar(bands, P_EEG2)
xlabel('Frequency Bands')
ylabel('Band Power (mV^2)') 
title('EEG2')

%normalize band power by dividing by its bandwidth
%bandwidth = f2-f1, eg. for bandwidth of theta = 8-3 =5
delta_P1n =  delta_P1 / 3;
theta_P1n = theta_P1 / 5; 
alpha_P1n = alpha_P1 / 5;
beta_P1n = betta_P1 / 12;
gamma_P1n = gamma_P1 / 75;

delta_P2n = delta_P2 / 3;
theta_P2n = theta_P2 / 5;
alpha_P2n = alpha_P2 / 5;
beta_P2n = betta_P2 / 12;
gamma_P2n = gamma_P2 / 75;

P_EEG1n = [delta_P1n theta_P1n alpha_P1n beta_P1n gamma_P1n];
P_EEG2n = [delta_P2n theta_P2n alpha_P2n beta_P2n gamma_P2n];

figure
bands = categorical({'delta', 'theta', 'alpha', 'beta', 'gamma'}); 
bands = reordercats(bands,{'delta', 'theta', 'alpha', 'beta', 'gamma'}); 
bar(bands, P_EEG1n)
xlabel('Frequency Bands')
ylabel('Normalized Band Power (mV^2/Hz)') 
title('EEG1')

figure
bands = categorical({'delta', 'theta', 'alpha', 'beta', 'gamma'});
bands = reordercats(bands,{'delta', 'theta', 'alpha', 'beta', 'gamma'});
bar(bands, P_EEG2n)
xlabel('Frequency Bands')
ylabel('Normalized Band Power (mV^2/Hz)') 
title('EEG2')

% BONUS: spectrograms of the two EEG signals
winlen = 1e3;  % length of the windowed segments
overlap = 500; % number of samples overlapping for each window position
NFFT = 20e3;   % number of points in the FFT (the signal is zero-padded to this length)

figure
subplot(2,1,1)
[s_EEG1,f_EEG1,t_EEG1] = spectrogram(EEG1,winlen,overlap,NFFT,Fs);
imagesc(t_EEG1,f_EEG1,abs(s_EEG1)/winlen)
axis xy
ylim([0 30])
title('EEG1')
ylabel('f (Hz)')
cb1 = colorbar;
cb1.Label.String = '|X(f)| (mV)';
subplot(2,1,2)
[s_EEG2,f_EEG2,t_EEG2] = spectrogram(EEG2,winlen,overlap,NFFT,Fs);
imagesc(t_EEG2,f_EEG2,abs(s_EEG2)/winlen)
axis xy
ylim([0 30])
title('EEG2')
ylabel('f (Hz)')
xlabel('t (s)')
cb2 = colorbar;
cb2.Label.String = '|X(f)| (mV)';
