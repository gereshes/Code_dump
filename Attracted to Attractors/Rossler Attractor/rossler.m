function [statesDot] = rossler(t,state,args)
% Rossler Equations of Motion
x=state(1);
y=state(2);
z=state(3);
a=args(1);
b=args(2);
c=args(3);

xDot=-y-z;
yDot=x+(a*y);
zDot=b+(z*(x-c));
statesDot=[xDot;yDot;zDot];
end

