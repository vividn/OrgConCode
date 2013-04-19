%NOT COMPLETE
function truncated = truncate(M,t)
%the input of this should be the output of 'smooth diff'
%t is the approximate time of the static hands at beginning and end (in
%samples)
dataRH=M(:,:,1); dataLH=M(:,:,2);
newM=[];
for nTrial=1:size(M,2)
    RH=M(:,nTrial,1); 
    LH=M(:,nTrial,2); 
    start = find(RH>(nanmean(RH(1:t))+nanstd(RH(1:t))) & LH >(nanmean(LH(1:t)+nanstd(LH(1:t)))),1,'first');
    finish = find(RH>(nanmean(RH(1:t))+nanstd(RH(1:t))) & LH >(nanmean(LH(1:t)+nanstd(LH(1:t)))),1,'last');
    newM(:,nTrial,1)=vertcat(NaN(start-1,1),RH(start:finish),NaN(length(RH)-finish,1));
    newM(:,nTrial,2)=vertcat(NaN(start-1,1),RH(start:finish),NaN(length(RH)-finish,1));
    clear RH LH start finish
end
truncated=newM;