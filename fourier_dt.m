function [Mx,phx,f] = fourier_dt(x,Fs,scope)

% [Mx,phx,f] = fourier_dt(x,Fs)
%
% Computes the amplitude and phase spectra of a discrete-time signal
%
% Mx is the magnitude spectrum, scaled so sinusoids with amplitude A produce
%    a magnitude of A
% phx is the phases spectrum (in radians)
% f is the array of scaled frequencies (in Hz)
%
% x is the input discrete-time signal
% Fs is the sampling frequency (in Hz)
% scope is the frequency scope of the spectrum
%       use scope = 'full' for negative as well as positive frequencies,
%                          i.e., a "two-sided" spectrum
%       use scope = 'half' for just positive frequencies, i.e., a "one-sided
%                          spectrum", with magnitudes doubled to account for
%                          the amplitudes of the missing negative frequencies

% Based on code from the MathWorks Web Site, 1998
% Ian Bruce <ibruce@ieee.org>

Fn=Fs/2;          % Nyquist frequency
NFFT = length(x); % Length of input signal
FFTX=fft(x,NFFT); % Take the FFT of x
switch lower(scope)
    case 'full'
        FFTX=fftshift(FFTX); % Shift negative frequencies to the first half of the array
        Mx=abs(FFTX);        % Take magnitude of X
        phx=angle(FFTX);     % Take phase of X
        Mx=Mx/length(x);     % Scale the FFT so that it is not a function of the length of x.
        f=(-floor(NFFT/2):floor((NFFT-1)/2))*2*Fn/NFFT; % Calculate frequency array      
    case 'half'
        if ~isreal(x)
            disp('x is complex valued - it is recommended to use a scope of "full"')
        end
        NumUniquePts = ceil((NFFT+1)/2);
        FFTX=FFTX(1:NumUniquePts); % Only keep spectrum for positive frequencies
        Mx=abs(FFTX);    % Take magnitude of X
        phx=angle(FFTX); % Take phase of X
        Mx=Mx*2; % Multiply by 2 to take into account the fact that we threw out second half of FFTX above
        Mx(1)=Mx(1)/2;   % Account for uniqueness of DC value
        if ~rem(NFFT,2)	 % Account for endpoint uniqueness
          Mx(length(Mx))=Mx(length(Mx))/2;
        end
        Mx=Mx/length(x); % Scale the FFT so that it is not a function of the length of x.
        f=(0:NumUniquePts-1)*2*Fn/NFFT; % Calculate frequency array
    otherwise
        disp(['scope "' scope '" is unknown'])
end
