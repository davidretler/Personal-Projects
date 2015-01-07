%%Derivative of the squine function, at least the specific case found
%%before discovering the closed form.

function [ s ] = Dsquine( t )
    t = mod(t, 2*pi);
    if (t >= 0 && t <= pi/4)
        s = sec(t)*sec(t);
    elseif (t > pi/4 && t <= 3*pi/4)
        s = 0;
    elseif(t > 3*pi/4 && t <= 5*pi/4)
        s = -sec(t)*sec(t);
    elseif(t > 5*pi/4 && t <= 7*pi/4)
        s = 0;
    elseif(t > 7*pi/4 && t <= 2*pi)
        s = sec(t)*sec(t);
    end
end

