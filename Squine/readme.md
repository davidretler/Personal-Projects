"Squine" — Polynomial analogue of sine
=========

This directory shows off a script I made to graph animations of what recreational mathematicians have been referring to as "squine". Essentially, squine(n, x) is the y-component of a regular n-gon centred around the origin with perpendicular distance from the origin being on. That is, if you extended a straight line from the origin at an angle x, it would intersect a regular n-gon at y = squine(n, x). More rigorously, we can define squine(n, x, p) where p is adjusted to rotate the polygon, which changes the overall shape. A closed for is given as squine(n, x, p) = sec(2/n * asin(sin(n/2 * (x - p)))*sin(x). A few animations were rendered using MATLAB for demonstration. 


How to Use
---------

I made a few different scripts to do a few different things, and I recommend playing around with all of them. The important one is [**squine_script.m**](squine_script.m). Instructions lie in the comments. 



Gallery 
--------

![](trine.gif?raw=true)
![](squine.gif?raw=true)
![](pine.gif?raw=true)
![](6-polysine.gif?raw=true)
![](10-polysine.gif?raw=true)
![](100-polysine.gif?raw=true)
![](s2.gif?raw=true)
![](sevolution.gif?raw=true)