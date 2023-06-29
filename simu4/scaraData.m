function [Ri,ti,ppi,R_truth,tw_truth,thetap_truth]=scaraData(var,sigma)
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
n=var;
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

% x_list=[]
% y_list=[]
% z_list=[]
% sita_list=[]

load scaraJoint.mat
for i=1:n
    
    % x=x1+(x2-x1)*rand;
    % y=y1+(y2-y1)*rand;
    % z=z1+(z2-z1)*rand;
    % sita=sita1+(sita2-sita1)*rand;
    % x_list=[x_list,x];
    % y_list=[y_list,y];
    % z_list=[z_list,z];
    % sita_list=[sita_list,sita];
    x=x_list(i);
    y=y_list(i);
    z=z_list(i);
    sita=sita_list(i);

    
    Ri(:,:,i)=[cos(sita*pi/180),-sin(sita*pi/180),0;...
        sin(sita*pi/180),cos(sita*pi/180),0;...
        0,0,1];
    ti(:,i)=[x;y;z];
    ppi(:,i)=bRc'*(Ri(:,:,i)*pe+ti(:,i)-btc)+normrnd(0,sigma,[3 1]);
end


R_truth=bRc;
tw_truth=btc-[0;0;pe(3)];
% pe_truth=pe;
% 
% btcS_truth=btc-[0;0;pe(3)];
thetap_truth=thetap;
% save data Ri ti ppi R_truth tw_truth thetap_truth 

end

function [dcm] = eular2dcm(roll,pitch,yaw)

dcm=[cos(yaw)*cos(pitch), cos(yaw)*sin(pitch)*sin(roll) - sin(yaw)*cos(roll), cos(yaw)*sin(pitch)*cos(roll) + sin(yaw)*sin(roll);
    sin(yaw)*cos(pitch), sin(yaw)*sin(pitch)*sin(roll) + cos(yaw)*cos(roll), sin(yaw)*sin(pitch)*cos(roll) - cos(yaw)*sin(roll);
    -sin(pitch), cos(pitch)*sin(roll), cos(pitch)*cos(roll)];
end
