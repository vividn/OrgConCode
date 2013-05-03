function axisHandleArray = cmpplot(data,dim,nCols)
% cmpplot plots each matrix along a dimension on many axes using subplot
% inputs Data, dim = the dimension which to separate and plot on multiple
% subplots; cols = the number of columns of subplots.
% output (if specified) will be an array of the function handles of all the
% plots.

nDims = length(size(data));

if nargin < 3
    nCols = 2;
    if nargin < 2
        dim = nDims; %The last dimension
    end
end
    
allDims = 1:nDims;
otherDims = setdiff(allDims, dim);

permuteData = permute(data,[dim otherDims]); %shifts splitting dim to front 

p = size(permuteData,1);
rows = ceil(p/nCols);
for i=1:p
    axisHandleArray(i) = subplot(rows,nCols,i);
    plot(squeeze(permuteData(i,:,:)))
end

% Don't return anything if no outputs provided
if nargout == 0
    clearvars axisHandleArray
end
