function alignedPcScores = alignpcscores(SceneStructure,method)
% Takes the PC scores from a scene, truncates and stretches them to align
% with each other. Method can be 'max', 'min', or 'avg', or a number:
%  method determines the size of the time dimension in the returned array

if nargin < 2
    method = 'avg';
end

bothHands = cat(2,SceneStructure.Rh.glovePC,SceneStructure.Lh.glovePC);

nTrials = size(bothHands,3);
nComponents = size(bothHands,2);

sizeArray = min(sum(~isnan(bothHands),1),[],2);

switch method
    case 'max'
        newSize = max(sizeArray);
    case 'min'
        newSize = min(sizeArray);
    case 'avg'
        newSize = round(mean(sizeArray,3));
    otherwise
        if isnumeric(method) && isscalar(method)
            newSize = round(method);
        else
            error('alignpcscores:Bad method');
        end
end

alignedPcScores = zeros(newSize,nComponents,nTrials); %Initialize


for iTrial = 1:nTrials
    truncatedData = nonan(bothHands(:,:,iTrial));
    alignedPcScores(:,:,iTrial) = vectorstretch(truncatedData,newSize);
end

