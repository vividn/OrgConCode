function veloc = smoothdiff(SceneStruc,k,f)
%the input SceneStruc should be MF3(1,1), or MF3(1,2) or MF3(1,3)
%use lower k (2) and higher f (199)

%The output of this function is an n-1x8x2 Matrix, with veloc(:,:,1)
%corresponding to the velocity from the right hand and veloc(:,:,2)
%corresponding to the velocity from the left hand.

M=cat(2,SceneStruc.Rh.glovePC,SceneStruc.Lh.glovePC);
veloc=NaN(size(M,1)-1,size(M,3),2);%veloclh=[];
    for nTrial=1:size(M,3)
        
            veloc(:,nTrial,1)=sqrt((sgolayfilt(diff(sgolayfilt(M(:,1,nTrial),k,f)),k,f)).^2+(sgolayfilt(diff(sgolayfilt(M(:,2,nTrial),k,f)),k,f)).^2+(sgolayfilt(diff(sgolayfilt(M(:,3,nTrial),k,f)),k,f)).^2);
            veloc(:,nTrial,2)=sqrt((sgolayfilt(diff(sgolayfilt(M(:,4,nTrial),k,f)),k,f)).^2+(sgolayfilt(diff(sgolayfilt(M(:,5,nTrial),k,f)),k,f)).^2+(sgolayfilt(diff(sgolayfilt(M(:,6,nTrial),k,f)),k,f)).^2);
    end