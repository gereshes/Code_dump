function [Xdot] = pendODE(t,X)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
x=X(1);
xDot=X(2);
xDotDot=-sin(x);
Xdot=[xDot,xDotDot]';
end

