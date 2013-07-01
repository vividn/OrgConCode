function velocitymat = computevelocity(t,varargin)
% v_data(t, D1, D2,...) computes velocity of points through N-dimensional
% space where D1, D2... is data in the respective dimension. v =
% sqrt(dD1^2+dD2^2+...) where dD1 is the change in time of the data in
% dimension 1

dt = t(2:end,:)-t(1:end-1,:);

dimsqsum = 0; %Dimension square sum

for i = 1:length(varargin)
    dim = varargin{i}; %Grabs the dimensional data
    ddim = dim(2:end,:)-dim(1:end-1,:); %Change in data
    twoDdt = repmat(dt,1,size(ddim,2)); % Makes a dt matrix for element by element division
    dimsq = (ddim./twoDdt).^2; %Divide by Change in time, square
    dimsqsum = dimsqsum + dimsq; %Add to running sum
end
rootdimsqsum = dimsqsum.^0.5; %Sqrt
rootdimsqsum(2:end+1,:)=rootdimsqsum(1:end,:); %shifts the matrix down one
rootdimsqsum(1,:) = NaN; %Puts NaNs in the first row
velocitymat = rootdimsqsum;