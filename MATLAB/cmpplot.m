function axisHandleArray = cmpplot(data,dim,nCols,furcDim,nFurcs,titles)
% cmpplot plots each matrix along a dimension on many axes using subplot
% inputs Data, dim = the dimension which to separate and plot on multiple
% subplots; cols = the number of columns of subplots.
% output (if specified) will be an array of the function handles of all the
% plots.

nDims = length(size(data));

if nargin < 6
titles = '';
if nargin < 5
nFurcs = 2;
if nargin < 4
% Bifurcate if a furcation dimension is specified, otherwise, none
nFurcs = 1;
furcDim = 1;
if nargin < 3
nCols = 2;
if nargin < 2
dim = nDims; %The last dimension
if nargin < 1
error('Not enough inputs')
end
end
end
end
end
end

% Furcate the data as specified, leaving cell array. One cell for each
% figure.

furcateArgs = num2cell(ones(1,nDims)); %initialize
furcateArgs{furcDim} = nFurcs; % Add the currect split number to the dim
furcatedData = furcate(data,furcateArgs{:});

% Iterate through each cell, creating a new figure for each one.
nFigures = length(furcatedData(:));
iAxis = 0; % Initialize
for iFigure = 1:nFigures
    figure;
    figureData = furcatedData{iFigure};
    
    permuteData = dimshift(figureData,dim); %shifts splitting dim to front
    
    p = size(permuteData,1);
    rows = ceil(p/nCols);
    for i=1:p
        iAxis = iAxis + 1;
        axisHandleArray(iAxis) = subplot(rows,nCols,i);
        plot(squeeze(permuteData(i,:,:,:)))
    end
    if isempty(titles)
    elseif iscell(titles)
        suptitle(titles{iFigure});
    else
        suptitle(sprintf(titles,iFigure))
    end
end
    
% Don't return anything if no outputs provided
if nargout == 0
    clearvars axisHandleArray
end
