% Script to generate gif of cochlea oscillation for increasing frequencies
% under the deep water approximation
font_size = 40;
linewidth = 5;
    
filename = 'test.gif';
a = colormap('lines');

for n = 600:2:1000
    [disp, phasor, x] = cochlea_dw(n);
    % Plot membrane position:
    plot(x, real(disp*phasor(n)), 'LineWidth', linewidth);
    hold on
    % Plot boundaries of the membrane oscillation:
    plot(x, abs(disp*phasor(n)), '--', 'Color', a(7,:), 'LineWidth', linewidth);
    plot(x, -abs(disp*phasor(n)), '--', 'Color', a(7,:), 'LineWidth', linewidth);
    
    ylim([-0.007, 0.007])
    xlim([0, 2.5])
    
    b = ylabel('Displacement (mm)', 'Position', [-0.30 6.6757e-09 -1.0000]);%, 'FontWeight'), 'bold')
    xlabel('Distance from round window (mm)', 'Position', [1.2500 -0.009 -1.0000])%, 'FontWeight', 'bold')
    get(b, 'Position')
    set(gca,'fontsize',font_size)
    set(gca,'LineWidth',linewidth)
    set(gca, 'Position',[0.2 0.2 0.7 0.7]);
    
    set(gcf, 'Color', [1,1,1]);
    set(gcf, 'Position', [0,0,1200, 900]);

    
    pause(0.02)
    step_text = 10;
    text(2, 0.006, strcat(num2str(step_text*round((n)/step_text)), ' Hz'), ...
        'FontSize', font_size)%, 'FontWeight', 'bold')
    drawnow
    
    frame = getframe(1);
      im = frame2im(frame);
      [imind,cm] = rgb2ind(im,256);
      if n == 1;
          imwrite(imind,cm,filename,'gif', ...%'XResolution', res,...
          'Loopcount',inf, 'DelayTime',0);
      else
          imwrite(imind,cm,filename,'gif', ...%'XResolution', res, ...
              'WriteMode','append', 'DelayTime',0);
      end
    hold off
end