absxy = abs(uxy);
% for i = 10:2:size(absxy, 3)
%     plot(smooth(absxy(1,:,i)- absxy(2,:,i),50));
%     hold on
% end
disp(:,:) = uxy(1,:,:) - uxy(2,:,:);

omega = 1000;
ind = find(w==omega);
t = 0.00001:0.00001:1;
phasor = exp(1i*omega*t);

% for i = 1:1000
%     plot(real(disp(:,ind)*phasor(i)))
%     ylim([-0.0003,0.00035])
%     drawnow
% end

font_size = 20;
linewidth = 2;
step_text = 10;
    
filename = 'test.gif';
figure
a = colormap('lines');
close all


figure
set(gcf, 'Color', [1,1,1]);
set(gcf, 'Position', [0,0,600, 900]);

osc_k = 1;
incr = 30;
numb_steps = 20;
sm_wn = 50;

fig_k = 1;
for i_period = 10:length(w-10)
    omega = w(i_period);
    phasor = exp(1i*omega*t);
    single_disp = disp(:,i_period);
    x = (1:size(uxy,2))*3.5/size(uxy,2);
    for n = 1:numb_steps
        subplot(2,1,1)
        surf(real(uxy(:,:,i_period)*phasor(osc_k)), 'EdgeColor', 'None');
        %imagesc(real(uxy(:,:,i_period)*phasor(osc_k)));
        zlim([-0.7, 0.7])
        ylabel('Y (mm)');%, 'FontWeight'), 'bold')
        xlabel('X (mm)');%, 'FontWeight', 'bold')
        zlabel('Velocity field intensity')
        set(gca,'fontsize',font_size)
        set(gca,'LineWidth',linewidth)
        set(gca,'visible','off');
        %set(gca, 'Position',[0.2 0.3 0.6 0.6]);

        
        subplot(2,1,2)
        plot(x, smooth(real(single_disp*phasor(osc_k)), sm_wn), 'LineWidth', linewidth);
        hold on
        plot(x, smooth(abs(single_disp*phasor(osc_k)), sm_wn), ...
            '--', 'Color', a(7,:), 'LineWidth', linewidth);
        plot(x, -smooth(abs(single_disp*phasor(osc_k)), sm_wn), ...
            '--', 'Color', a(7,:), 'LineWidth', linewidth);

        ylim([-0.0007, 0.0007])
        xlim([0, 3.5])

        ylabel('Displacement (mm)')%, 'Position', [-0.30 6.6757e-09 -1.0000]);%, 'FontWeight'), 'bold')
        xlabel('Distance from round window (mm)')%, 'Position', [1.75 -0.0008 -1.0000]);%, 'FontWeight', 'bold')
        set(gca,'fontsize',font_size)
        set(gca,'LineWidth',linewidth)
        %set(gca, 'Position',[0.2 0.3 0.6 0.6]);

        text(2.8, 0.00055, strcat(num2str(omega), ' Hz'), ...
            'FontSize', font_size)%, 'FontWeight', 'bold')

        
        %pause(0.02)
        %drawnow 

        

        frame = getframe(1);
        im = frame2im(frame);
        [imind,cm] = rgb2ind(im,256);
        if fig_k == 1;
            imwrite(imind,cm,filename,'gif', ...%'XResolution', res,...
            'Loopcount',inf, 'DelayTime',0);
        else
            imwrite(imind,cm,filename,'gif', ...%'XResolution', res, ...
                'WriteMode','append', 'DelayTime',0);
        end
        hold off
        osc_k = osc_k + incr;
        fig_k = fig_k + 1;
    end
end
