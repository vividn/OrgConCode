function outputVector = bufferedthreshold(inputVector,threshold,buffer)
% If the value > threshold+buffer returns true, value < threshold-buffer
% returns false, if within the buffer, maintains the whatever the previous
% value is. Operates similar to a hardware bit.

if ~isvector(inputVector)
    error('bufferedthreshold:Input must be a vector')
end

trueIndices = find(inputVector > threshold + buffer);
falseIndices = find(inputVector < threshold - buffer);

% Determines if the first index falls into one of these categories, if not
% assigns it a false value so that interp1 won't do nans
if ~ismember(1,[trueIndices; falseIndices])
    falseIndices = [1; falseIndices];
end

% Fills in the last value manually so that interp1 will work correctly
if max(trueIndices) > max(falseIndices)
    trueIndices = [trueIndices; length(inputVector)];
else
    falseIndices = [falseIndices; length(inputVector)];
end

allIndices = [falseIndices; trueIndices];
allValues = cat(1,false(length(falseIndices),1),true(length(trueIndices),1));

unorderedMatrix = cat(2,allIndices,allValues);
orderedMatrix = sortrows(unorderedMatrix);

orderedIndices = orderedMatrix(:,1);
orderedValues = orderedMatrix(:,2);

outputVector = orderedValues(floor(interp1(orderedIndices,...
    1:length(orderedIndices),1:length(inputVector))));


