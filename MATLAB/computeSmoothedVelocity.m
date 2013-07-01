function velocity = computeSmoothedVelocity(data,timeDim,orthoDim)
% computes the intrinsic or extrinsic velocity of the two hands using the
% principal component data or the spatial location, respectively.
% First, smoothes the data using sgolayfilt, then
% differentiates, smoothes again, and computes the rootsumsquare of the
% result to find the tangential velocity.
%
% velocity = computeSmoothedVel(data)
%
% INPUTS:
% pcScores: the principal component scores over one or more trials (all
%     are processed together).
%
% timeDim: The dimension along which to differentiate. Default = 1
%
% orthoDim: the dimension with orthogonal components (be it principal components
%     or spatial dimensions) that are used in the velocity calculation.
%     Default = 2
%
% OUTPUS:
% velocity: the computed intrisic velocity based on the input dimension scores.

% k in sgolayfilt
GOLAY_ORDER = 2;

% f in sgolayfilt
GOLAY_FRAMESIZE = 201;

if nargin < 3
    orthoDim = 2;
    if nargin < 2
        timeDim = 1;
    end
end

% Smooth pc scores
pcSmooth = sgolayfilt(data,GOLAY_ORDER,GOLAY_FRAMESIZE);

% Differentiate
dPC = diff(pcSmooth,1,timeDim);

% Smooth again
dPcSmooth = sgolayfilt(dPC,GOLAY_ORDER,GOLAY_FRAMESIZE);

% Root-Sum-Square
velocity = sqrt(sum(dPcSmooth.^2,orthoDim));

% Remove now-extraneous dimension
velocity = squeeze(velocity);