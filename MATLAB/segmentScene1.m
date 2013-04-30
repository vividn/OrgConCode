function segmentTimes = segmentScene1(SceneStructure,trial)


% Scene 1 Breakdown
eventNames = {'Touch Placemat 1';
              'Touch Placemat 2';
              'Touch Plates';
              'Touch Napkins';
              'Place Napkin 1';
              'Place Napkin 2';
              'Place Forks';
              'Grab Pitcher';
              'Set down pitcher'};

markType = ['lx min';
            'lx min';
            'ly max';
            'ly max';
            'lx max';
            'lx max';
            'rx max';
            'ry max';
            'ry max'];

approxTime = [2;6;11;15;19;23;27;33;40];
         

rhXVals = SceneStructure.Rh.x(:,trial);
rhYVals = SceneStructure.Rh.y(:,trial);
lhXVals = SceneStructure.Lh.x(:,trial);
lhYVals = SceneStructure.Lh.y(:,trial);

minDist = 2000;

for i = 1:length(approxTime)
    time = approxTime(i)*1000;
    name = eventNames(i);
    
    handDimStr = markType(i,1:2);
    switch handDimStr
        case 'lx'
            data = lhXVals;
        case 'ly'
            data = lhYVals;
        case 'rx'
            data = rhXVals;
        case 'ry'
            data = rhYVals;
        otherwise
            error('markTypes misconfigured');
    end
    
    maxOrMin = markType(i,4:6);
    switch maxOrMin
        case 'max'
            mData = data;
        case 'min'
            mData = -data; %Flip data for the peak analysis to find local mins
        otherwise
            error('markTypes misconfigured');
    end
    
    [~,indices] = findpeaks(mData,'MINPEAKDISTANCE',minDist);
    [C,I] = closestval(indices,time);
    clf
    plot(data)
    vline(indices(max(I-2,1):min(I+2,length(indices))),'k--')
    vline(C,'r-')
    pause
end