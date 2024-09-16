%Matlab 5-DOF Vehicle Vibration created by MohammadReza Heydari 9926053
clc
clear
disp(['This code will solve the questions of the vibration project' ...
    ' (five degrees of freedom suspension system) for you.']);
disp('The first question');
disp('Calculate the natural frequencies and draw the mode shapes.');
disp('The second question');
disp(['Assume that the velocity of vehicle is 80 km/h and constant.' ...
    'It passes over a speed bump with the height and width of 30 cm and 50 cm,' ...
    'respectively. Please model this bump. Solve the dynamic model of the vehicle and draw the displacement,' ...
    'velocity and acceleration curves of the passenger for a certain time' ...
    'that covers after the rear wheels pass the bump as well']);
disp('The third question');
disp('Assume that the vehicle is passing over a wavy road with the following equation: y=.1sin(100pi*x)');
disp('Hypothetically, we have considered the speed of the car as ninety kilometers per hour');
while(1)
    edame = input('for countinue type 1 and for stop type 0:');
    if edame == 0
        break
    end
    N_q = input('Which question should I solve?: ');
    
switch N_q
    case 1
%In this case, the question data is entered and the mode 
%shapes are plotted and the natural frequencies are calculated.
m1 = 40.5;
m2 = 45.4;
m3 = 700;
m4 = 80;
jxx = 2400;
M=[m1 0 0 0 0;
   0 m2 0 0 0;
   0 0 m3 0 0;
   0 0 0 jxx 0;
   0 0 0 0 m4];
kt1 = 200*1000;
kt2 = 200*1000;
ks1 = 24*1000;
ks2 = 19*1000;
ks3 = 5*1000;
l1 = 1.25;
l2 = 1.51;
l3 = .5;
I = [1 0 0 0 0;
    0 1 0 0 0;
    0 0 1 0 0;
    0 0 0 1 0;
    0 0 0 0 1];
K=[ks1+kt1 0 -ks1 ks1*l1 0;
    0 kt1+ks2 -ks2  -ks2*l2 0;
    -ks1 -ks2 ks1+ks2+ks3 -ks1*l1+ks2*l2-ks3*l3 -ks3;
    ks1*l1 -ks2*l2 -ks1*l1+ks2*l2-ks3*l3 -ks1*l1*l1+ks2*l2*l2-ks3*l3*l3 ks3*l3;
    0 0 -ks3 ks3*l3 ks3];
K_hat = M^(-.5)*K*M^(-.5);

[P,LANDA]= eig(K_hat);
landa1 = LANDA(1,1);
landa2 = LANDA(2,2);
landa3 = LANDA(3,3);
landa4 = LANDA(4,4);
landa5 = LANDA(5,5);
modeshape1= transpose(P(:,1));
modeshape2= transpose(P(:,2));
modeshape3= transpose(P(:,3));
modeshape4= transpose(P(:,4));
modeshape5= transpose(P(:,5));
%drawing modshapes
 mod = [1,2,3,4,5];
 figure
 subplot(2,3,1);
 plot(mod,modeshape1);
 title(subplot(2,3,1),'modeshape1')
 subplot(2,3,2);
 plot(mod,modeshape2);
 title(subplot(2,3,2),'modeshape2');
 subplot(2,3,3);
 plot(mod,modeshape3);
  title(subplot(2,3,3),'modeshape3');
 subplot(2,3,4);
 plot(mod,modeshape4);
  title(subplot(2,3,4),'modeshape4');
 subplot(2,3,5);
 plot(mod,modeshape5);
  title(subplot(2,3,5),'modeshape5');
  %calculate w
 W  = LANDA^.5;
 disp(W);
    case 2
