function [ res ] = RCLSeriesResponse(C,R,L,fs)
%RCLSeriesResponse
%   Plots the frequency response for a simple series RCL bandpass filter.
%   Params:
%       C - Capacitance (F)
%       R - Resistance (Ohm)
%       L - Inductance (h)
%       fs - Frequencies to test (vector, MHz)
%   Returns:
%       res - Response (dB)


    fs = fs.*(2*pi*10^6); %frequencies to test
    %Analytic solution to frequency response curve, compliments of the laplace
    %transform (s= sig+w*i, where w is the frequency and i is the imaginary unit)
    %sig is zero cause it's not attentuated (complex frequency is weird)
    response = inline('(log((R.*w.*5.0e-1i)./(L.*(-w.^2+w_0.^2+(R.*w.*1i)./L))+(conj(R).*conj(w).*5.0e-1i)./(conj(L).*(conj(w).^2-conj(w_0).^2+(conj(R).*conj(w).*1i)./conj(L)))).*1.0e1)./log(1.0e1)');
    %fundemental frequency
    w_0 = sqrt(1/(L*C));
    %plot the responses, axis in MHz
    res = response(L,R,fs,w_0);
    plot(fs/(2*pi)*10^-6,res)
    %plot((fs)./(2*pi),10*log10((real(m))/9));
    axis([min(fs/(2*pi)*10^-6) max(fs/(2*pi)*10^-6) -7 0]);
    xlabel('Frequency (MHz)');
    ylabel('Gain (dB)');
    title(strcat('Output Amplitude versus Signal Frequency (f_o=',num2str(sqrt(1/(L*C))/2/pi*10^-6,4),'MHz, \Delta f=',num2Str(R/(2*pi*L)*10^-6, 3), 'MHz )'));
end

