
% serial=[14,17,18,24,25,26];
% serial=[3,5,6,7,8,9,10,11,12,13,15,16,19,20,21,22,23,26];
serial1=1:6;
serial2=7:12;

% 285,244,882,711

% legendstr=['Algo11_TabbR',...
%         'Algo14_AliR1','Algo15_AliR2',...
%         'Algo21_GPAP','Algo22_GPAS','Algo23_GPAM'];
%
% legendstr=['Algo2_Tsai','Algo3_Chou','Algo3_Park','Algo4_Horaud','Algo5_Daniilidis','Algo6_Liang',...
%         'Algo7_Li','Algo8_Shah','Algo9_TabbZ1','Algo10_TabbZ2','Algo12_AliX1','Algo13_AliX2',...
%         'Algo16_Zhao','Algo17_Wu1','Algo18_Wu2','Algo19_Sarabandi1','Algo19_Sarabandi2',...
%         'Algo23_GPAM'];

% set (gca,'position',[285,244,882,711] )

figure;
subplot(1,4,1);

tmp=mean(e_R,3);

i_sigma=1;
h1=plot(nvar,tmp(i_sigma,:),'-','LineWidth',1.3,'MarkerSize',3);
set(h1,'MarkerFaceColor',get(h1,'color'));
hold on;

i_sigma=2;
h2=plot(nvar,tmp(i_sigma,:),'-','LineWidth',1.3,'MarkerSize',3);
set(h2,'MarkerFaceColor',get(h2,'color'));

i_sigma=3;
h3=plot(nvar,tmp(i_sigma,:),'-','LineWidth',1.3,'MarkerSize',3);
set(h3,'MarkerFaceColor',get(h3,'color'));

ylabel('ER/mrad')
xlabel('Measurement number')


subplot(1,4,2);

tmp=mean(e_tw,3);

i_sigma=1;
h1=plot(nvar,tmp(i_sigma,:),'-','LineWidth',1.3,'MarkerSize',3);
set(h1,'MarkerFaceColor',get(h1,'color'));
hold on;

i_sigma=2;
h2=plot(nvar,tmp(i_sigma,:),'-','LineWidth',1.3,'MarkerSize',3);
set(h2,'MarkerFaceColor',get(h2,'color'));

i_sigma=3;
h3=plot(nvar,tmp(i_sigma,:),'-','LineWidth',1.3,'MarkerSize',3);
set(h3,'MarkerFaceColor',get(h3,'color'));

ylabel('tw/mm')
xlabel('Measurement number')



subplot(1,4,3);

tmp=mean(e_thetap,3);

i_sigma=1;
h1=plot(nvar,tmp(i_sigma,:),'-','LineWidth',1.3,'MarkerSize',3);
set(h1,'MarkerFaceColor',get(h1,'color'));
hold on;

i_sigma=2;
h2=plot(nvar,tmp(i_sigma,:),'-','LineWidth',1.3,'MarkerSize',3);
set(h2,'MarkerFaceColor',get(h2,'color'));

i_sigma=3;
h3=plot(nvar,tmp(i_sigma,:),'-','LineWidth',1.3,'MarkerSize',3);
set(h3,'MarkerFaceColor',get(h3,'color'));

ylabel('e_thetap/mrad')
xlabel('Measurement number')


subplot(1,4,4);

tmp=mean(td,3);

i_sigma=1;
h1=plot(nvar,tmp(i_sigma,:),'-','LineWidth',1.3,'MarkerSize',3);
set(h1,'MarkerFaceColor',get(h1,'color'));
hold on;

i_sigma=2;
h2=plot(nvar,tmp(i_sigma,:),'-','LineWidth',1.3,'MarkerSize',3);
set(h2,'MarkerFaceColor',get(h2,'color'));

i_sigma=3;
h3=plot(nvar,tmp(i_sigma,:),'-','LineWidth',1.3,'MarkerSize',3);
set(h3,'MarkerFaceColor',get(h3,'color'));

ylabel('e_thetap/mrad')
xlabel('Measurement number')


legend('noise1',...
    'noise2','noise3')





