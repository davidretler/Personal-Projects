%Plots an FM wave as well as the original signal and the FM wave's
%frequency spectrum, utalizing the MFWave and FrequencyPlot functions.

T = 0:0.0001:8;
subplot(3,1,1)
plot(T,sin(4*T))
FrequencyPlot(FMWave(5,2,@(t)sin(4*t),0:0.001:8,false),8,1/.001,[0 10]);
subplot(3,1,1)
xlabel('Time (s)');
ylabel('Signal Amplitude');
FrequencyPlot(FMWave(5,2,@(t)sin(4*t),0:0.0001:8,false),8,1/.0001,[0 10]);
subplot(3,1,1)
title('Broadcast Signal, FM Wave, and Frequency Spectrum of the FM Wave')
title(strcat('Broadcast Signal, FM Wave, and Frequency Spectrum of the FM Wave',' f_c=',num2str(5),', f_\Delta=',num2str(2),', f_m=',num2str(4)))
subplot(3,1,2)
title('FM Wave')
subplot(3,1,3)
title('Frequency Spectrum')