%% Main script. Generate the squine for a rotating n-gon 
%  note: you can change the window size to adjust the size of the figure.
%  Simply run the script again after doing so


%where to save the file
cd 'C:\Users\David\Documents\MATLAB\';
%what to call the file
filename = 'sn.gif';
%figure identifier
figure(8);
%number of sides (non-integers give interesting results)
n = 10;
%plot on [0 10*pi]
t = 0:0.01:10*pi;
%loop over rotation
for i = 0:2 * pi/n / 100:2 * pi/n;
    subplot(1,2,1);
    %closed form for polar polynomial used here
    phi = i; polar(t, sec(asin(sin((t-phi)*n/2))*2/n));
    %you can change this title
    title(['Square, \theta = '  num2str(i * 180/pi, 3) '^o']);
    subplot(1,2,2);
    %y-component of closed form by *sin(t)
    phi = i; plot(t, sec(asin(sin((t-phi)*n/2))*2/n).*sin(t));
    %...and this axis range
    axis([0 max(t) -3 3]);
    %...and this title
    title(['Squine \theta = '  num2str(i * 180/pi, 3) '^o']);
    
    
    %I didn't write this part... it just saves the frames to a gif
    drawnow
    frame = getframe(8);
    im = frame2im(frame);
    [imind,cm] = rgb2ind(im,256);
    if i == 0;
        imwrite(imind,cm,filename,'gif', 'Loopcount',inf);
    else
        %change delay here adjust gif speed
        imwrite(imind,cm,filename,'gif','WriteMode','append','DelayTime',1/10);
    end
end