function [cost] = costComp2(Ri,ti,ppi,Ropt,topt,popt)
n=size(Ri,3);
cost=0;
for i=1:n
    temp=Ropt*ppi(:,i)+topt-Ri(:,:,i)*popt-ti(:,i);
    cost=cost+norm(temp)^2;
end

end
