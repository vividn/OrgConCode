for tr = 1:length(trials)
    for pos = 1:size(posmarkers,1)
        RHposx = posmarkers(pos,1);
        RHposy = posmarkers(pos,2);
        LHposx = posmarkers(pos,4);
        LHposy = posmarkers(pos,5);
        mark_d(tr,:,pos) = ((RH_x(:,tr)-RHposx).^2 + (RH_y(:,tr)-RHposy).^2).^(.5); %+ (LH_x(:,tr)-LHposx).^2 + (LH_y(:,tr)-LHposy).^2).^(.5);
        [ans min_d(tr,pos)] = min(mark_d(tr,:,pos));
    end
end
