%Plots the Polhemus data side by side for comparison

pptfile = 'C:\Nate\OrgCon\PrelimAnalysis\SomeIntroData.ppt';

close;cmpplot(LH_x);cmpplot(RH_x);suptitle('X-axis');
maximize;
saveppt(pptfile);

close;cmpplot(LH_y);cmpplot(RH_y);suptitle('Y-axis');
maximize;
saveppt(pptfile);

close;cmpplot(LH_z);cmpplot(RH_z);suptitle('Z-axis');
maximize;
saveppt(pptfile);

close 
figure;
map = colormap('hsv(17)');
set(gcf,'DefaultAxesColorOrder',map);

%Plots the cyberglove data during the whisking section
for n = 1:length(trials)
    lims = xsnips(:,n); %the begin and end time to make the snips    
    plot(lims(1):lims(2),RHcdeg_whisk{n});
    maximize;
    legend(CGsensors,'location',[-0.00812500000000083 0.639452644526446 0.12125 0.297047970479705]);
    title(['RH cyberglove during whisk sequence - Trial ' num2str(trials(n))],'FontSize', 24);
    saveppt(pptfile);
    plot(lims(1):lims(2),LHcdeg_whisk{n});
    title(['LH cyberglove during whisk sequence - Trial ' num2str(trials(n))],'FontSize', 24);
    saveppt(pptfile);
end
open(pptfile);