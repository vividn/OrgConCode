function permutedMatrix = dimshift(inputMatrix,dim)
% Permutes the specified dimension to the front of the matrix leaving the
% rest in order.
% For some operations with varying numbers of dimensions in the input, it
% can be useful to move a dimension of interest to the begining for
% coding's sake.
%
% Inputs: inputMatrix, any matrix with n-dimensions
% dim = the dimension to permute to the begining.
% If dim is negative, the function permutes the specified dimension back
% into its original place.
%
% Outputs: permutedMatrix, the new matrix with the dimensions rearranged

nDims = ndims(inputMatrix);

% Check for input validity
if nargin < 2
    error('Not Enough Inputs')
end

if or(dim == 0, abs(dim) > nDims)
    error('Invalid dimension argument')
end

if dim > 0
    newDimOrder = [dim, 1:(dim-1), (dim+1):nDims];
elseif dim < 0
    dim = -dim;
    newDimOrder = [2:dim, 1, (dim+1):nDims];
end

permutedMatrix = permute(inputMatrix,newDimOrder);