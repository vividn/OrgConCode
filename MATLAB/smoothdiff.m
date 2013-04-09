function veloc = smoothdiff(M)
%the input to this function should be a nx6x8 Matrix, where n is the number
%used to smooth the PC data in the 'alignpcscores' function (i.e.
%M=alignpcscores(MF3(1,scene),n) where 'scene' is the scene number 1-3)

%The output of this function is an n-1x8x2 Matrix, with veloc(:,:,1)
%corresponding to the velocity from the right hand and veloc(:,:,2)
%corresponding to the velocity from the left hand.
veloc=NaN(size(M,1)-1,size(M,3),2);%veloclh=[];
    for nTrial=1:size(M,3)
            veloc(:,nTrial,1)=sqrt((diff(M(:,1,nTrial))).^2+(diff(M(:,2,nTrial))).^2+(diff(M(:,3,nTrial))).^2);
            veloc(:,nTrial,2)=sqrt((diff(M(:,4,nTrial))).^2+(diff(M(:,5,nTrial))).^2+(diff(M(:,6,nTrial))).^2);
    end