function matrixOut = nonan(matrixIn, dim)
%Removes indices along a dimension that have NaN values along any dimension.
%
%Takes a multidimensional matrix as input and looks along a single dimension.
%If the matrix contains a NaN value anywhere for a particular index in that
%dimension, that index is deleted. For instance given C, a (3x3x2 matrix):
% C =
% [1 2 3        [10  NaN 11
%  4 5 6         12  13  14
%  7 8 9]        15  16  17]
%
% nonan(C, 1) =
% [4 5 6        [12  13  14]
%  7 8 9]        15  16  17]
%
% nonan(C, 2) =
% [1 3          [10  11
%  4 6           12  14
%  7 9]          15  17]
%
% nonan(C,3) =
% [1 2 3
%  4 5 6
%  7 8 9]

if nargin < 2, dim = 1; end;

%Number of dimensions and vector of every other dimension
nDims = ndims(matrixIn);
otherDims = setdiff(1:nDims,dim);
nOperations = nDims - 1;

%Generates an eval string based on the dimensions to perform the necessary
%operation

evalStr1 = 'matrixIn(';
evalStr2 = repmat(':,',1,sum(otherDims < dim));
evalStr3 = repmat('all(',1,nOperations);
evalStr4 = '~isnan(matrixIn)';
evalStr5 = num2str(otherDims,',%d)');
evalStr6 = repmat(',:',1,sum(otherDims > dim));
evalStr7 = ');';

evalStr = [evalStr1 evalStr2 evalStr3 evalStr4 evalStr5 evalStr6 evalStr7];
%E.g., if ndims = 3 and dim = 2, final string should look like this:
%matrixIn(:,all(all(~isnan(matrixIn),1),3),:);

%This collapses along the other dimensions and only counts indices where no
%NaN's occur.

matrixOut = eval(evalStr);
