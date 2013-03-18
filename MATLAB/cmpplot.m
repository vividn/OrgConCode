function cmpplot(data,ylim,cols)

if nargin < 3
    cols = 2;
end

if nargin < 2
    mini = min(min(min(data)));
    maxi = max(max(max(data)));
    rang = maxi-mini;
    ylim = [mini-rang*.15 maxi+rang*.15];
    if round(mini) == 0 %Special case for absolute minimum
        ylim(1) = 0;
    end
end

xlim = [0 size(data,1)];

p = size(data,2);
rows = ceil(p/cols);
for i=1:p
    subplot(rows,cols,i)
    plot(squeeze(data(:,i,:)))
    set(gca,'Xlim',xlim,'YLim',ylim)
    hold all
end