%In this case, the movement of the car over the bump is analyzed.
V = 80/3.6; % m/s
L= 50e-2;
l1 = 1.25;
l2 = 1.51;
l = l1+l2;
TPB1=50e-2/V ; %Time to pass the bump wheel 1
y0=[0;0;0;0;0;0;0;0;0;0];
tspan = [0:.0001:TPB1];
[t1,y1] = ode45('bazeh1',tspan,y0);
TPB2 = TPB1+l/V ;%The time the car passes over the bump
tspan = [TPB1:.0001:TPB2];
a = size(y1);
%In each step, the last answer is considered as the initial condition of the next step.
y0=y1(a(1,1),:);
[t2,y2] = ode45('bazeh2',tspan,y0);
TPB3 = TPB2+TPB1 ; %Time to pass the bump wheel 2
tspan = [TPB2:.0001:TPB3];
a = size(y2);
y0=y2(a(1,1),:);
 [t3,y3] = ode45('bazeh3',tspan,y0);
 tspan = [TPB3:.0001:3];
 a = size(y3);
 y0=y3(a(1,1),:);
 [t4,y4] = ode45('bazeh2',tspan,y0);
 figure
 %Drawing a diagram X-time for Passenger
 subplot(1,2,1);
 plot(t1,y1(:,9),t2,y2(:,9),t3,y3(:,9),t4,y4(:,9));
 title(subplot(1,2,1),'X Passenger');
 ylabel(subplot(1,2,1),'X');
 xlabel(subplot(1,2,1),'time');
 %Drawing a diagram V-time for Passenger
 subplot(1,2,2);
 plot(t1,y1(:,10),t2,y2(:,10),t3,y3(:,10),t4,y4(:,10));
 title(subplot(1,2,2),'V Passenger');
 ylabel(subplot(1,2,2),'V');
 xlabel(subplot(1,2,2),'time');
 disp('Would you like to see the location and speed of the remaining degrees of freedom?')
 N_q1 = input('Enter 1 if you wish: ');
 if N_q1 == 1
     %Drawing diagrams X-time for all degrees of freedom
    figure
    subplot(2,3,1);
    plot(t1,y1(:,1),t2,y2(:,1),t3,y3(:,1),t4,y4(:,1));
    subplot(2,3,2);
    plot(t1,y1(:,3),t2,y2(:,3),t3,y3(:,3),t4,y4(:,3));
    subplot(2,3,3);
    plot(t1,y1(:,5),t2,y2(:,5),t3,y3(:,5),t4,y4(:,5));
    subplot(2,3,4);
    plot(t1,y1(:,7),t2,y2(:,7),t3,y3(:,7),t4,y4(:,7));
    subplot(2,3,5);
    plot(t1,y1(:,9),t2,y2(:,9),t3,y3(:,9),t4,y4(:,9));
    figure
    %Drawing diagrams V-time for all degrees of freedom
     subplot(2,3,1);
    plot(t1,y1(:,2),t2,y2(:,2),t3,y3(:,2),t4,y4(:,2));
    subplot(2,3,2);
    plot(t1,y1(:,4),t2,y2(:,4),t3,y3(:,4),t4,y4(:,4));
    subplot(2,3,3);
    plot(t1,y1(:,6),t2,y2(:,6),t3,y3(:,6),t4,y4(:,6));
    subplot(2,3,4);
    plot(t1,y1(:,8),t2,y2(:,8),t3,y3(:,8),t4,y4(:,8));
    subplot(2,3,5);
    plot(t1,y1(:,10),t2,y2(:,10),t3,y3(:,10),t4,y4(:,10));
 end
    case 3
y0=[0;0;0;0;0;0;0;0;0;0];
tspan = [0:.01:5];
[t1,y1] = ode45('halc',tspan,y0);
figure
 %Drawing diagrams X-time for all degrees of freedom
    subplot(2,3,1);
    plot(t1,y1(:,1));
   ylabel(subplot(2,3,1),'X m1');
   xlabel(subplot(2,3,1),'time');
    subplot(2,3,2);
    plot(t1,y1(:,3));
    ylabel(subplot(2,3,2),'X m2');
   xlabel(subplot(2,3,2),'time');
    subplot(2,3,3);
    plot(t1,y1(:,5));
    ylabel(subplot(2,3,3),'X m3');
   xlabel(subplot(2,3,3),'time');
    subplot(2,3,4);
    plot(t1,y1(:,7));
    ylabel(subplot(2,3,4),'Rad theta');
   xlabel(subplot(2,3,4),'time');
    subplot(2,3,5);
    plot(t1,y1(:,9));
    ylabel(subplot(2,3,5),'X m4(Passenger)');
   xlabel(subplot(2,3,5),'time');
    figure
     %Drawing diagrams V-time for all degrees of freedom
    subplot(2,3,1);
    plot(t1,y1(:,2));
    ylabel(subplot(2,3,1),'V m1');
    xlabel(subplot(2,3,1),'time');
    subplot(2,3,2);
    plot(t1,y1(:,4));
    ylabel(subplot(2,3,2),'V m2');
    xlabel(subplot(2,3,2),'time');
    subplot(2,3,3);
    plot(t1,y1(:,6));
    ylabel(subplot(2,3,3),'V m3');
    xlabel(subplot(2,3,3),'time');
    subplot(2,3,4);
    plot(t1,y1(:,8));
    ylabel(subplot(2,3,4),'Rad/s theta');
    xlabel(subplot(2,3,4),'time');
    subplot(2,3,5);
    plot(t1,y1(:,10));
    ylabel(subplot(2,3,5),'V m4(Passenger)');
    xlabel(subplot(2,3,5),'time');
    figure
    subplot(1,2,1);
    plot(t1,y1(:,9));
    ylabel(subplot(1,2,1),'X m4(Passenger)');
    xlabel(subplot(1,2,1),'time');
   subplot(1,2,2);
    plot(t1,y1(:,10));
    ylabel(subplot(1,2,2),'X m4(Passenger)');
    xlabel(subplot(1,2,2),'time');
    case 4
        clc;
        clear;
        disp('Which parameter to change? Speed(V) ​​or bump width(BW)');
        Parameter = input('Enter 3 FOR V or 4 FOR BW : ' );
        switch Parameter
            case 3
