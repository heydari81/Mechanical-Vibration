function f = bazeh2(t,y)
%In this function, the movement is when none of the wheels are on the bump
zg1 = 0;
zg2 = 0;
m1 = 40.5;
m2 = 45.4;
m3 = 700;
m4 = 80;
jxx = 2400;
kt1 = 200*1000;
kt2 = 200*1000;
ks1 = 24*1000;
ks2 = 19*1000;
ks3 = 5*1000;
l1 = 1.25;
l2 = 1.51;
l3 = .5;
cs1 = 1.6*1000;
cs2 = 1.8*1000;
cs3 = .72*1000;
x = .3*sin(100*pi*t);
zg1=0;
zg2=0;
%Numerical solution of the equations of motion
f = zeros(10,1);
f(1) = y(2);
f(2) = (-cs1*y(2) + cs1*(y(6)-l1*y(8))-ks1*y(1) - kt1*y(1) + ks1*y(5) - ks1*l1*y(7))/m1+zg1*kt2;
f(3) = y(4);
f(4) = (-cs2*y(4)+cs2*(y(6)+l2*y(8))-ks2*y(3)-kt2*y(3)+ks1*(y(5)+l2*y(7)))/m2+zg2*kt2;
f(5) = y(6);
f(6) = (-cs1*(y(6)-l1*y(8)-y(2))-ks1*(y(5)-l1*y(7)-y(1))-cs2*(y(6)-l2*y(8)-y(4))-ks3*(y(5)+l2*y(7)-y(3))+ks3*(y(9)-y(5)+l3*y(7))+cs3*(y(10)-y(6)+l3*y(8)))/m3;
f(7) = y(8);
f(8) = (-ks2*l2*(y(5)+l2*y(7)-y(3))-cs2*l2*(y(6)+l2*y(8)-y(4))+ks1*l1*(y(5)-l1*y(7)-y(1))+cs1*l1*(y(6)-l1*y(8)-y(2))-ks3*l3*(y(9)-y(5)+l3*y(7))-cs3*l3*(y(10)-y(6)+l3*y(8)))/jxx;
f(9) = y(10);
f(10) = (-cs3*(y(10)-y(6)+l3*y(8))-ks3*(y(9)-y(5)+l3*y(7)))/m4;


end