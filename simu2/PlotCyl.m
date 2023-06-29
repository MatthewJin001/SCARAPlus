function PlotCyl(ax, A, r,co,eco)
% 绘制圆柱体

% 输入参数：
%   ax - 坐标轴句柄
%   A - 3×2矩阵，分别记录圆柱体端部圆心的坐标
%   r - 标量，圆柱体半径
%   co,eco - 颜色

% 测试示例
%   ax = gca;
%   A = [0 0 0;0 0 5]';
%   r = 1;
%   co = 'r';
%   eco = 'w';
%   PlotCyl(ax, A, r,co,eco);

ntt = 20; % 圆的等分数目
theta = linspace(0,2*pi,ntt+1);
circle = [cos(theta); sin(theta)];
cylaxes = A;
D = diff(A,1,2);
Q = null(D.');
c = (r*Q)*circle;
c1 = c + cylaxes(:,1);
c2 = c + cylaxes(:,2);
x = [c1(1,1:end-1); c1(1,2:end); c2(1,2:end); c2(1,1:end-1)];
y = [c1(2,1:end-1); c1(2,2:end); c2(2,2:end); c2(2,1:end-1)];
z = [c1(3,1:end-1); c1(3,2:end); c2(3,2:end); c2(3,1:end-1)];
c = permute(cat(3,c1,c2),[2 3 1]); % 置换数组维度
hold(ax,'on');
fill3(ax, x, y, z,0.7+[0 0 0],'FaceColor',co,'EdgeColor',eco); % 绘制圆柱的侧面
 fill3(ax, c(:,:,1), c(:,:,2), c(:,:,3), 0.7+[0 0 0],'FaceColor',co,'EdgeColor',eco) % 绘制圆柱的端部
axis equal
end