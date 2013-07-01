function [firstLastIndex] = thresholdindex(M,threshold,timeDim)
% Finds the first/last index in M where the value exceeds a threshold value
%
% [firstLastIndex] = thresholdindex(M,threshold,dim)
% INPUTS:
% M: any matrix of any size
%
% threshold: The program finds the first and last time the function goes
%     above this value. If it never does, it returns the very first (1) and
%     last index of the matrix.
%
% timeDim: the time dimension. That is, the dimension which the program
%     searches along for the threshold index.
%
% OUTPUTS:
% firstLastIndex: All other dimensions being equal to M in size, dim is now
%    of size 2. The first value is the first time the data pass over the
%    threshold. The second is the last value. The rest of the dimensions
%    correspond to the orginal matrix.

if nargin < 3
    timeDim = 1;
end

thresholdExceded = bsxfun(@gt,M,threshold);

%First time the threshold is exceeded
[~,firstIndex] = max(thresholdExceded,[],timeDim);

%Last time the threshold is exceeded
[~,indicesFromEnd] = max(flipdim(thresholdExceded,timeDim),[],timeDim);
lastIndex = size(M,timeDim) - indicesFromEnd;

firstLastIndex = cat(timeDim,firstIndex,lastIndex);