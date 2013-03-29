function [firstTime lastTime] = differentialthreshold(M,threshold,timeDim,avgDim)
% Takes the derivative and finds the first and last time the value
% > threshold.
%
% differentialthreshold(M,timeDim,avgDim) differentiates M along timeDim,
% then averages along avgDim (no average is taken if avgDim is not
% supplied).
%
% Returns the first and the last index.
% All dimensions besides timeDim and avgDim are the same.

if nargin < 2
    error('differentialthreshold:Inputs',['Not enough inputs. Must at least' ...
        ' supply a matrix and a threshold value.'])
end

if nargin < 3
    timeDim = 1;
end

diffM = abs(diff(M,1,timeDim));

%Turns NaN's to 0's for averageing and finding the indices
diffM(isnan(diffM)) = 0;

if nargin > 3
    avgDiffM = mean(diffM,avgDim);
else
    avgDiffM = diffM;
end

[firstTime lastTime] = thresholdindex(avgDiffM,threshold,timeDim);