function segmentTimes = segmentScene1(SceneStructure)
close all
figure
maximize
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

approxTime = [2.2;6.2;10;14.5;19.3;22.1;26.7;32.6;39.4];

minDist = 2000; %For use with the parameter 'MINPEAKDISTANCE' in findpeaks

nSegments = min([size(eventNames,1),size(markType,1),size(approxTime,1)]);
nTrials = size(SceneStructure.trials,2);


% Initialize outputvariable
segmentTimes = zeros(nSegments,nTrials);

for iTrial = 1:nTrials
    
    rhXVals = SceneStructure.Rh.x(:,iTrial);
    rhYVals = SceneStructure.Rh.y(:,iTrial);
    lhXVals = SceneStructure.Lh.x(:,iTrial);
    lhYVals = SceneStructure.Lh.y(:,iTrial);
    
    
    display('0=red line,+1 = one to the right, etc.')
    
    for iSegment = 1:nSegments
        time = approxTime(iSegment)*1000;
        thisEventName = eventNames(iSegment);
        
        handDimStr = markType(iSegment,1:2);
        switch handDimStr
            case 'lx'
                data = lhXVals;
                plotColor = [0,0,1]; %Blue;
            case 'ly'
                data = lhYVals;
                plotColor = [0,0.6,0]; %Dark Green
            case 'rx'
                data = rhXVals;
                plotColor = [.66,0,.66]; %Purple
            case 'ry'
                data = rhYVals;
                plotColor = [1,.5,0]; %Orange
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
        
        a = minDist;
        
        while a > 10;
            [~,indices] = findpeaks(mData,'MINPEAKDISTANCE',minDist);
            [C,I] = closestval(indices,time);
            clf
            plot(data,'Color',plotColor)
            vline(indices(max(I-2,1):min(I+2,length(indices))),'k--')
            vline(C,'r-')
            title([num2str(iSegment) '. ' thisEventName ' - '...
                markType(iSegment,:)],'fontSize',30)
            a = input('?:');
            if isempty(a),a=0;end
            if a > 10
                minDist = a;
            end
        end
        segmentTimes(iSegment,iTrial) = indices(I+a);
    end
end