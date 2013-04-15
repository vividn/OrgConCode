clear scenePcs meanScenePcs
close all
hands = {'RH','','','LH'};
for scene = 1:3
    scenePcs = alignpcscores(MF3(scene),40000);
    meanScenePcs = mean(scenePcs,3);
    for n = [1 4] %Right hand, left hand
        figure
        maximize
        cmpplot(scenePcs(:,n:n+2,:))
        suptitle(['Scene ' num2str(scene) hands(n) ' PC''s'])
        saveppt('C:\OrgCon\PrelimAnalysis\TruncateAndStretch.ppt')
        close
        figure
        maximize
        plot(meanScenePcs(:,n:n+2,:))
        title(['Scene ' num2str(scene) hands(n) ' PC''s - Averaged'])
        saveppt('C:\OrgCon\PrelimAnalysis\TruncateAndStretch.ppt')
        close
    end
end

