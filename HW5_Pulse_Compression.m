clear all
close all
clc

% Generate three chirp pulses, each of duration T=100us but with swept
% bandwidths of 100kHz, 1MHz, and 10 MHz. Oversample by a factor of k=1.2
k = 1.2;
kHz = 1e3;
Mhz = 1e6;
us = 1e-6;
T = 100*us;

chirp_1 = git_chirp(T,100*kHz,k); % BT product = 10
chirp_2 = git_chirp(T,1*Mhz,k); % BT product = 100
chirp_3 = git_chirp(T,10*Mhz,k); % BT product = 1000

% Power in each signal also is proportional to bandwidth, because
% sampling rate is proportional to bandwidth but time duration
% is constant.  For  "niceness" of the plot, normalize by square 
% root to length so all spectra will have about the same amplitude.

% QUESTION - How does this normailze the amplitude of the signals

chirp_1 = chirp_1/sqrt(length(chirp_1));
chirp_2 = chirp_2/sqrt(length(chirp_2));
chirp_3 = chirp_3/sqrt(length(chirp_3));

% compute the spectra of all three, shifting the origin to the
% center of the plot, and plotting against normalized frequency

% QUESTION - Coming from matlab doc on fft, what is the n-point DFT

N = length(chirp_3);
chirp_1 = abs(fftshift(fft(chirp_1,N)));
chirp_2 = abs(fftshift(fft(chirp_2,N)));
chirp_3 = abs(fftshift(fft(chirp_3,N)));

% define frequency variable and do the plot

figure(1)
freq = ((0:N-1)/N)-0.5;
plot(freq,[chirp_1 chirp_2 chirp_3]);
xlabel('normalized frequency (cycles)'); 
ylabel('spectrum amplitude');

% Generate an LFM complex chirp with duration T = 100 us and swept 
% bandwidth B = 1 MHz. Oversample by a factor of at least k = 10. Also 
% generate a simple pulse of the same length

chirp_4 = git_chirp(T,1*Mhz,10);
pulse_1 = ones(size(chirp_4));

% Working in the time domain, compute the output of the matched filter for 
% each of the two pulses, assuming a single point scatterer. This will 
% simply be the convolution of the waveform with its matched filter, or 
% equivalently, the autocorrelation of the waveform. The computation must 
% be done in the time domain. Overlay plots of the magnitude1 of the two 
% matched filter output responses onto the same plot. The time axis of the 
% plot must be labeled in seconds, not samples.

chirp_5 = chirp_4;
lfmconv = conv(chirp_4,chirp_5)

pulse_2 = pulse_1
pulconv = conv(pulse_1,pulse_2)

figure(2)
plot(abs([lfmconv pulconv])); xlabel('Range (km)'); ylabel('amplitude');
grid
