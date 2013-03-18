for i=1:size(LH_x,2)
    xlim = [0 size(LH_x,1)];
    
    subplot(3,1,1)
    plot(ti,LH_x(:,i),ti,RH_x(:,i))
    set(gca,'XLim',xlim)
    
    subplot(3,1,2)
    plot(ti,LH_y(:,i),ti,RH_y(:,i))
    set(gca,'XLim',xlim)
    
    subplot(3,1,3)
    plot(ti,LH_z(:,i),ti,RH_z(:,i))
    set(gca,'XLim',xlim)
    
    [X,Y] = ginput(2);
    xsnips(:,i) = round(X);
end