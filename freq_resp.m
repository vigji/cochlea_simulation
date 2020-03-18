w = 1:1500;
w_0 = 600;
Q_arr = [10, 1, 5];

a = colormap('lines');

line([600, 600],[0, 12], 'LineStyle', '--', 'LineWidth', 2, 'Color', [0.5,0.5,0.5])%a(5,:))
hold on
for i = 1:length(Q_arr)
    Q = Q_arr(i);
    num = (Q^2 + (w/w_0).^2);
    den = ((w/w_0-w_0./w).^2*Q^2 + 1);
    A = (num./den).^(1/2);
    %A = ./((w/w_0-w_0./w)*Q + 1));
    loglog(w,A, 'LineWidth', 2)
end
xlabel('$$ Input \: frequency \:(\omega) $$', ...
    'Interpreter', 'latex', 'FontSize', 18)
ylabel('$$Norm. \: impedance  \left(\frac{|\hat{V}|\omega_0C}{\bar{I}}\right) $$', ...
    'Interpreter', 'latex', 'FontSize', 18)

%line([600, 600],[0, 12], 'LineStyle', '--', 'LineWidth', 2, 'Color', [0.5,0.5,0.5])%a(5,:))
text(630, 11, '$$ \omega_0 $$', 'Interpreter', 'latex', 'FontSize', 18)
ylim([0, 12])
legend({'Q = 1', 'Q = 5', 'Q = 10'}, 'Interpreter', 'latex', 'fontsize',18);
legend('boxoff')
%legend({'1', '2', '3'})

set(gca, 'Position',[0.2 0.2 0.6 0.6]);
set(gca,'fontsize',18)
set(gca,'LineWidth',1.5)
set(gca,'TickLabelInterpreter', 'latex')