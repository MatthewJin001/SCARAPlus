clc;clear
alpha0=0;a0=0;theta1=0;d1=200;
alpha1=0;a1=400;theta2=0;d2=0;
alpha2=0;a2=300;theta3=0;d3=0;
alpha3=0;a3=0;theta4=0;d4=0;

thetap=-5/180*pi;
dp=-50;
alpha4=pi/2;a4=0;theta5=0;d5=0;

l=-150;
T5g=[eye(3),[0;l;0];0,0,0,1];

T01 = dhKinematics(alpha0,a0,theta1,d1);
T12 = dhKinematics(alpha1,a1,theta2,d2);
T23 = dhKinematics(alpha2,a2,theta3,d3);
T34 = dhKinematics(alpha3,a3,theta4,d4);

Tthetap = dhKinematics(0,0,thetap,0);
Tdp=dhKinematics(0,0,0,dp);

T45 = dhKinematics(alpha4,a4,theta5,d5);

Tbg=(T01*T12*T23*T34)*(Tthetap*Tdp)*(T45)*(T5g);

lim1=[-150,150]/180*pi;
lim2=[-150,150]/180*pi;
lim3=[-200,0];
lim4=[-180,180]/180*pi;
lim5=[-45,45]/180*pi;

num=600; 
L1=zeros(3,num); 
L2=zeros(3,num);

for i=1:num
    theta1=lim1(1)+rand*(lim1(2)-lim1(1));
    theta2=lim2(1)+rand*(lim2(2)-lim2(1));
    d3=lim3(1)+rand*(lim3(2)-lim3(1));
    theta4=lim4(1)+rand*(lim4(2)-lim4(1));
    theta5=lim5(1)+rand*(lim5(2)-lim5(1));


    T01 = dhKinematics(alpha0,a0,theta1,d1);
    T12 = dhKinematics(alpha1,a1,theta2,d2);
    T23 = dhKinematics(alpha2,a2,theta3,d3);
    T34 = dhKinematics(alpha3,a3,theta4,d4);

    Tthetap = dhKinematics(0,0,thetap,0);
    Tdp=dhKinematics(0,0,0,dp);

    T45 = dhKinematics(alpha4,a4,theta5,d5);

    Tbg=(T01*T12*T23*T34)*(Tthetap*Tdp)*(T45)*(T5g);
    
        
    L1(:,i)=Tbg(1:3,1:3)*[30;0;0]+Tbg(1:3,4);
    L2(:,i)=Tbg(1:3,1:3)*[-30;0;0]+Tbg(1:3,4);

end

figure;
for i=1:num
plot3([L1(1,i),L2(1,i)],[L1(2,i),L2(2,i)],[L1(3,i),L2(3,i)],'LineWidth',1);
hold on;
axis equal;
end
xlabel('X(mm)')
ylabel('Y(mm)')
zlabel('Z(mm)')
box on;
xyzplotT(eye(4),200);

%box range
xsmall=250;
xbig=450;
ysmall=-350;
ybig=-50;
zsmall=-150;
zbig=50;

t = [xsmall ysmall zsmall;
    xbig ysmall zsmall;
    xbig ybig zsmall;
    xsmall ybig zsmall;
    xsmall ysmall zbig;
    xbig ysmall zbig;
    xbig ybig zbig;
    xsmall ybig zbig;];
t1 = [1 2 3 4 1 5 6 2 6 7 3 4 8 5 8 7];
i1 = 1;
x = [];
y = [];
z = [];

for i=t1
   x(i1) = t(i,1);
   y(i1) = t(i,2);
   z(i1) = t(i,3);
   i1 = i1+1;
end
plot3(x,y,z,'-r',LineWidth=1.3);
xlabel('x');ylabel('y');zlabel('z');
view([-12.7 49.6]);
% -37.5,30

figure;
for i=1:num
    zeros1=(xsmall<L1(1,i))&&(xbig>L1(1,i))&&(ysmall<L1(2,i))&&(ybig>L1(2,i))&&(zsmall<L1(3,i))&&(zbig>L1(3,i));
    zeros2=(xsmall<L2(1,i))&&(xbig>L2(1,i))&&(ysmall<L2(2,i))&&(ybig>L2(2,i))&&(zsmall<L2(3,i))&&(zbig>L2(3,i));
    if zeros1 && zeros2
        plot3([L1(1,i),L2(1,i)],[L1(2,i),L2(2,i)],[L1(3,i),L2(3,i)],'LineWidth',1);
        hold on;
    end
end
axis equal;
xlim([xsmall,xbig]);
ylim([ysmall,ybig]);
zlim([zsmall,zbig]);
daspect([1,1,3]);


figure;
theta1=lim1(1)+rand*(lim1(2)-lim1(1))
theta2=lim2(1)+rand*(lim2(2)-lim2(1))
d3=lim3(1)+rand*(lim3(2)-lim3(1))
theta4=lim4(1)+rand*(lim4(2)-lim4(1))
theta5=lim5(1)+rand*(lim5(2)-lim5(1))

% theta1=-1.25;
% theta2=1.07;
% d3=-101.20;
% theta4=-1.29;
% theta5=-0.87;

theta1=-2.46;%-141
theta2=-1.55;%-89
d3=-167.10;%-167
theta4=-1.85;%-106
theta5=-0.29;%-16

T01 = dhKinematics(alpha0,a0,theta1,d1);
T12 = dhKinematics(alpha1,a1,theta2,d2);
T23 = dhKinematics(alpha2,a2,theta3,d3);
T34 = dhKinematics(alpha3,a3,theta4,d4);

Tthetap = dhKinematics(0,0,thetap,0);
Tdp=dhKinematics(0,0,0,dp);

T45 = dhKinematics(alpha4,a4,theta5,d5);
P=[];
long=60;
T=eye(4);
P=[P,T(1:3,4)];
xyzplotT(T,long);
hold on;
T=T*T01;
P=[P,T(1:3,4)];
xyzplotT(T,long);
T=T*T12;
P=[P,T(1:3,4)];
xyzplotT(T,long);
T=T*T23;
P=[P,T(1:3,4)];
xyzplotT(T,long);
T=T*T34;
P=[P,T(1:3,4)];
xyzplotT(T,long);
T=T*Tthetap;
P=[P,T(1:3,4)];
xyzplotT(T,long);
T=T*Tdp;
P=[P,T(1:3,4)];
xyzplotT(T,long);
T=T*T45;
P=[P,T(1:3,4)];
xyzplotT(T,long);
T=T*T5g;
P=[P,T(1:3,4)];
xyzplotT(T,long);
plot3(P(1,:),P(2,:),P(3,:),'--r')



axis equal
ax = gca;
A = [T(1:3,1:3)*[30;0;0]+T(1:3,4),T(1:3,1:3)*[-30;0;0]+T(1:3,4)];
r = 10;
co = 'r';
eco = 'r';
PlotCyl(ax, A, r,co,eco);

% 设置角度和光照
ax.View = [-2.012659955383760e+02,11.179361664606382];
% axis off
camlight
lighting gouraud
xlabel('X(mm)')
ylabel('Y(mm)')
zlabel('Z(mm)')
% 13.864166666666701,10.8214583333333,9.999999999999996,7.223125000000035
