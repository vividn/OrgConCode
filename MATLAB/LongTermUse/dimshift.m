function permutedMatrix = dimshift(inputMatrix,dim,newDim)
% Permutes the specified dimension to the front of the matrix leaving the
% rest in order.
% For some operations with varying numbers of dimensions in the input, it
% can be useful to move a dimension of interest to the begining for
% coding's sake.
%
% Inputs:
% inputMatrix, any matrix with n-dimensions
%
% dim = the dimension to permute to the location of newDim
%
% newDim = the new location for the dimension to reside. Default: 1
%     (the beginning)
%
% Outputs: permutedMatrix, the new matrix with the dimensions rearranged

nDims = ndims(inputMatrix);

% Check for input validity
if nargin < 3
    newDim = 1;
if nargin < 2
    error('Not Enough Inputs')
end
end

if dim <= 0 || newDim <= 0 || dim > nDims || newDim >nDims
    error('Invalid dimension argument')
end

if newDim > dim
    newDimOrder = [1:(dim-1), (dim+1):newDim, dim, (newDim+1):nDims];
elseif newDim < dim
    newDimOrder = [1:(newDim-1), dim, newDim:(dim-1), (dim+1):nDims];
else
    % Dimensions should be the same
    newDimOrder = 1:nDims;
end

permutedMatrix = permute(inputMatrix,newDimOrder);