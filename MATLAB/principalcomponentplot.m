close all;
figure;maximize;
pcDataVar = {rhPc,lhPc};
hand = {'RH','LH'};
for experimentNum = 1:2
    for trialNum = [1 4 7 10]
        for i = 1:2
            clf
            pcData = pcDataVar{i}{experimentNum}(:,:,trialNum);
            plot(pcData);
            hline(0);
            timeIndices = ~isnan(pcData(:,1));
            r = corr(pcData(timeIndices,:));
            title({[hand{i} ' PCs (from Jerde and Flanders), Exp '...
                num2str(experimentNum) ', trial ' num2str(trialNum)];...
                ['r = ' num2str(r(1,2))]}, 'FontSize',17);
            saveppt('C:\Nate\OrgCon\PrelimAnalysis\PrincipalComponents2.ppt')
        end
    end
end

