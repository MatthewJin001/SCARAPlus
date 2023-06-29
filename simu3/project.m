
clc;clear;
load data
% [R,tw,pw,rnti,n] = Alg(Ri,ti,ppi);

tic;
iter_max=100;
step_th=1e-6;
n=size(Ri,3);
I23=[eye(2) zeros(2,1)];
I33=eye(3);
Rw=zeros(2,2,n);
for i=1:n
    Rw(:,:,i)=I23*Ri(:,:,i)*I23';
end
    

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

R=Rk;
tw=twk;
pw=pwk;

prop=zeros(2,n);
prot=zeros(1,n);

for i=1:n
    prop(:,i)=Rw(:,:,i)'*I23*(R*ppi(:,i)+tw-ti(:,i));
end
plot(prop(1,:),prop(2,:),'*')
hold on;
plot(pe_truth(1),pe_truth(2),'^')
