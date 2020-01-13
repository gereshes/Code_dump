close all
clear all
clc

h=figure()
h.Color=[0,0,0]
h.Position=[300 137 813 788]%[4.5000   46.5000  813.0000  788.5000];
particles=10%00
samples=100

%axis tight manual % this ensures that getframe() returns a consistent size

args=[10,28,8/3];
holder=[];
for d=1:particles
    x0=randn(3,1);
    ts=[0,10];
	
	%Integrate the equations untill they arrive at the attractor
    [t,y]=ode45(@(tS,xS) lorenz(tS,xS,args),ts,x0);
    ts=[0,15];
	
	%Integrate the new inital conditions equations to show the attractor
    sol=ode45(@(tS,xS) lorenz(tS,xS,args),ts,y(end,:));
    ts2=linspace(0,15,10000);
    y=deval(sol,ts2)';
    holder=[holder;y];
    
    plot3(y(:,1),y(:,2),y(:,3),'LineWidth',.1)
    hold on
end

daspect([1,1,1])
axis([-30,30,-30,30,-10,60])
axis off

time=15
fps=30
frames=time*fps
viewVec=linspace(0,360,frames)%/4;
viewVec2=linspace(0,360,frames);
writerObj = VideoWriter('lorenzPan','MPEG-4');
writerObj.FrameRate = fps;
writerObj.Quality = 100;
open(writerObj);
for c=1:frames
	view([viewVec(c),120])
	drawnow 
	frame = getframe(h); 
	im = frame2im(frame); 
	[imind,cm] = rgb2ind(im,256); 

	writeVideo(writerObj, frame.cdata);

	c/frames
end
close(writerObj);