function plot_error(m_var, m_var_name, fix_val, fix_val_name, Error, Ename,  fignum)

% Error plotter : figure number is "m"
% Plot error vs m_var with fix_val

figure(fignum)
loglog(m_var,Error,'*-','Linewidth',1.5) %
hold on
% loglog(m_var,Error2,'o-','Linewidth',1.5) %

logx1 = log(m_var); %
logy1 = log(Error);
Const1 = polyfit(logx1, logy1, 1);



hold on
plot(m_var, exp(polyval(Const1, logx1)),'--','Linewidth',2.5) %

set(gca,'Fontsize',20);
legend({Ename, 'Linear fit'},'FontSize',17) %
legend('Location','northwest')


xlabel(m_var_name,'fontsize',25,'interpreter','latex')
ylabel(Ename, 'fontsize',25,'interpreter','latex')

ytickformat('%.1f')

slope1 = Const1(1);

dim = [0.60 0.20 0.0 0.1];
str = {[fix_val_name,' = ',num2str(fix_val,'%.2e')],['Slope1 = ',num2str(round(slope1,4))]}; %
annotation('textbox',dim,'String',str,'FitBoxToText','on','Fontsize',17)

% title(varargin{1},'Fontsize',17)



hold off
end