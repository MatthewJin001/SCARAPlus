clc;clear;
Tcb_x=-3.574;
Tcb_y=-324.292;
Tcb_z=151.355;
Tcb_roll=145.935;
Tcb_pitch=2.673;
Tcb_yaw=90.350;

bRc=eular2dcm(Tcb_roll*pi/180,Tcb_pitch*pi/180,Tcb_yaw*pi/180);
btc=[Tcb_x;Tcb_y;Tcb_z];


Rk=bRc';
tk=zeros(3,1);
pk=zeros(3,1);

Ri=eular2dcm(30/57.3,45/57.3,80/57.3);
ti=[50;100;200;];

% J=[-skew(Ri*pk+ti),eye(3),Rk];
% 
% temp=J'*J;
% 
% inv(temp)

% inv(temp(end-3:end,end-3:end))

J2=[eye(3),-bRc];
J2'*J2