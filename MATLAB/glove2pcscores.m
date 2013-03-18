function pcGlove = glove2pcscores(gloveData, avgHand, pcCoeffs)
% Calculates PC scores from glove data
%
% Glove data is in the form of the 3D matrix (timeTicks x Joint x Trial)
% For each trial and timepoint, this computes the principal component
% scores from the pcCoeffs. avgHand is a vector of the amount to subtract
% from each joint to set the 0 point for the hand.
%
% If either avgHand or pcCoeffs are not specified used the global default as
% specified in commonvars.

global PC_AVG PC_COEFFS;
if nargin < 3
    pcCoeffs = PC_COEFFS;
    if nargin < 2
        avgHand = PC_AVG;
    end    
end

%Principal component array initialize
nPrincipalComponents = size(pcCoeffs,1);
pcArray = zeros(nPrincipalComponents,17);
magnitudeArray = zeros(nPrincipalComponents,1);

for pc = 1:nPrincipalComponents;
    pcVector = pcCoeffs(pc,:);
    pcMagnitude = norm(pcVector);
    pcArray(pc,:) = pcVector ./ pcMagnitude;
    magnitudeArray(pc,:) = pcMagnitude;
end

%Get the difference in joint angles from the average hand shape.
%Additionally, compute projection along each of the principal components
nTimeTicks = size(gloveData,1);
nJoints = size(gloveData,2);
nTrials = size(gloveData,3);

pcGlove = nan(nTimeTicks,nPrincipalComponents,nTrials);

for trial = 1:nTrials
    for i = 1:nTimeTicks
        dataDiffFromAvg = gloveData(i,:,trial) - avgHand;
        for pc = 1:nPrincipalComponents
            %Dot product of unit pc vector and hand shape give projection
            pcGlove(i,pc,trial) = dot(dataDiffFromAvg,...
                pcArray(pc,:));
            %Divide by magnitude to get proportion to pc vector
            pcGlove(i,pc,trial) = pcGlove(i,pc,trial)./magnitudeArray(pc,:);
        end
    end
end

%And voila, principal component found