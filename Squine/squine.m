%%Not a particularly useful function. Gives the solution to a vary specific
%%case of a square before I had learned of the closed form.

function [ s ] = squine( th )
    for i = 1:length(th);
        t = mod(th(i), 2*pi);
        if (t >= 0 && t <= pi/4)
            s(i) = tan(t);
        elseif (t > pi/4 && t <= 3*pi/4)
            s(i) = 1;
        elseif(t > 3*pi/4 && t <= 5*pi/4)
            s(i) = -tan(t);
        elseif(t > 5*pi/4 && t <= 7*pi/4)
            s(i) = -1;
        elseif(t > 7*pi/4 && t <= 2*pi)
            s(i) = tan(t);
        end
    end
end

