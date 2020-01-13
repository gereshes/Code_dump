close all
clear all
clc

h=figure()
h.Color=[0,0,0]
h.Position=[4.5000   46.5000  813.0000  788.5000];
particles=100
samples=100
bVec=linspace(.1,.4,samples)
%axis tight manual % this ensures that getframe() returns a consistent size

b=.2
upperBand=[];
lowerBand=[];

for d=1:particles
    x0=randn(3,1);
    ts=[0,40];
	%Integrate the equations untill they arrive at the attractor
    [t,y]=ode45(@(tS,xS) TCSA(tS,xS,b),ts,x0);
    ts=[0,200];
	%Integrate the new inital conditions equations to show the attractor
    [t,y]=ode45(@(tS,xS) TCSA(tS,xS,b),ts,y(end,:));
    
	
    if(sum(x0)>0)
        upperBand=[upperBand;y];
    else
        lowerBand=[lowerBand;y];
    end

end


%% Create the visualization
scatter3(upperBand(:,1),upperBand(:,2),upperBand(:,3),.1,'r')
hold on
scatter3(lowerBand(:,1),lowerBand(:,2),lowerBand(:,3),.1,'g')
daspect([1,1,1])
grid minor
grid on
axis off
time=15
fps=30
frames=time*fps
viewVec=linspace(0,360,frames);
writerObj = VideoWriter('myVideoHigh','MPEG-4');
writerObj.FrameRate = fps;
writerObj.Quality = 75;
open(writerObj);
for c=1:frames
	view([viewVec(c),145])
	drawnow 
	% Capture the plot as an image 
	frame = getframe(h); 
	im = frame2im(frame); 
	[imind,cm] = rgb2ind(im,256); 
	writeVideo(writerObj, frame.cdata);

	c/frames
end
close(writerObj);
  
