function cellOutput = furcate(data, varargin)
% furcate divides up a matrix into equal components and puts each component
% into a cell array. Primarily uses mat2cell, but does the division for the
% user to make use easy.
%
% Inputs
% data: any matrix
% varargin: how many furcations each dimension should have.
%
% Outputs
% cellOutput: cellArray of size (nFurcs1,nFurcs2,...)
%
% Example:
% a = rand(6,3,8,4);
% b = furcate(a,1,2,3,2); % Produces a cell array
% size(b) == [1,2,3,2]
% size(b{1,1,:,1}) == {6,2,3,2 cell}, {6,2,3,2 cell}. {6,2,2,2 cell}

nDims = ndims(data);
nArgs = length(varargin);

if nArgs > nDims
    error('Too many arguments')
end

if nArgs < nDims
    varargin(nArgs+1:nDims) = {1}; % Don't furcate the remaining dimensions
    if nArgs == 0
        varargin{1} = 2; % Bifurcate first dimension if nothing specified
    end
end

mat2cellArgs = cell(1,nDims); %Initialize variable

for iDim = 1:nDims
    nFurcs = varargin{iDim};
    dimSize = size(data,iDim);
    furcSize = floor(dimSize/nFurcs);
    remainder = rem(dimSize,nFurcs);
    sizeMatrix = repmat(furcSize,1,nFurcs);
    % Distribute the remainder through the first cells in that dimension
    sizeMatrix(1:remainder) = furcSize + 1;
    mat2cellArgs{iDim} = sizeMatrix;
end

cellOutput = mat2cell(data,mat2cellArgs{:});