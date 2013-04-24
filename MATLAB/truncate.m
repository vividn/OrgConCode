%NOT COMPLETE
function truncated = truncate(M,t,nStd)
%the input of this should be the output of 'smooth diff'
%t is the approximate time of the static hands at beginning and end (in
%samples) try using a shorter time (like 50 samples) because some trials
%had very few samples in the beginning

%nStd is number of standard deviations above the mean you want to go
dataRH=M(:,:,1); dataLH=M(:,:,2);
newM=NaN(size(M));
for nTrial=1:size(M,2)
    RH=M(:,nTrial,1); 
    LH=M(:,nTrial,2); 
    RHn=nonan(RH);
    LHn=nonan(LH);
    
    %figure out how many NaNs to add on at end
    allnanrh=find(isnan(RH));
    for nNan=1:length(allnanrh)-1
        if allnanrh(nNan+1)-allnanrh(nNan)>1
            begnanrh=allnanrh(nNan);
            firstnanendrh=allnanrh(nNan+1);
        end
    end
    allnanlh=find(isnan(LH));
    for nNan=1:length(allnanlh)-1
           if allnanlh(nNan+1)-allnanlh(nNan)>1
            begnanlh=allnanlh(nNan);
            firstnanendlh=allnanlh(nNan+1);
        end
    end
    
    %get everything to match up
    if begnanrh-begnanlh ~=0
        if begnanrh-begnanlh>0
            RHn=vertcat(NaN(begnanrh-begnanlh,1),RHn);
        else LHn=vertcat(NaN(begnanlh-begnanrh,1),LHn);
        end
    end
    if firstnanendrh-firstnanendlh~=0
        if firstnanendrh-firstnanendlh>0
            LHn=vertcat(LHn,NaN(firstnanendrh-firstnanendlh,1));
        else RHn=vertcat(RHn,NaN(firstnanendlh-firstnanendrh,1));
        end
    end
    
    
%     start = find(RH>(nanmean(RH(1:t))+nanstd(RH(1:t))) & LH >(nanmean(LH(1:t)+nanstd(LH(1:t)))),1,'first');
%     finish = find(RH>(nanmean(RH(1:t))+nanstd(RH(1:t))) & LH >(nanmean(LH(1:t)+nanstd(LH(1:t)))),1,'last');
%     newM(:,nTrial,1)=vertcat(NaN(start-1,1),RH(start:finish),NaN(length(RH)-finish));
%     newM(:,nTrial,2)=vertcat(NaN(start-1,1),LH(start:finish),NaN(length(LH)-finish));

   
%     start=min(intersect(find(RHn>(mean(RHn(1:t))+std(RHn(1:t)))),find(LHn >(mean(LHn(1:t)+std(LHn(1:t)))))));
    start=min(vertcat(find(RHn>(nanmean(RHn(1:t))+nStd.*nanstd(RHn(1:t)))),find(LHn >(nanmean(LHn(1:t)+nStd.*nanstd(LHn(1:t)))))));
    finish=max(vertcat(find(RHn>(nanmean(RHn(1:t))+nStd.*nanstd(RHn(1:t)))),find(LHn >(nanmean(LHn(1:t)+nStd.*nanstd(LHn(1:t)))))));
%     finish = find(RHn>(mean(RHn(1:t))+std(RHn(1:t))) & LHn >(mean(LHn(1:t)+std(LHn(1:t)))),1,'last');
    newM(:,nTrial,1)=vertcat(NaN((start+min(begnanlh,begnanrh))-1,1),RHn(start:finish),NaN(length(RH)-(finish+min(begnanlh,begnanrh)),1));
    newM(:,nTrial,2)=vertcat(NaN((start+min(begnanlh,begnanrh))-1,1),LHn(start:finish),NaN(length(LH)-(finish+min(begnanlh,begnanrh)),1));
    clear RH LH RHn LHn start finish begnanlh begnanrh firstnanendrh firstnanendlh allnanrh allnanlh
end
truncated=newM;