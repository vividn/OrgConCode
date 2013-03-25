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

[nTimeTicks, ~,nTrials] = size(gloveData);

pcGlove = nan(nTimeTicks,nPrincipalComponents,nTrials);

for pc = 1:nPrincipalComponents
    dataDiffFromAvg = bsxfun(@minus,gloveData,avgHand);
    % Repeated pc components for simultaneous dot product
    repeatedPc = repmat(pcArray(pc,:),[nTimeTicks,1,nTrials]);    
    %Dot product of unit pc vector and hand shape give projection
    pcGlove(:,pc,:) = dot(dataDiffFromAvg,repeatedPc,2);
end

%Divide by magnitude to get proportion to pc vector
pcGlove = pcGlove ./ pcMagnitude;