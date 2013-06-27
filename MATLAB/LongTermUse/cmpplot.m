function axisHandleArray = cmpplot(data,dim,nCols,furcDim,nFurcs,titles)
% CMPPLOT offers a variety of tools for plotting over several axes.
% axisHandArray = cmpplot(data,dim,nCols,furcDim,nFurcs,titles);
%
% INPUTS:
% data: A matrix with any number of dimensions, or a cell array containing
%    matrices. If a cell array, cmpplot calls itself for each matrix,
%    meaning the data in each matrix will be in a new figure or group of
%    figures.
%
% dim(optional): The dimension along which to divide the data into subplots for
%    each figure. For example, if size(data) == [100,5,4], cmpplot(data,2)
%    makes a figure with 5 subplots, each with 4 line graphs on it.
%    cmpplot(data,3) makes a figure with 4 subplots, each with 5 line graphs on
%    it. Default: The last dimension of the matrix.
%
% nCols(optional): Number of columns of subplots. Use this to determine the
%    layout of the plotted graphs. Default: 2.
%
% furcDim(optional): If furcation of the data into separate figures is
%    desired, this variable specifies the dimension along which the data
%    will be divided. If more than 1 dimension of furcation is desired, use
%    furcate on the data directly: cmpplot(furcate(data,...)). Cannot use
%    furcation if a cell array is specified as input. Default: no
%    furcation occurs.
%
% nFurcs(optional): Number of furcations to perform on the data. The progam 
%    always furcates into evenly sized chunks. Default: 2 [if a furcDim is
%    specified, else no furcation will occur].
%
% titles(optional): A string (which will be used on every figure) or a cell
% array of strings, one of which will be used on each figure. The string may
% contain a '%d' (no quotes) which will insert the number of the figure in its
% place.
%
% OUTPUTS:
% axisHandleArray(if specified): an array of the axis_handle of every axis
% created. This can be used for easy en masse changing of paramaters of all
% the created axes.
%
% EXAMPLES:
% size(data) == [100 8 6]
%
% cmpplot(data)
% 1 figure, 6 subplots in 2 columns, 8 line graphs per subplot
%
% cmpplot(data,2)
% 1 figure, 8 subplots in 2 columns, 6 line graphs per subplot
%
% cmpplot(data,3,3,2,2,'Experiment %d')
% 2 figures, each with 6 subplots in 3 columns, 4 line graphs per subplot
% Each figure has a title that looks like: Experiment 1

% Input validation
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

if nargin < 1
error('Not enough inputs')
end
end
end
end
end

% Furcate the data as specified, leaving cell array. One cell for each
% figure. If data is already in cells, do not furcate, just pass data forward.
if ~iscell(data)
    nDims = ndims(data);
    furcateArgs = num2cell(ones(1,nDims)); %initialize
    furcateArgs{furcDim} = nFurcs; % Add the currect split number to the dim
    furcatedData = furcate(data,furcateArgs{:});
else
    furcatedData = data;
end

% Iterate through each cell, creating a new figure for each one.
nFigures = length(furcatedData(:));
iAxis = 0; % Initialize
for iFigure = 1:nFigures
    figure;
    figureData = furcatedData{iFigure};
    
    nDims = ndims(figureData);
    if nargin < 2
    dim = nDims; %The last dimension
    end
    
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