for V = 5:20:65
sorat = V;
L= 50e-2;
l1 = 1.25;
l2 = 1.51;
l = l1+l2;
switch sorat
    case 5
        rang = 'red';
    case 25
        rang = 'blue';
    case 45
        rang = 'green';
    case 65
        rang = 'black';
end
TPB1=50e-2/V ; %Time to pass the bump wheel 1
y0=[0;0;0;0;0;0;0;0;0;0];
tspan = [0:.0001:TPB1];
[t1,y1] = ode45('bazeh1solutione',tspan,y0);
TPB2 = TPB1+l/V ;%The time the car passes over the bump
tspan = [TPB1:.0001:TPB2];
a = size(y1);
%In each step, the last answer is considered as the initial condition of the next step.
y0=y1(a(1,1),:);
[t2,y2] = ode45('bazeh2solutione',tspan,y0);
TPB3 = TPB2+TPB1 ; %Time to pass the bump wheel 2
tspan = [TPB2:.0001:TPB3];
a = size(y2);
y0=y2(a(1,1),:);
 [t3,y3] = ode45('bazeh3solutione',tspan,y0);
 tspan = [TPB3:.0001:3];
 a = size(y3);
 y0=y3(a(1,1),:);
 [t4,y4] = ode45('bazeh2solutione',tspan,y0);
 plot(t1,y1(:,9),t2,y2(:,9),t3,y3(:,9),t4,y4(:,9),'color',rang);
 title(subplot(1,1,1),'X Passenger');
 ylabel(subplot(1,1,1),'X');
 xlabel(subplot(1,1,1),'time');
 hold on
end

case 4
for BW = .4:.2:1 
Length = BW;
l1 = 1.25;
l2 = 1.51;
l = l1+l2;
V = 20;
switch BW
    case .4
        rang = 'red';
    case .6
        rang = 'blue';
    case .8
        rang = 'green';
    case 1
        rang = 'black';
end
TPB1=BW/V ; %Time to pass the bump wheel 1
y0=[0;0;0;0;0;0;0;0;0;0];
tspan = [0:.0001:TPB1];
[t1,y1] = ode45('bazeh1solutione',tspan,y0);
TPB2 = TPB1+l/V ;%The time the car passes over the bump
tspan = [TPB1:.0001:TPB2];
a = size(y1);
%In each step, the last answer is considered as the initial condition of the next step.
y0=y1(a(1,1),:);
[t2,y2] = ode45('bazeh2solutione',tspan,y0);
TPB3 = TPB2+TPB1 ; %Time to pass the bump wheel 2
tspan = [TPB2:.0001:TPB3];
a = size(y2);
y0=y2(a(1,1),:);
 [t3,y3] = ode45('bazeh3solutione',tspan,y0);
 tspan = [TPB3:.0001:3];
 a = size(y3);
 y0=y3(a(1,1),:);
 [t4,y4] = ode45('bazeh2solutione',tspan,y0);
 %rang = 'red';
 plot(t1,y1(:,9),t2,y2(:,9),t3,y3(:,9),t4,y4(:,9),'color',rang);
 title(subplot(1,1,1),'X Passenger');
 ylabel(subplot(1,1,1),'X');
 xlabel(subplot(1,1,1),'time');
 hold on
end
end
end
end
