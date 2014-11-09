clear()
%Solves the circuit equation for a series RCL circuit with time-variying
%voltage whos waveform is equal to V*sin(w*t) and inital charge and current
%are both 0
circ = dsolve('D2q+R/L*Dq+1/(L*C)*q = V*sin(w*t)/L','q(0)=0','Dq(0)=0','t'); %time varying voltage
%circ=dsolve('D2q+R/L*Dq+1/(L*C)*q = V','q(0)=0','Dq(0)=0','t'); %constant
%voltage


%Take the time derivtavie of charge to get current
circdiff = simplify(diff(circ,'t'));


%Define our circuit components
C = 5.8521e-15; %capacitor (F)
R = 250; %resistor  (Ohm)
L = 397.9e-6; %inductor  (h)
V = 9; %voltage source (V) 
t = 0:0.001:25; %time (s)

%False if you don't want to plot all the waveforms
%It doesn't even work for really high numbers, so the paramters for the
%radio make this functionality worthless anyway, but I'm keeping it here
%incase I bring the frequency down for giggles
plotWaveForms = false;

%Store the figure as a variable so we can grabe frames
fh = figure(1);

gif_fps = 8; %Framerate for our output
video_filename = 'RCL.gif'; %filename for our output
i = 0;

%I'm tuning to 104.3MHz cause they have good progressive rock
fs = (104.2:.001:104.4).*(2*pi*10^6); %frequencies to test
%Test the circuit for these frequencies (rad/s)
v = zeros(length(fs),length(t));
if plotWaveForms
    for w = fs
        %Find the voltage across the resistor over time
        v(i+1,:) = eval(circdiff*R);
        %Plot that shit
        plot(t,v(i+1,:));
        %Axis range (x: (s),y: (V));
        axis([min(t) max(t) -10 10]); 
        %Lable that shit
        xlabel('Time (s)');
        ylabel('Voltage (v)');
        %Title displays the current frequency, and target frequency
        title(strcat('Voltage over Time RCL Circuit (f=', num2Str(w/(2*pi)), 'Hz, f_o=',num2str(sqrt(1/(L*C))/2/pi),'Hz, \Delta f=',num2Str(R/(L*2*pi)), 'Hz)'));


        %Make sure we actually get plotted
        drawnow;
        %save current frame
        frame = getframe(fh);
        %render frame as image
        im = frame2im(frame);
        [imind,cm] = rgb2ind(im,256);
        %Save the gif, appending each new frame to the gif 
        if i == 0;
            %if this is the first frame, save it to a new gif
            imwrite(imind,cm,video_filename,'gif', 'Loopcount',inf);
        else
            %for all the other frames, just append to the file
            imwrite(imind,cm,video_filename,'gif','WriteMode','append','DelayTime',1/gif_fps);
        end
        %So we know which frame we're on
        i = i + 1;
    end
end

%We don't need this anymore as I found an analytical solution
%Look for the amplitude of the output over various frequencies
%for i = fs
    %Poor mans' analyis: just look at the max value after some time has
    %passed, making this representative of the signal's asymptotic behavior
%    m(i) = abs(max(v(i,round((max(t)-5):.01:max(t)*100))));
%end
%Plot the frequency response

%Analytic solution to frequency response curve, compliments of the laplace
%transform (s= sig+w*i, where w is the frequency and i is the imaginary unit)
%sig is zero cause it's not attentuated (complex frequency is weird)
response = inline('(log((R.*w.*5.0e-1i)./(L.*(-w.^2+w_0.^2+(R.*w.*1i)./L))+(conj(R).*conj(w).*5.0e-1i)./(conj(L).*(conj(w).^2-conj(w_0).^2+(conj(R).*conj(w).*1i)./conj(L)))).*1.0e1)./log(1.0e1)');
%fundemental frequency
w_0 = sqrt(1/(L*C));
%plot the responses, axis in MHz
plot(fs/(2*pi)*10^-6,response(L,R,fs,w_0))
%plot((fs)./(2*pi),10*log10((real(m))/9));
axis([min(fs/(2*pi)*10^-6) max(fs/(2*pi)*10^-6) -7 0]);
xlabel('Frequency (MHz)');
ylabel('Gain (dB)');
title(strcat('Output Amplitude versus Signal Frequency (f_o=',num2str(sqrt(1/(L*C))/2/pi*10^-6,4),'MHz), \Delta f=',num2Str(R/(2*pi*L)*10^-6, 3), 'MHz )'));
%make sure it's drawn
drawnow;
frame = getframe(fh);
%save to image
im = frame2im(frame);
[imind,cm] = rgb2ind(im,256);
imwrite(imind,cm,'response.gif','gif', 'Loopcount',inf);

%Sweep across the FM spectrum, tuning to each frequency 
fRange = (87.5:.1:108)*10^6;
gif_fps = 12; %Framerate for our output
frequencySweep = true;
if frequencySweep
    for i = 1:length(fRange);
        %The capacitence for the current frequemcies
        C = 1/((2*pi*fRange(i))^2 * L);
        w_0 = sqrt(1/(L*C));
        plot(87.5:0.0001:108,response(L,R,(87.5:0.0001:108).*(2*pi*10^6),w_0))
        xlabel('Frequency (MHz)');
        ylabel('Gain (dB)');
        axis([87.5 108 -55 0]);
        title(strcat('Output Amplitude over FM Spectrum (f_o=',num2str(sqrt(1/(L*C))/2/pi*10^-6,4),'MHz \Delta f=',num2Str(R/(2*pi*L)*10^-6, 3), 'MHz )'));
       
        %Make sure we actually get plotted
        drawnow;
        %save current frame
        frame = getframe(fh);
        %render frame as image
        im = frame2im(frame);
        [imind,cm] = rgb2ind(im,256);
        %Save the gif, appending each new frame to the gif 
        if i == 1;
            %if this is the first frame, save it to a new gif
            imwrite(imind,cm,'sweep.gif','gif', 'Loopcount',inf);
        else
            %for all the other frames, just append to the file
            imwrite(imind,cm,'sweep.gif','gif','WriteMode','append','DelayTime',1/gif_fps);
        end
        %So we know which frame we're on
       
    end
end