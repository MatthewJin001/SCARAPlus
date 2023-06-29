close all
figure('Color','w')
ax = gca;
A = [0 0 0;4 4 0]';
r = 1;
co = 'r';
eco = 'w';
PlotCyl(ax, A, r,co,eco);

% 设置角度和光照
ax.View = [4,27];
axis off
camlight
lighting gouraud
for i = 1:1000
    ax.View(1) = ax.View(1)+0.4;
    drawnow
end