function segmentTimes = segmentScene1(SceneStructure)


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

minDist = 2000; %For use with the parameter 'MINPEAKDISTANCE' in findpeaks

nSegments = min([size(eventNames,1),size(markType,1),size(approxTime,1)]);
nTrials = size(SceneStructure.trialLengths,1);


for iTrial = 1:nTrials
    % Initialize outputvariable
    segmentTimes = zeros(nSegments,nTrials);
    
    rhXVals = SceneStructure.Rh.x(:,iTrial);
    rhYVals = SceneStructure.Rh.y(:,iTrial);
    lhXVals = SceneStructure.Lh.x(:,iTrial);
    lhYVals = SceneStructure.Lh.y(:,iTrial);
    
    
    
    
    for iSegment = 1:nSegments
        time = approxTime(iSegment)*1000;
        name = eventNames(iSegment);
        
        handDimStr = markType(iSegment,1:2);
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
        
        maxOrMin = markType(iSegment,4:6);
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
        title([eventNames{iSegment} ' - ' markType(iSegment,:)])
        a = input('0=red line,+1 = one to the right, etc.');
        if isempty(a),a=0;end
        segmentTimes(iSegment,iTrial) = indices(I+a);
    end
end