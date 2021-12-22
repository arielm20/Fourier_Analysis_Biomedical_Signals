%VGRF Filter Analysis
%Ariel Motsenyat - motsenya 
%Sharon Cai - cais12

Fs = 100; % Sampling frequency
N = 2396; % Number of samples
t = (0:N-1)/Fs; % Time vector

load('VGRFdata_assignment4.mat');
x = VGRF; % VGRF data

% input Time domain plot of the VGRF vector
figure
subplot(1,1,1)
plot(t,x)
title('Input Time-Domain Waveform of VGRF signal')
ylabel('Vectoral Ground Reaction Force (N)')
xlabel('time (s)')

[Mx_full,phx_full,f_full] = fourier_dt(x,Fs,'half'); %fourier_dt calculates magnitude spectra of VGRF data

% input Magnitude spectrum of the VGRF data 
figure
subplot(2,1,1)
plot(f_full,Mx_full)
ylabel('|X(f)|')
xlabel('f (Hz)')
title('VGRF Input Magnitude Spectra')
xlim([0 15])
ylim([0 200])

% input Phase spectrum of the VGRF data
figure
subplot(2,1,1)
plot(f_full,phx_full)
ylabel('<X(f)')
xlabel('f(Hz)')
title('VGRF Input Phase Spectra')
xlim([0 15])

% IIR Filtered Data
filterdata_IIR = load('VGRF_IIR.mat');
IIR_hd = filterdata_IIR.Hd;
IIR_filt = filter(IIR_hd,x); 

% FIR Filtered Data
filterdata_FIR = load('VGRF_FIR_Equiripple.mat'); %figure out which FIR filter is better
FIR_hd = filterdata_FIR.Hd;
FIR_filt = filter(FIR_hd,x);

% output Time domain plot of the IIR and FIR filtered VGRF vector
figure
subplot(2,1,1)
plot(t,IIR_filt)
title('Output Time-Domain Waveform of VGRF signal - IIR Bandpass Filter')
ylabel('Amplitude (N)')
xlabel('time (s)')
xlim([0 23])
subplot(2,1,2)
plot(t,FIR_filt)
title('Output Time-Domain Waveform of VGRF signal - FIR Bandpass Filter')
ylabel('Amplitude (N)')
xlabel('time (s)')
xlim([0 10])

[Mx_IIR,phx_IIR,f_IIR] = fourier_dt(IIR_filt,Fs,'half');
[Mx_FIR,phx_FIR,f_FIR] = fourier_dt(FIR_filt,Fs,'half');

% output Magnitude spectrum for VGRF - IIR and FIR
figure
subplot(2,1,1)
plot(f_IIR,Mx_IIR)
ylabel('|X(f)|')
xlabel('f (Hz)')
title('VGRF Output Magnitude Spectra - IIR Bandpass Filter')
xlim([0 15])
ylim([0 200])
subplot(2,1,2)
plot(f_FIR,Mx_FIR)
ylabel('|X(f)|')
xlabel('f (Hz)')
title('VGRF Output Magnitude Spectra - FIR Bandpass Filter')
xlim([0 15])
ylim([0 200])

% output Phase spectrum for VGRF - IIR and FIR
figure
subplot(2,1,1)
plot(f_IIR,phx_IIR)
ylabel('|X(f)|')
xlabel('f (Hz)')
title('VGRF Output Phase Spectra - IIR Bandpass Filter')
xlim([0 50])
subplot(2,1,2)
plot(f_FIR,phx_FIR)
ylabel('|X(f)|')
xlabel('f (Hz)')
title('VGRF Output Phase Spectra - FIR Bandpass Filter')
xlim([0 50])

