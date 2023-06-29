clc;clear;
thetap=-5/180*pi;
dp=-50;
alpha4=pi/2;a4=0;theta5=0;d5=0;
Tthetap = dhKinematics(0,0,thetap,0);
Tdp=dhKinematics(0,0,0,dp);
T45 = dhKinematics(alpha4,a4,theta5,d5);

T=(Tthetap*Tdp*T45);
pe=T(1:3,1:3)*[0;0;20]+T(1:3,4);
% length=30;
% xyzplotT(eye(4),length)
% hold on;
% xyzplotT(Tthetap,length)
% xyzplotT(Tthetap*Tdp,length)
% axis equal



x1=220;
x2=500;

y1=-510;
y2=-214;

z1=-129;
z2=-91;

sita1=-283+360; %77
sita2=-256+360; %104

%取25组数据
n=25;
Ri=zeros(3,3,n);
ti=zeros(3,n);
ppi=zeros(3,n);


Tcb_x=-3.574;
Tcb_y=-324.292;
Tcb_z=151.355;
Tcb_roll=145.935;
Tcb_pitch=2.673;
Tcb_yaw=90.350;

bRc=eular2dcm(Tcb_roll*pi/180,Tcb_pitch*pi/180,Tcb_yaw*pi/180);
btc=[Tcb_x;Tcb_y;Tcb_z];
% bRc=cRb';
% btc=-cRb'*ctb;

% pe=[0;20;-80;];
for i=1:n
    x=x1+(x2-x1)*rand;
    y=y1+(y2-y1)*rand;
    z=z1+(z2-z1)*rand;
    sita=sita1+(sita2-sita1)*rand;
    roll_t=-pi+2*pi*rand;
    pitch_t=-pi+2*pi*rand;
    yaw_t=-pi+2*pi*rand;
    Ri(:,:,i)=eular2dcm(roll_t,pitch_t,yaw_t);

    Ri(:,:,i)=[cos(sita*pi/180),-sin(sita*pi/180),0;...
        sin(sita*pi/180),cos(sita*pi/180),0;...
        0,0,1];
    ti(:,i)=[x;y;z];
    ppi(:,i)=bRc'*(Ri(:,:,i)*pe+ti(:,i)-btc)+normrnd(0,1.5,[3 1]);
end

xyzplotc(eye(3),zeros(3,1),80);
hold on;
text(0,0,0,'\{Base\}','FontSize',10);
xyzplotc(bRc,btc,80);
text(btc(1),btc(2),btc(3),'\{Camera\}','FontSize',10);
grid on;
axis equal;
pose = rigid3d(bRc',btc');
cam = plotCamera('AbsolutePose',pose,'size',20);

for i=1:n
    xyzplotc(Ri(:,:,i),ti(:,i),30);
    
    p_b=Ri(:,:,i)*pe+ti(:,i);
    plot3([ti(1,i);p_b(1)],[ti(2,i);p_b(2)],[ti(3,i);p_b(3)],'r');
    plot3([p_b(1)],[p_b(2)],[p_b(3)],'*r');
    % text(p_b(1),p_b(2),p_b(3),strcat(num2str(i)),'FontSize',10);
end

box on;
grid off;
xlabel('X/mm')
ylabel('Y/mm')
zlabel('Z/mm')

bRc_truth=bRc;
btc_truth=btc;
pe_truth=pe;

btcS_truth=btc-[0;0;pe(3)];
thetap_truth=thetap;
save data Ri ti ppi bRc_truth btc_truth pe_truth  btcS_truth thetap_truth

function [dcm] = eular2dcm(roll,pitch,yaw)

dcm=[cos(yaw)*cos(pitch), cos(yaw)*sin(pitch)*sin(roll) - sin(yaw)*cos(roll), cos(yaw)*sin(pitch)*cos(roll) + sin(yaw)*sin(roll);
    sin(yaw)*cos(pitch), sin(yaw)*sin(pitch)*sin(roll) + cos(yaw)*cos(roll), sin(yaw)*sin(pitch)*cos(roll) - cos(yaw)*sin(roll);
    -sin(pitch), cos(pitch)*sin(roll), cos(pitch)*cos(roll)];
end

function [T] = dhKinematics(alpha,a,theta,d)
T=[cos(theta),-sin(theta),0,a;...
    sin(theta)*cos(alpha),cos(theta)*cos(alpha),-sin(alpha),-d*sin(alpha);...
    sin(theta)*sin(alpha),cos(theta)*sin(alpha),cos(alpha),d*cos(alpha);...
    0,0,0,1];
end

