function [cost] = costComp(Ri,ti,ppi,Ropt,twopt,pwopt)
n=size(Ri,3);
cost=0;
for i=1:n
    temp=Ropt*ppi(:,i)+twopt-[eye(2) zeros(2,1)]'*([eye(2) zeros(2,1)]*Ri(:,:,i)*[eye(2) zeros(2,1)]')*pwopt-ti(:,i);
    cost=cost+norm(temp)^2;
end

end
