function map = morelines(n)
%MORELINES  Color map with more line colors.
%   MORELINES(M) returns an M-by-3 matrix containing a "ColorOrder"
%   colormap. Offers an expanded 18-color repeating selection over the
%   standard color set of only 7.
%
%
%   For example, to set the colormap of the current figure:
%
%       colormap(morelines)
%


c = [0,0,1;    %Blue
    0,.6,0;    %Dark Green
    1,0,0;     %Red
    0,1,1;     %Cyan
    1,0,1;     %Magenta
    .85,.85,0; %Yellow
    0,0,0;     %Black
    1,.5,0;    %Orange
    .66,0,.66; %Purple    
    0,1,0;     %Green
    .5,0,0;    %Dark Red
    .75,.5,1;  %Lavender
    1,.75,.5;  %Light Orange
    .5,.5,.5;  %Grey (50%)
    1,.75,1;   %Pink
    0,0,.6;    %Dark Blue
    .75,1,0;   %Yellow Green
    .8,.8,.8]; %Grey (80%)

if nargin<1, n = size(c,1); end

map = c(rem(0:n-1,size(c,1))+1,:);