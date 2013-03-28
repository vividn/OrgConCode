function axisHandleArray = cmpplot(data,dim)
% cmpplot plots each matrix along a dimension on many axes using subplot

nDims = length(size(data));

if nargin < 2
    dim = nDims; %The last dimension
end

allDims = 1:nDims;
otherDims = setdiff(allDims, dim);

permuteData = permute(data,[dim otherDims]); %shifts splitting dim to front 

cols = 2; %Number of columns in the subplot space

p = size(permuteData,1);
rows = ceil(p/cols);
for i=1:p
    axisHandleArray(i) = subplot(rows,cols,i);
    plot(squeeze(permuteData(i,:,:)))
end

% Don't return anything if no outputs provided
if nargout == 0
    clearvars axisHandleArray
end
