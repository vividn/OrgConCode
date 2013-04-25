function truncated = truncate(M,percent)
%use output from smooth diff
%percent is what percentage of the max you want your threshold to be (i.e.
%0.02)
newM=NaN(size(M));
for nTrial=1:size(M,2)
    RHn=nonan(M(:,nTrial,1));
    LHn=nonan(M(:,nTrial,2));
    peak_r=max(RHn); peak_l=max(LHn);
    [first_r last_r] =thresholdindex(RHn,percent*peak_r);
    [first_l last_l] =thresholdindex(LHn,percent*peak_l);
     %figure out how many NaNs to add on at end
    allnanrh=find(isnan(M(:,nTrial,1)));
    for nNan=1:length(allnanrh)-1
        if allnanrh(nNan+1)-allnanrh(nNan)>1
            begnanrh=allnanrh(nNan);
        end
    end
    allnanlh=find(isnan(M(:,nTrial,2)));
    for nNan=1:length(allnanlh)-1
           if allnanlh(nNan+1)-allnanlh(nNan)>1
            begnanlh=allnanlh(nNan);
        end
    end
    newM(:,nTrial,1)=vertcat(NaN((first_r+begnanrh)-1,1),RHn(first_r:last_r),NaN(size(M,1)-(last_r+begnanrh),1));
    newM(:,nTrial,2)=vertcat(NaN((first_l+begnanlh)-1,1),RHn(first_l:last_l),NaN(size(M,1)-(last_l+begnanlh),1));
    clear RHn LHn peak_r peak_l first_r first_l last_r last_l allnanrh allnanlh begnanrh begnanlh
end
truncated=newM;
