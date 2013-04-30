function [C,I] = closestval(X,value,dim)
%Closestval, component closest to specified calue
%   For vectors, closestval(X,value) is the element in X closest to value.
%   For matrices, closestval(X,value) is a row vector containing the
%   elements from each column that are closest to the value.
%   Specify closestval(X,value,dim), to specify along which dimension to
%   find the closest value

if nargin < 3
    if isrow(X)
        dim = 2;
    else
        dim = 1;
    end
end

difference = X - value;
[C,I] = min(abs(difference),[],dim);
C = C + value;