function sceneGlance(SceneStructure,trial)
% makes 2x1 subplot. Plots x,y of the left hand in the top graph in blue
% and green, respectively. Plots x,y of the right hand in the bottom graph
% in purple and orange, respectively.

if nargin < 2
    trial = 1;
end

figure;

%Left hand
subplot(2,1,1);
hold on;
lhData = SceneStructure.Lh;
plot(lhData.x(:,trial),'Color',[0,0,1]);  %LH x in blue
plot(lhData.y(:,trial),'Color',[0,.6,0]); %LH y in dark green

%Right hand
subplot(2,1,2);
hold on;
rhData = SceneStructure.Rh;
plot(rhData.x(:,trial),'Color',[.66,0,.66]); %RH x in purple
plot(rhData.y(:,trial),'Color',[1,.5,0]);     %RH y in orange