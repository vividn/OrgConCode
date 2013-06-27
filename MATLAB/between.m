function allValues = between(beginEndTimes,varargin)
% between generates all the values between a first and last value generated
% by another program. This is useful for truncation where begining and end
% times are known and you wish to index the set.
%
% between(beginEndTimes,indexDim2,indexDim3,...)
% INPUTS:
% beginEndTimes: a matrix where the first dimension is of size 2. The other
%     dimensions correspond to the position in the matrix where the times
%     were originally derived from.
%     beginEndTimes(1,:,...) is the begining time, beginEndTimes(2,:,...)
%     is the ending time.
%
% indexDim2 , etc: the rest of the values specified correspond to the
%     indices of the rest of the matrix. 
%
% OUTPUTS:
% allValues: the range between the beginning time and the ending time from
%     the first dimension of beginEndTimes.
%
% EXAMPLES:
% a = [7  13  4 3;
%      15 20  8 12];
%
% between(a,4) == 3:12;

nDims = ndims(beginEndTimes);
if nDims ~= nargin
    error('Must specify exactly one index for each dimension beyond 1')
end

beginTime = beginEndTimes(1,varargin{:});
endTime = beginEndTimes(2,varargin{:});

allValues = beginTime:endTime;
