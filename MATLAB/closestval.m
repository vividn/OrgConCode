function [C,I] = closestval(X,value)
%Closestval, component closest to specified value
%   For vectors, closestval(X,value) is the element in X closest to value.
%   Input must be a vector. Output [C,I], where C is the value that is
%   closest and I is the index.

if ~isvector(X)
    error('closestval: input must be a vector.')
end

difference = X - value;
[C,I] = min(abs(difference));
C = C*sign(difference(I))+value;