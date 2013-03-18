close all
figure;
trialnum = 5;
maximize;
plot(RH_x(:,trialnum),RH_y(:,trialnum),LH_x(:,trialnum),LH_y(:,trialnum))
XLIM = get(gca,'XLim');
YLIM = get(gca,'YLim');
for i= 400:100:length(ti)
    rng = i-399:i;
    plot(RH_x(rng,trialnum),RH_y(rng,trialnum),LH_x(rng,trialnum),LH_y(rng,trialnum))
    hold on
    scatter(RH_x(i,trialnum),RH_y(i,trialnum),60,'filled','b')
    scatter(LH_x(i,trialnum),LH_y(i,trialnum),60,'filled','g')
    scatter(posmarkers(:,1),posmarkers(:,2),200,'b') % Plots the RH position markers
    scatter(posmarkers(:,4),posmarkers(:,5),200,'g') % Plots the LH position markers
    
    hold off
    xlim(XLIM);ylim(YLIM)
    title(['t = ' num2str(i/1000)]);
    pause(0.01);
end
