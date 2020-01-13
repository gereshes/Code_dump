function [statesDot] = TCSA(t,state,b)
% Thomas Cuclic Symmetric Attractor Equations of Motion
x=state(1);
y=state(2);
z=state(3);
xDot=sin(y)-(b*x);
yDot=sin(z)-(b*y);
zDot=sin(x)-(b*z);
statesDot=[xDot;yDot;zDot];
end

