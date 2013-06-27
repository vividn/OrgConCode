function condensedData = condense(data,nDims,format)
% reduces the number of dimensions in some data, either by reshaping down
% into a smaller number of dimensions or creating a cell array of the
% remaining dimensions.
%
% condensedData = condense(data,nDims,format)
%
% INPUTS:
% data = a matrix of any number of dimensions
%
% nDims = number of dimensions desired in the output. Default = nDims - 1
%
% format = either 'cell' or 'matrix'. If 'cell', Each combination of values
%     for the dimensions above nDims is turned into a single cell in a cell
%     array. 'matrix' reshapes so that the upper dimensions are added to the
%     largest kept dimension. Default = 'matrix'.
%
% OUTPUTS:
% condensedData = the cell or the matrix after condensing.
%
% EXAMPLES:
% size(a) == [100,5,3,2];
%
% b = condense(a,2,'matrix');
% size(b) == (100,30)
%
% c = condense(a,2,'matrix');
% size(c) == {3-by-2 cell array};
% size(c{any}) == [100 5];

if nargin < 3
    format = 'matrix';
    if nargin < 2
        nDims = ndims(data)-1;
    end
end

dataSize = num2cell(size(data));




switch format
    case 'matrix'
        args = dataSize(1:nDims - 1);
        condensedData = reshape(data,args{:},[]);
    case 'cell'
        args = dataSize;
        args(1:nDims) = {1};
        condensedData = furcate(data,args{:});
    otherwise
        error('Invalid format parameter');
end
