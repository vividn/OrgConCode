function newVector = vectorstretch(inputVector,newLength)
%Takes a vector of any length and stretch or compresses it to a new length
% vectorstretch(inputVector,newLength) outputs the inputVector, but with
% the length changed. Primarily uses interp1.
% If the input is an array scales along the first dimension

originalLength = size(inputVector,1);

%Correspondance between inputVector and indices in newVector
incrementValue = (newLength - 1) / (originalLength - 1);
oldIndices = 1:incrementValue:newLength;

newIndices = 1:newLength;

newVector = interp1(oldIndices,inputVector,newIndices);