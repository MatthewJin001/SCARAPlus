
clc;clear;close all;
 % datapoint;
clc;clear;close all;
load data

n=size(Ri,3);
I23=[eye(2) zeros(2,1)];
I33=eye(3);
Rw=zeros(2,2,n);
for i=1:n
    Rw(:,:,i)=I23*Ri(:,:,i)*I23';
end
    
iter_max=100;
step_th=1e-6;
k_num=1;
step=100;

Rk=eye(3);
twk=zeros(3,1);
pwk=zeros(2,1);
cost=[];
Rk_list=[];
cost=[cost;costComp(Ri,ti,ppi,Rk,twk,pwk)] ;
Rk_list=[Rk_list;norm(vex(logm(bRc_truth'*Rk)))*1000];


while (step_th<step && k_num<iter_max)
    
    k_num=k_num+1;
    
    Jw=[];
    fw=[];
    for i=1:n
      Jw=[Jw;-skew(Rk*ppi(:,i)),I33,-I23'*Rw(:,:,i)];
      fw=[fw;Rk*ppi(:,i)+twk-I23'*Rw(:,:,i)*pwk-ti(:,i)];      
    end    
    
    delta=-inv(Jw'*Jw)*Jw'*fw;
    
    
    deltaR=delta(1:3,1);
    deltat=delta(4:6,1);
    deltap=delta(7:8,1);
    
    Rk=expm(skew(deltaR))*Rk;
    twk=twk+deltat;
    pwk=pwk+deltap;
    
    step=norm(delta);
    costComp(Ri,ti,ppi,Rk,twk,pwk)
    cost=[cost;costComp(Ri,ti,ppi,Rk,twk,pwk)] ;
    Rk_list=[Rk_list;norm(vex(logm(bRc_truth'*Rk)))*1000];
end

marknum=k_num;


k_num=1;
step=100;

Rk=eye(3);
tk=zeros(3,1);
pk=zeros(3,1);
cost2=[];
Rk_list2=[];
cost2=[cost2;costComp2(Ri,ti,ppi,Rk,tk,pk)] ;
Rk_list2=[Rk_list2;norm(vex(logm(bRc_truth'*Rk)))*1000];

while (step_th<step && k_num<iter_max)
    
    k_num=k_num+1;
    
    J=[];
    f=[];
    for i=1:n
      J=[J;-skew(Rk*ppi(:,i)),I33,-Ri(:,:,i)];
      f=[f;Rk*ppi(:,i)+tk-Ri(:,:,i)*pk-ti(:,i)];      
    end    
    
    delta=-inv(J'*J)*J'*f;
    
    
    deltaR=delta(1:3,1);
    deltat=delta(4:6,1);
    deltap=delta(7:9,1);
    
    Rk=expm(skew(deltaR))*Rk;
    tk=tk+deltat;
    pk=pk+deltap;
    
    step=norm(delta);
    cost2=[cost2;costComp2(Ri,ti,ppi,Rk,tk,pk)] ;
    Rk_list2=[Rk_list2;norm(vex(logm(bRc_truth'*Rk)))*1000];
end


yyaxis left%激活左轴
plot(log(cost),'^-',LineWidth=1.2,Color=[0.00,0.45,0.74])
hold on;

yyaxis right%激活左轴
plot(Rk_list/1000*57.4,'s-',LineWidth=1.2)
hold on

yyaxis left%激活左轴
plot(log(cost2(1:marknum+1)),'^--',LineWidth=1.2)
xlabel('Iterative number');
ylabel('log(cost)')

yyaxis right%激活左轴
ylabel('E_R/mrad',LineWidth=1.2)
hold on
plot(Rk_list2(1:marknum+1)/1000*57.4,'s--',LineWidth=1.2)

legend('Cost (non-singular)','Cost (singular)','E_R (non-singular)','E_R (singular)')

% 0.523734579096209,0.367422031630788,0.33409926987746,0.223866503665069

% 0.85,0.33,0.10
% 0.00,0.45,0.74
