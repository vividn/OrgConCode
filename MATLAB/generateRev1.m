function SubStructR1 = generateRev1(SubjectStructure)
% Generates a revision 1 subject structure from an original revision 0.
% Revision 1 has only most pertinent data. Data is truncated to the start
% and stop of the actual scene. Some data is smoothed. Intrinsic and
% extrinsic hand velocity is included.
%
% In all variables, the right hand and left hand will be separated out into
% different structures. The dimensions of each variable will be
% (time,variable second dimension,trial). The variable second dimension is
% whatever other dimension is needed to display the data (principal
% componenents, joint #, etc.)

% Threshold for truncation (as fraction of maximum average intrinsic hand
% velocity over the entire trial)
TRUNC_THRESHOLD_FACTOR = 0.03;

% Iterate by scene:
nScenes = length(SubjectStructure);
for iScene = 1:nScenes
    SceneStruct = SubjectStructure(iScene);
    
    %% First find the truncation points
    % To find those, must compute intrinsic hand velocity
    
    glovePC = cat(4,SceneStruct.Rh.glovePC,SceneStruct.Lh.glovePC);
    % glovePC(time,PC#,trial,hand)
    
    % Compute intrinsic hand velocity
    intrinsicV = computeSmoothedVelocity(glovePC);
    % intrinsicV(time,trial,hand)
    
    % Average over the 2 hands
    avgIV = mean(intrinsicV,3);
    % avgIV(time,trial)
    
    % Maximum over each trial
    maxAvgIV = max(avgIV,[],1);
    
    %Threshold is related to the max
    truncThreshold = maxAvgIV .* TRUNC_THRESHOLD_FACTOR;    
    
    %Find the truncation points for each trial
    beginEndTimes = thresholdindex(avgIV,truncThreshold,1);
    %beginEndTimes([first last],trial)
    
    %% Generate and Truncate
    % Now that the truncation points for each trial are known, begin
    % generating data, and truncating it.
    
    % Already generated glovePC, needs to be truncated
    glovePC = truncate(glovePC,beginEndTimes,3);
    
    % Already generated intrinsicV, needs to be truncated
    intrinsicV = truncate(intrinsicV,beginEndTimes,2);
    
    % Generate and truncate new x (time,trial,hand)
    x = cat(3,SceneStruct.Rh.x,SceneStruct.Lh.x);
    %x(time,trial,hand)
    x = truncate(x,beginEndTimes,2);
    
    % Generate and truncate new y (time,trial,hand)
    y = cat(3,SceneStruct.Rh.y,SceneStruct.Lh.y);
    %y(time,trial,hand)
    y = truncate(y,beginEndTimes,2);
    
    % Compute extrinsic hand velocity (already truncated)
    xy = cat(4,x,y);
    extrinsicV = computeSmoothedVelocity(xy);
    %extrinsicV(time,trial,hand)
    
    % Generate and truncate new glove joint data (time,trial,hand,jointNum)
    glove = cat(4,SceneStruct.Rh.glove,SceneStruct.Lh.glove);
    %glove(time,joint #,trial,hand)
    glove = truncate(glove,beginEndTimes,3);
    
    %% Build Structures
    %Put pertinent data into hand structures
    Rh = struct('x',x(:,:,1),...
                'y',y(:,:,1),...
                'glove',glove(:,:,:,1),...
                'glovePC',glovePC(:,:,:,1),...
                'intrinsicV',intrinsicV(:,:,1),...
                'extrinsicV',extrinsicV(:,:,1));
    Lh = struct('x',x(:,:,2),...
                'y',y(:,:,2),...
                'glove',glove(:,:,:,2),...
                'glovePC',glovePC(:,:,:,2),...
                'intrinsicV',intrinsicV(:,:,2),...
                'extrinsicV',extrinsicV(:,:,2));
    
    
    % Put hand structures into the new subject superstructure
    % Also, subject's initials
    name = SceneStruct.name;
    NewSceneStruct = struct('Rh',Rh,'Lh',Lh,'name',name);
    SubStructR1(iScene) = NewSceneStruct;
end



end


function truncatedData = truncate(data,beginEndTimes,trialDim)
% Takes data truncates each trial at the specified points then catenates
% the trials pack together, padding with NaNs at the end of trials if
% necessary.
% trialDim is the dimension where the trial # is stored

if nargin < 3
    trialDim = ndims(data)-1;
end

%Initialize output variable
truncatedData = [];

% Since beginEndTimes expects trials to be in dim2, shift dimensions
data = dimshift(data,trialDim,2);

nTrials = size(data,2);
for iTrial = 1:nTrials
    % Generates a range beginTime:endTime
    newTimeSegment = between(beginEndTimes,iTrial);
    newTrialData = data(newTimeSegment,iTrial,:,:);
    truncatedData = nancat(2,truncatedData,newTrialData);
end

% Shift dimensions back
truncatedData = dimshift(truncatedData,2,trialDim);
end