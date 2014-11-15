function [ y ] = FMWave(fC, fD,signal, T, p)
%FMWave Generates a FM wave with carrier frequency fC and signal signal
%  fC - carrier frequency (Hz)
%  fD - max frequency deviation
%  signal - signal to encode
%  T - time to plot signal over
%  Returns:
%       y - the FM wave signal

syms t
y = @(t)(cos(2*pi*fC*t + 2*pi*fD*quadgk(@(x)signal(x),0,t)));
for i = 1:length(T)
    w(i) = y(T(i));
end
if p
    subplot(2,1,1);
    plot(T,signal(T));
    subplot(2,1,2);
    plot(T,w);
end
y = w;


end

