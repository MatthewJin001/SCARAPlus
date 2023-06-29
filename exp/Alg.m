function [R,tw,pw,thetap,rnti,k_num] = Alg(Ri,ti,ppi)
tic;
iter_max=100;
step_th=1e-11;
n=size(Ri,3);
I23=[eye(2) zeros(2,1)];
I33=eye(3);
Rw=zeros(2,2,n);
for i=1:n
    Rw(:,:,i)=I23*Ri(:,:,i)*I23';
end
    
J_=[];
f_=[];
for i=1:n    
    J_=[J_;kron([ppi(:,i)',1],I33),-I23'*Rw(:,:,i)];
    f_=[f_;-ti(:,i)];
end
guess=-inv(J_'*J_)*J_'*f_;

rIni=guess(1:9,1);
[U,S,V]=svd(reshape(rIni,3,3));
Rini=sign(det(U)*det(V))*U*V';
% Rini=expm(logm(reshape(rIni,3,3)));
twIni=guess(10:12,1);
pwIni=guess(13:14,1);


%看一下用优化求的结果

% % disp('sqp');
% % para.Ri=Ri;
% % para.ti=ti;
% % para.ppi=ppi;
% % para.x0=[vex(logm(Rini))' twIni' pwIni'];
% % options = optimoptions('fmincon','Display','iter','StepTolerance',1e-11,'MaxIterations',200,'Algorithm','sqp');
% % x=fmincon(@(x)cost_zhao(x,para),para.x0,[],[],[],[],[],[],[],options);
% % Ropt1=expm(skew([x(1);x(2);x(3)]));
% % twopt1=[x(4);x(5);x(6)];    
% % pwopt1=[x(7);x(8)];
% cost = costComp(Ri,ti,ppi,Ropt1,twopt1,pwopt1)

% disp('levenberg-marquardt')
% para.Ri=Ri;
% para.ti=ti;
% para.ppi=ppi;
% para.x0=[vex(logm(Rini))' twIni' pwIni'];
% options = optimoptions('lsqnonlin','Display','iter','StepTolerance',1e-10,'MaxIterations',100,'Algorithm','levenberg-marquardt');
% [x,resnorm,residual,exitflag,output] =lsqnonlin(@(x)loss_lm(x,para),para.x0,[],[],options);
% Ropt2=expm(skew([x(1);x(2);x(3)]));
% twopt2=[x(4);x(5);x(6)];    
% pwopt2=[x(7);x(8)];
% cost = costComp(Ri,ti,ppi,Ropt2,twopt2,pwopt2)

k_num=1;
step=100;
Rk=Rini;
% Rk=eye(3);
twk=twIni;
pwk=pwIni;

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
    
%     cost = costComp(Ri,ti,ppi,Rk,twk,pwk)
end

R=Rk;
tw=twk;
pw=pwk;

thetap=atan2(pw(1),-pw(2));
rnti=toc;

end


% function cost=cost_zhao(x,para)
% inRi=para.Ri;
% inti=para.ti;
% inppi=para.ppi;
% n=size(inRi,3);
% inRopt=expm(skew([x(1);x(2);x(3)]));
% intwopt=[x(4);x(5);x(6)];    
% inpwopt=[x(7);x(8)];
% cost=0;
% for i=1:n
%     temp=inRopt*inppi(:,i)+intwopt-[eye(2) zeros(2,1)]'*([eye(2) zeros(2,1)]*inRi(:,:,i)*[eye(2) zeros(2,1)]')*inpwopt-inti(:,i);
%     cost=cost+norm(temp)^2;
% end
% end
