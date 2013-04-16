function veloc = smoothdiff(M,k,f)
%the input to this function should be a nx6x8 Matrix, where n is the number
%used to smooth the PC data in the 'alignpcscores' function (i.e.
%M=alignpcscores(MF3(1,scene),n) where 'scene' is the scene number 1-3)

%The output of this function is an n-1x8x2 Matrix, with veloc(:,:,1)
%corresponding to the velocity from the right hand and veloc(:,:,2)
%corresponding to the velocity from the left hand.
veloc=NaN(size(M,1)-1,size(M,3),2);%veloclh=[];
    for nTrial=1:size(M,3)
        
            veloc(:,nTrial,1)=sqrt((sgolayfilt(diff(sgolayfilt(M(:,1,nTrial),k,f)),k,f)).^2+(sgolayfilt(diff(sgolayfilt(M(:,2,nTrial),k,f)),k,f)).^2+(sgolayfilt(diff(sgolayfilt(M(:,3,nTrial),k,f)),k,f)).^2);
            veloc(:,nTrial,2)=sqrt((sgolayfilt(diff(sgolayfilt(M(:,4,nTrial),k,f)),k,f)).^2+(sgolayfilt(diff(sgolayfilt(M(:,5,nTrial),k,f)),k,f)).^2+(sgolayfilt(diff(sgolayfilt(M(:,6,nTrial),k,f)),k,f)).^2);
    end