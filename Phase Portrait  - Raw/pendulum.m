close all
clear all
clc

%%
g=1;
l=1;
entries=15;
entriesX=21;
entriesY=21;
theta=linspace(-2*pi,2*pi,entriesX);
thetaDot=linspace(-3,3,entriesY);
h=figure()
%h.Position=[1.80000000000000,650.600000000000,1595.20000000000,420.000000000000];
h.Position=[1,652.200000000000,915.200000000000,420];
h.Color=[1,1,1];
hold on
vHolder=[];
%subplot(1,3,2)
for c=1:entriesY
    x=theta;
    y=ones(1,entriesX).*thetaDot(c);
    u=y;
    v=-(g/l)*sin(x);
    quiver(x,y,u,v,.1,'b')
    c/entriesY
end
axis([theta(1),theta(end),thetaDot(1),thetaDot(end)])
daspect([1,1,1])
title('Phase Portrait - Pendulum')
xlabel('\theta')
ylabel('$\dot{\theta}$','interpreter','LaTex')


icP=[-3*pi,eps]
icM=[3*pi,-eps]
%scatter([-pi,pi],[0,0],25,'k','filled')
%icP=[-2*pi,2.001]
%icM=[2*pi,-2.001]
ts=[0,300]

[t,yP]=ode45(@pendODE,ts,icP)
%plot(yP(:,1),yP(:,2),'k','LineWidth',2)
[t,yM]=ode45(@pendODE,ts,icM)
%plot(yM(:,1),yM(:,2),'k','LineWidth',2)
ts=[0,6.4321]

icI=[0,.7]
icO=[-2*pi,2.5]


fps=20;
time=ts(end);
frames=fps*time;
ts=linspace(0,ts(end),frames);


solI=ode45(@pendODE,ts,icI);
yI=deval(solI,ts)';
I=plot(yI(:,1),yI(:,2),'r','LineWidth',1)
solO=ode45(@pendODE,ts,icO);
yO=deval(solO,ts)';
O=plot(yO(:,1),yO(:,2),'b','LineWidth',1)
SI=scatter(0,0);
SO=scatter(0,0);
SIP=scatter(0,0);
SOP=scatter(0,0);
IP=scatter(0,0);
OP=scatter(0,0);
% find(yO(:,1)>2*pi)

axis tight manual % this ensures that getframe() returns a consistent size
filename = 'C:\Users\AriRubinDSKTP\Box Sync\Gereshes\Content\Dynamics\Phase portrait\testAnimated.gif';
for n = 1:frames
    % Draw plot for y = x.^n
    %subplot(1,3,1)
    %delete(IP)
    %delete(SIP)
    %IP=plot([0,l*sin(yI(n,1))],[0,-l*cos(yI(n,1))],'r');
    %hold on
    %SIP=scatter(l*sin(yI(n,1)),-l*cos(yI(n,1)),'r','filled');
    %axis([-1,1,-1,1])
    %daspect([.5,.5,1])
    %title('Inside')
    
    
    %subplot(1,3,3)
    %hold on
    %delete(OP)
    %delete(SOP)
    %OP=plot([0,l*sin(yO(n,1))],[0,-l*cos(yO(n,1))],'b');
    %SOP=scatter(l*sin(yO(n,1)),-l*cos(yO(n,1)),'b','filled');
    %axis([-1,1,-1,1])
    %daspect([1,1,1])
    
    %title('Outside')
    
    %subplot(1,3,2)
    hold on
    delete(O)
    delete(I)
    delete(SO)
    delete(SI)
    
    axis([theta(1),theta(end),thetaDot(1),thetaDot(end)])
    daspect([1,1,1])
    hold on
    for c=1:entriesY
        x=theta;
        y=ones(1,entriesX).*thetaDot(c);
        u=y;
        v=-(g/l)*sin(x);
        quiver(x,y,u,v,.1,'b')
        %c/entriesY
    end
    title('Phase Portrait - Pendulum')
    xlabel('\theta')
    ylabel('$\dot{\theta}$', 'Interpreter', 'latex')
    I=plot(yI(1:n,1),yI(1:n,2),'r','LineWidth',1);
    O=plot(yO(1:n,1),yO(1:n,2),'b','LineWidth',1);
    SO=scatter(yO(n,1),yO(n,2),'b','filled');
    SI=scatter(yI(n,1),yI(n,2),'r','filled');
    drawnow
      % Capture the plot as an image 
      frame = getframe(h); 
      im = frame2im(frame); 
      [imind,cm] = rgb2ind(im,256); 
      % Write to the GIF File 
      if n == 1 
          imwrite(imind,cm,filename,'gif', 'Loopcount',inf,'DelayTime',1/fps); 
      else 
          imwrite(imind,cm,filename,'gif','WriteMode','append','DelayTime',1/fps); 
      end 
end