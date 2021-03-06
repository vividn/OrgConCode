function consolidatedMatrix = consolidatetrial(SceneStructure,trial)
%Consolidates many key features of one trial
%Output is one matrix where the second dimension looks like this
%1-3 PC's of RH
%4-6 PC's of LH
%7-9 x,y,z of RH
%10-12 x,y,z of LH

consolidatedMatrix = cat(2,...
    SceneStructure.Rh.glovePC(:,:,trial),...
    SceneStructure.Lh.glovePC(:,:,trial),...
    SceneStructure.Rh.x(:,trial),...
    SceneStructure.Rh.y(:,trial),...
    SceneStructure.Rh.z(:,trial),...
    SceneStructure.Lh.x(:,trial),...
    SceneStructure.Lh.y(:,trial),...
    SceneStructure.Lh.z(:,trial));