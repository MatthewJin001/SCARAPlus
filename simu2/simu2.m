clc;clear;

num=linspace(0,1,100);
t = 4*pi*num;
A = 40;
w = 1;
sita = 0;
for ii = 1:length(t)
    x(ii) = A *cos(t(ii))+300;
    y(ii) = A *sin(t(ii))-300;
    A = A+ 0.4;
end
z = -100+num*100;
% figure;
% plot3(x,y,z,'r*');
% title('螺旋线');
% xlabel('x axis');
% ylabel('y axis');
% zlabel('z axis');
% grid on;
% axis equal


%把x，y，z转换到相机坐标系下
Tcb_x=-3.574;
Tcb_y=-324.292;
Tcb_z=151.355;
Tcb_roll=145.935;
Tcb_pitch=2.673;
Tcb_yaw=90.350;

bRc=eular2dcm(Tcb_roll*pi/180,Tcb_pitch*pi/180,Tcb_yaw*pi/180);
btc=[Tcb_x;Tcb_y;Tcb_z];


xc=x;
yc=y;
zc=z;

for i=1:length(x)
    temp=bRc'*[x(i);y(i);z(i)]-bRc'*btc;
    xc(i)=temp(1);
    yc(i)=temp(2);
    zc(i)=temp(3);
end

%现在有xc，yc，zc

p1=[];
p2=[];
p3=[];
v1=[];
v2=[];
v3=[];
figure
for i=1:2:length(x)-1
plot3([xc(i),xc(i+1)],[yc(i),yc(i+1)],[zc(i),zc(i+1)]);

%%
axis equal
ax = gca;
A = [[xc(i);yc(i);zc(i)],[xc(i+1);yc(i+1);zc(i+1)]];
r = 2;
co = 'r';
eco = 'r';
PlotCyl(ax, A, r,co,eco);


%%



hold on;

p1=[p1;xc(i)];
p2=[p2;yc(i)];
p3=[p3;zc(i)];

xielv=[xc(i+1)-xc(i),yc(i+1)-yc(i),zc(i+1)-zc(i)];
xielv=xielv/norm(xielv);
v1=[v1;xielv(1)];
v2=[v2;xielv(2)];
v3=[v3;xielv(3)];

end

% 设置角度和光照
ax.View = [-2.012659955383760e+02,11.179361664606382];
% axis off
camlight
lighting gouraud
xlabel('X(mm)')
ylabel('Y(mm)')
zlabel('Z(mm)')

% pose = rigid3d(eye(3),[0,0,0]);
% cam = plotCamera('AbsolutePose',pose,'size',20);





LW=1;
figure;
subplot(5,2,1)
plot(v1,'LineWidth',LW);
xticklabels({})
title('e_X^T\cdot{^Cv}')

subplot(5,2,3)
plot(v2,'LineWidth',LW);
title('e_Y^T\cdot{^Cv}')



subplot(5,2,5)
plot(p1,'LineWidth',LW);
xticklabels({})
title('e_X^T\cdot{^Cp}/mm')
hold on;

subplot(5,2,7)
plot(p2,'LineWidth',LW);
xticklabels({})
title('e_Y^T\cdot{^Cp}/mm')

subplot(5,2,9)
plot(p3,'LineWidth',LW);
xticklabels({})
title('e_Z^T\cdot{^Cp}/mm')
xlabel('Cylinder number')



thetap=-5/180*pi;
dp=-50;
l=-150;

sita=zeros(length(v1),1);
sita5=zeros(length(v1),1);
beta1=zeros(length(v1),1);
beta2=zeros(length(v1),1);
beta3=zeros(length(v1),1);
for i=1:length(v1)
v=[v1(i);v2(i);v3(i)];
p=[p1(i);p2(i);p3(i)];
ex=[1;0;0];ey=[0;1;0];ez=[0;0;1];
sita5(i)=asin(ez'*bRc*v);
sita(i)=atan2(ey'*bRc*v/cos(sita5(i)),ex'*bRc*v/cos(sita5(i)));

temp=bRc*p+btc-[-l*cos(sita(i))*sin(sita5(i));-l*sin(sita(i))*sin(sita5(i));dp+l*cos(sita5(i))];
beta1(i)=temp(1);
beta2(i)=temp(2);
beta3(i)=temp(3);

end

subplot(5,2,2)
plot(beta1,'LineWidth',LW);
xticklabels({})
title('e_{X}^T\cdot\beta/mm')

subplot(5,2,4)
plot(beta2,'LineWidth',LW);
xticklabels({})
title('e_{Y}^T\cdot\beta/mm')

subplot(5,2,6)
plot(beta3,'LineWidth',LW);
title('e_{Z}^T\cdot\beta/mm')


subplot(5,2,8)
plot(sita*57.3,'LineWidth',LW);
xticklabels({})
title('\theta/\circ')

subplot(5,2,10)
plot(sita5*57.3,'LineWidth',LW);
xticklabels({})
title('\theta_5/\circ')
xlabel('Cylinder number')











