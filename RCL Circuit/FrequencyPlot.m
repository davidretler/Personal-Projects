function [ power ] = FrequencyPlot(sig, t, fs, frange)
%   Plots the signal and the frequency spectrum of the given signal
%   Arguments:    
%       signal - vector containing the signal amplitude (symbolic or
%       numeric)
%       t - the time frame of the signal (s)
%       fs - sample frequency (Hz)
%       frange - [fMin fMax] where fMin and fMax are the minumum and
%       maximum frequencies to plot, if frange is length one we take it to
%       represent the max frequency (with the minumum frequency defaulting
%       to 0.)
%   Returns:
%       plot of signal and frequency spectrum
    
   

    % time vector, goes up to t, steps of 1/fs
    T = 0:1/fs:t;
    if strcmp(class(sig),'inline')
        signal = sig(T);
    end
    % evaluate the signal function if it is symbolic
    if ischar(sig)
        signal = eval(sig);
    end
    % copy yhr signal into signal if it is numeric
    if isnumeric(sig)
        signal = sig(1:length(T));
    end
    % First plot
    subplot(3,1,2)
    % Plot the signal over time
    plot(T,signal)
    xlabel('Time (s)')
    ylabel('Amplitude')
    % Length of the signal
    m = length(signal);
    % Scale the number of samples based on signal length
    n = pow2(nextpow2(m));
    % Compute the fourier transform of the signal
    y = fft(signal,n);
    % fmax is an optional maximum frequency
    if ~exist('frange','var')
        frange = [0 fs];
    else if length(frange) < 2
            frange(2) = frange(1);
            frange(1) = 0;
    end
    % These are the domain of the fft
    f = (0:n-1)*(fs/n);
    % Calaculate power
    power = y.*conj(y)/n^2;
    % Plot the frequency spectrum
    subplot(3,1,3)
    plot(f(1:length(f)/2), power((1:length(f)/2)));
    axis([frange(1:2) 0 max(power)]);
    xlabel('Frequency (Hz)');
    ylabel('Power');
end

