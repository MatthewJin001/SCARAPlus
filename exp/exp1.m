
clc;clear;

%标定锥第一次标定
x1=-4.166048840418354;
y1=-328.73141733504167; 
z1=148.8613404898894;
roll1=145.58267153278152;
pitch1=2.2686724052870932;
yaw1=90.65155823546195;

%标定锥第二次标定
x2=-3.574878477116099;
y2=-324.29256331129625;
z2=151.3558414389969;
roll2=145.9358940123337;
pitch2=2.67391823;
yaw2=90.35048;

R1=eular2dcm(roll1*pi/180,pitch1*pi/180,yaw1*pi/180);
t1=[x1;y1;z1];

rmse1 = rmse_f(R1,t1,1);

R2=eular2dcm(roll2*pi/180,pitch2*pi/180,yaw2*pi/180);
t2=[x2;y2;z2];

rmse2 = rmse_f(R2,t2,1);

R3=[   -0.0145    0.8333    0.5526;
    0.9992    0.0322   -0.0223;
   -0.0364    0.5519   -0.8331;];
t3=[    0.5774;
 -332.7035;
  232.3519];

rmse3 = rmse_f(R3,t3,2)


R4=[      -0.0136    0.8332    0.5528
    0.9993    0.0307   -0.0218
   -0.0352    0.5521   -0.8330;];
t4=[        0.2246
 -333.1496
  232.4257];

rmse4 = rmse_f(R4,t4,2);


function [dcm] = eular2dcm(roll,pitch,yaw)

dcm=[cos(yaw)*cos(pitch), cos(yaw)*sin(pitch)*sin(roll) - sin(yaw)*cos(roll), cos(yaw)*sin(pitch)*cos(roll) + sin(yaw)*sin(roll);
    sin(yaw)*cos(pitch), sin(yaw)*sin(pitch)*sin(roll) + cos(yaw)*cos(roll), sin(yaw)*sin(pitch)*cos(roll) - cos(yaw)*sin(roll);
    -sin(pitch), cos(pitch)*sin(roll), cos(pitch)*cos(roll)];
end