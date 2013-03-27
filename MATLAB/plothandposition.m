function plothandposition(handData,trialNum)
%Plots the trace of what the hand does over time in the x and y axes. Data
%is colored by the velocity it is traveling at the time (scaled
%logistically for better coloring)

xData = handData.x(:,trialNum);
yData = handData.y(:,trialNum);
vData = logistic(standardize(handData.v(:,trialNum)));

scatter(xData,yData,10,vData,'filled')
xlabel('X-axis (cm)')
ylabel('Y-axis (cm)')

axis equal
