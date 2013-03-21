function Z = standardize(M,dim)
%Standardizes (calculates the z-score) along a given dimension.
%Disregards NaNs only if function nonan exists.

if nargin <2;dim = 1;end

% Check in nonan exists, if yes, program can disregard NaNs
nonanExists = which('nonan');

if nonanExists
    avg = mean(nonan(M,dim),dim);
    stdDev = std(nonan(M,dim),0,dim);
else
    avg = mean(M,dim);
    stdDev = std(M,0,dim);
end

Z = bsxfun(@rdivide,bsxfun(@minus,M,avg),stdDev);
