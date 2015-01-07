%%More or less the exact same thing as the other script. Only difference is
%%the loop goes over the number of sides rather than rotating it.
%%Interesting to see it become more and more of a sine function. I didn't
%%comment the lines below as they are 100% analogous to the other script.

cd 'C:\Users\David\Documents\MATLAB\';
filename = 'sevolution.gif';
figure(8);
%n = 100;
t = 0:0.01:4*pi;
for n = 3:50
    subplot(1,2,1);
    phi = 0; polar(t, sec(asin(sin((t-phi)*n/2))*2/n));
    title(['n = ' num2str(n)]);
    subplot(1,2,2);
    phi = 0; plot(t, sec(asin(sin((t-phi)*n/2))*2/n).*sin(t));
    axis([0 max(t) -2 2]);
    title(['n = ' num2str(n)]);

    drawnow
    frame = getframe(8);
    im = frame2im(frame);
    [imind,cm] = rgb2ind(im,256);
    if n == 3;
        imwrite(imind,cm,filename,'gif', 'Loopcount',inf);
    else
        imwrite(imind,cm,filename,'gif','WriteMode','append','DelayTime',1/5);
    end    
end