function [statesDot] = lorenz(t,state,args)
% Lorenz Equations of Motion
x=state(1);
y=state(2);
z=state(3);
sigma=args(1);
rho=args(2);
beta=args(3);

xDot=sigma*(y-x);
yDot=(x*(rho-z)) - y;
zDot=(x*y) - (beta*z);
statesDot=[xDot;yDot;zDot];
end

