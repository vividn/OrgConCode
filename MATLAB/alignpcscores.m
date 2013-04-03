function alignedPcScores = alignpcscores(SceneStructure,method)
% Takes the PC scores from a scene, truncates and stretches them to align
% with each other. Method can be 'max', 'min', or 'avg', or a number:
%  method determines the size of the time dimension in the returned array

if nargin < 2
    method = 'avg';
end

bothHands = cat(2,SceneStructure.Rh.glovePC,SceneStructure.Lh.glovePC);
[startTrunc stopTrunc] = differentialthreshold(bothHands,0.15,1,2);

switch method
    case 'max'
        newSize = max(stopTrunc - startTrunc);
    case 'min'
        newSize = min(stopTrunc - startTrunc);
    case 'avg'
        newSize = round(mean(stopTrunc - startTrunc));
    otherwise
        if isnumeric(method) && isscalar(method)
            newSize = round(method);
        else
            error('alignpcscores:Bad method');
        end
end


nTrials = size(bothHands,3);
nComponents = size(bothHands,2);

alignedPcScores = zeros(newSize,nComponents,nTrials); %Initialize


for iTrial = 1:nTrials
    leftTrunc = startTrunc(iTrial);
    rightTrunc = stopTrunc(iTrial);
    truncatedData = bothHands(leftTrunc:rightTrunc,:,iTrial);
    alignedPcScores(:,:,iTrial) = vectorstretch(truncatedData,newSize);
end

