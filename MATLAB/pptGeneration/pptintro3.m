pptfile = 'C:\Nate\OrgCon\PrelimAnalysis\PositionOverlay.ppt';


close all
figure;
maximize;
map = jet(8);
set(gcf,'DefaultAxesColorOrder',map(1:8,:));

plot(LH_x,LH_y)
axis equal
legend(num2str(trials'))
LHlims(1,:) = get(gca,'XLim');
LHlims(2,:) = get(gca,'YLim');
title('Left Hand, X vs Y','FontSize',24)
saveppt(pptfile)

plot(RH_x,RH_y)
axis equal
legend(num2str(trials'))
RHlims(1,:) = get(gca,'XLim');
RHlims(2,:) = get(gca,'YLim');
title('Right Hand, X vs Y','FontSize',24)
saveppt(pptfile)

set(gcf,'DefaultAxesColorOrder',map([1 3 5 7],:));

plot(LH_x(:,[1 3 5 7]),LH_y(:,[1 3 5 7]))
axis equal
legend(num2str(trials([1 3 5 7])'))
set(gca,'XLim',LHlims(1,:),'YLim',LHlims(2,:))
title('Left Hand, X vs Y, 1-4','FontSize',24)
saveppt(pptfile)

plot(RH_x(:,[1 3 5 7]),RH_y(:,[1 3 5 7]))
axis equal
legend(num2str(trials([1 3 5 7])'))
set(gca,'XLim',RHlims(1,:),'YLim',RHlims(2,:))
title('Right Hand, X vs Y, 1-4','FontSize',24)
saveppt(pptfile)

set(gcf,'DefaultAxesColorOrder',map([2 4 6 8],:));

plot(LH_x(:,[2 4 6 8]),LH_y(:,[2 4 6 8]))
axis equal
legend(num2str(trials([2 4 6 8])'))
set(gca,'XLim',LHlims(1,:),'YLim',LHlims(2,:))
title('Left Hand, X vs Y, 5-8','FontSize',24)
saveppt(pptfile)

plot(RH_x(:,[2 4 6 8]),RH_y(:,[2 4 6 8]))
axis equal
legend(num2str(trials([2 4 6 8])'))
set(gca,'XLim',RHlims(1,:),'YLim',RHlims(2,:))
title('Right Hand, X vs Y, 5-8','FontSize',24)
saveppt(pptfile)