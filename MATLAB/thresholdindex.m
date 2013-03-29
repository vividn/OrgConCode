function [firstIndex lastIndex] = thresholdindex(M,threshold,dim)
% Finds the first/last index in M where the value exceeds a threshold value
% [firstIndex lastIndex] = thresholdindex(M,threshold)
% first index is the first time (or times if multidimensional) where the
% value of M exceeds the threshold along dimension dim.

if nargin < 3
    dim = 1;
end

%Get rid of NaN's if function nonan exists
if which('nonan')
    M = nonan(M,dim);
end

thresholdExceded = M > threshold;

%First time the threshold is exceeded
[~,firstIndex] = max(thresholdExceded,[],dim);

%Last time the threshold is exceeded
[~,indicesFromEnd] = max(flipdim(thresholdExceded,dim),[],dim);
lastIndex = size(M,dim) - indicesFromEnd;