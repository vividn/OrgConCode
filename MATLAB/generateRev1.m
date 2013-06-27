function SubStructR1 = generateRev1(SubjectStructure)
% Generates a revision 1 subject structure from an original revision 0.
% Revision 1 has only most pertinent data. Data is truncated to the start
% and stop of the actual scene. Some data is smoothed. Intrinsic and
% extrinsic hand velocity is included.
%
% Additionally, order of dimensions is more consistent in revision 1.
% The first 2 dimensions in *every variable* will be (time,trial)
% The third dimension, if it exists, will be the hand(1 for RH, 2 for LH).
% Other variable come after these 3.

% Threshold for truncation (as fraction of maximum average intrinsic hand
% velocity over the entire trial)
TRUNC_THRESHOLD_FACTOR = 0.03;

% Iterate by scene:
nScenes = length(SubjectStructure);
for iScene = 1:nScenes
    SceneStruct = SubjectStructure(iScene);
    
    % First find the truncation points
    % To find those, must compute intrinsic hand velocity
    
    glovePC = cat(4,SceneStruct.Rh.glovePC,SceneStruct.Lh.glovePC);
    % Rearrange dimensions to be in the new correct order
    glovePC = permute(glovePC,[1,3,4,2]);
    % Compute intrinsic hand velocity
    intrinsicV = computeSmoothedVelocity(glovePC);
    avgIV = mean(intrinsicV,3);    
    % Maximum over each trial
    maxAvgIV = max(avgIV,[],1);    
    %Threshold is related to the max
    truncThreshold = maxAvgIV .* TRUNC_THRESHOLD_FACTOR;    
    %Find the truncation points for each trial
    beginEndTimes = thresholdindex(avgIV,truncThreshold,1);
    
    % Now that the truncation points for each trial are known. Begin
    % generating data, and truncating it.
    
    % Already generated glovePC, needs to be truncated
    glovePC = truncate(glovePC,beginEndTimes);
    
    % Already generated intrinsicV, needs to be truncated
    intrinsicV = truncate(intrinsicV,beginEndTimes);
    
    % Generate and truncate new x (time,trial,hand)
    x = cat(3,SceneStruct.Rh.x,SceneStruct.Lh.x);
    x = truncate(x,beginEndTimes);
    
    % Generate and truncate new y (time,trial,hand)
    y = cat(3,SceneStruct.Rh.y,SceneStruct.Lh.y);
    y = truncate(y,beginEndTimes);
    
    % Compute extrinsic hand velocity (already truncated)
    xy = cat(4,x,y);
    extrinsicV = computeSmoothedVelocity(xy);
    
    % Generate and truncate new glove joint data (time,trial,hand,jointNum)
    glove = cat(4,SceneStruct.Rh.glove,SceneStruct.Lh.glove);
    % Rearrange dimensions
    glove = permute(glove,[1,3,4,2]);
    glove = truncate(glove,beginEndTimes);
    
    % Put pertinent data in the new subject structure
    SceneStruct = struct('x',x,'y',y,'glove',glove,'glovePC',glovePC,...
        'intrinsicV',intrinsicV,'extrinsicV',extrinsicV);
    SubStructR1(iScene) = SceneStruct;
end



end


function truncatedData = truncate(data,beginEndTimes)
% Takes data truncates each trial at the specified points then catenates
% the trials pack together, padding with NaNs at the end of trials if
% necessary.
% Data MUST be in the format data(time,trial,...)

%Initialize output variable
truncatedData = [];

nTrials = size(data,2);
for iTrial = 1:nTrials
    % Generates a range beginTime:endTime
    newTimeSegment = between(beginEndTimes,iTrial);
    newTrialData = data(newTimeSegment,iTrial,:,:);
    truncatedData = nancat(2,truncatedData,newTrialData);
end
end