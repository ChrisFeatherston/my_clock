%% Clean up workspace
close all; 
clear all;
clc

%% Define coordinate for clockface
x=0;
y=0;
r=10;
axis off
hold on;

%% Draw clockface
f=figure(1); 
th = 0:pi/50:2*pi; 
xunit = r * cos(th) + x;
yunit = r * sin(th) + y;
h = plot(xunit,yunit,'k');
r=8.5; 
num=1; 
tb = uicontrol(f, 'Style', 'togglebutton', 'String', 'Kill');
pause(0.5)

%% Add the numbers
for th = pi/6: pi/6: 2*pi
 ytemp = r * cos(th);
 xtemp = r * sin(th); 
 text(xtemp,ytemp,num2str(num));
 num = num+1;
 pause(0.25)
end

%% Get current time
while(1)
c = clock; %'clock' has information: year, month, day, hour, minute, second.
c = c(1,4:6); %keep only time
min =c(1,2); 
sec=c(1,3);
if (c(1,1)>12) %check for am/pm as 'clock' is in 24h time  
   hr = c(1,1)-12; %if pm convert to 12h time
else
    hr = c(1,1);
end

%% Find where to draw the hands
DigitalTime = text(9,-10.65,strcat(num2str(sprintf('%02d',hr)),':',num2str(sprintf('%02d',min)),':',num2str(sprintf('%02d',ceil(sec)))));
min1 = ceil(min/12); 
theta = (hr*pi)/6 + (min1*pi)/30;
hold on;
ytemp = 3 * cos(theta); 
Y = [0 ytemp]; 
xtemp = 3 * sin(theta); 
X = [0 xtemp];
p=plot(X,Y,'k'); %draw hour hand
hold on;
theta1 = (min*pi)/30;
ytemp1 = 5 * cos(theta1); 
Y1 = [0 ytemp1]; 
xtemp1 = 5 * sin(theta1); 
X1 = [0 xtemp1];
p1=plot(X1,Y1,'k'); %draw minute hand
theta2 = (sec*pi)/30;
ytemp2 = 7 * cos(theta2); 
Y2 = [0 ytemp2]; 
xtemp2 = 7 * sin(theta2); 
X2 = [0 xtemp2];
p2=plot(X2,Y2); %draw second hand
pause(1);
if (get(tb, 'Value')==1); break; end
delete(p2);
delete(p1);
delete(p);
delete(DigitalTime);
end