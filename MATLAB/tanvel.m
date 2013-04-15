function tangentialVelocity = tanvel(data,timeDim,dimDim)
%Computes the tangential velocity from multi dimensional data
%Input should be a multidimensional matrix, timeDim is the dimension to
%differentiate along, dimDim, is the matrix dimension where the different
%spatial dimensions are

if nargin < 3
    dimDim = 2;
    if nargin < 2
        timeDim = 1;
        if nargin < 1
            error('tanvel: not enough inputs')
        end
    end
end

dData = diff(data,1,timeDim);
tangentialVelocity = sqrt(sum(dData.^2,dimDim));