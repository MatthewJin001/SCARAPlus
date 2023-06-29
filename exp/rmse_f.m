function [rmse] = rmse_f(R_out,t_out,flag)

circle=[36 77.40763029244485 13.689079021220735 54.643080834743984 468.2647216850841;
    37 75.84740276800399 -20.900037900868497 52.166621575236576 471.0099994443867;
    38 78.21124246556555 -69.19229132107702 87.61125481919616 493.4222897125486;
    39 77.34819507742577 -116.60057710479765 66.75569717217232 482.3577542221263;
    40 76.2043578679543 -94.30790291379968 22.880977229215333 453.3074115437902;];

data=[360.091797 -330.589203 -128.246002 -269.711578;
    359.37323 -375.690918 -128.851028 -279.540161;
    400.212341 -418.932343 -129.237213 -276.625183;
    378.697876 -468.801636 -129.360367 -279.259888;
    327.240387 -445.922089 -128.629776 -277.644592];

n=length(circle(:,1));
Ri=zeros(3,3,n);
ti=zeros(3,n);
ppi=zeros(3,n);
for i=1:n
    x=data(i,1);
    y=data(i,2);
    z=data(i,3);
    sita=data(i,4);
    Ri(:,:,i)=[cos(sita*pi/180),-sin(sita*pi/180),0;...
        sin(sita*pi/180),cos(sita*pi/180),0;...
        0,0,1];
    ti(:,i)=[x;y;z];
    ppi(:,i)=circle(i,3:5)';
end



if flag==1

    I23=[eye(2) zeros(2,1)];
    Rw=zeros(2,2,n);
    for i=1:n
        Rw(:,:,i)=I23*Ri(:,:,i)*I23';
    end


    % 求bi
    bi=zeros(2,n);
    for i=1:n
        temp=R_out*ppi(:,i)+t_out-ti(:,i);
        bi(:,i)=temp(1:2,1);
    end

    %Ax=b

    left=zeros(2,2); right=zeros(2,1);
    for i=1:n
        left=left+Rw(:,:,i)'*Rw(:,:,i);
        right=right+Rw(:,:,i)'*bi(:,i);
    end

    x=inv(left)*right;

    rmse=0;
    for i=1:n
        R_out*ppi(:,i)+t_out-[Rw(:,:,i)*x;0]-ti(:,i);
        rmse=rmse+norm(R_out*ppi(:,i)+t_out-[Rw(:,:,i)*x;0]-ti(:,i))^2;
    end
    rmse=sqrt(rmse/n);
end





% 求bi
bi=zeros(3,n);
for i=1:n
    temp=R_out*ppi(:,i)+t_out-ti(:,i);
    bi(:,i)=temp(1:3,1);
end

%Ax=b

left=zeros(3,3); right=zeros(3,1);
for i=1:n
    left=left+Ri(:,:,i)'*Ri(:,:,i);
    right=right+Ri(:,:,i)'*bi(:,i);
end

x=inv(left)*right;

rmse=0;
for i=1:n
    R_out*ppi(:,i)+t_out-Ri(:,:,i)*x-ti(:,i);
    rmse=rmse+norm(R_out*ppi(:,i)+t_out-Ri(:,:,i)*x-ti(:,i))^2;
end
rmse=sqrt(rmse/n);







end




