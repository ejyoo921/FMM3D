function loglog_slope(x, y, fix_val_name, linetype)

logx1 = log(x); %
logy1 = log(y);
Const1 = polyfit(logx1, logy1, 1);
slope1 = Const1(1);



hold on
plot(x, exp(polyval(Const1, logx1)),linetype,'Linewidth',2.5) %

% set(gca,'Fontsize',20);
% legend({Ename, 'Linear fit'},'FontSize',17) %
% legend('Location','northwest')


% xlabel(x_name,'fontsize',25,'interpreter','latex')
% ylabel(y_name, 'fontsize',25,'interpreter','latex')
% 
% ytickformat('%.1f')


dim = [0.65 0.20 0.0 0.5];
str = {[fix_val_name,' = ',num2str(round(slope1,4))]}; %
annotation('textbox',dim,'String',str,'FitBoxToText','on','Fontsize',17)

end