pptfile = 'C:\Nate\OrgCon\PrelimAnalysis\SomeIntroData3.ppt';
close all;
figure;
maximize;

%Generate consistent axis limits 

Xs = [LH_x(:) RH_x(:)]; %condenses both into a vector
Xs = Xs(not(isnan(Xs))); % Removes NaNs
XLIM = [min(Xs) max(Xs)];

Ys = [LH_y(:) RH_y(:)]; %condenses both into a vector
Ys = Ys(not(isnan(Ys))); % Removes NaNs
YLIM = [min(Ys) max(Ys)];

Zs = [LH_z(:) RH_z(:)]; %condenses both into a vector
Zs = Zs(not(isnan(Zs))); % Removes NaNs
ZLIM = [min(Zs) max(Zs)];

for n = 1:length(trials);
    LX = LH_x(:,n); LY = LH_y(:,n); LZ = LH_z(:,n); LV = logistic(standardize(LH_v(:,n))); %Left Hand Components
    RX = RH_x(:,n); RY = RH_y(:,n); RZ = RH_z(:,n); RV = logistic(standardize(RH_v(:,n))); % Right Hand Components
    
    scatter(LX,LY,10,LV,'filled')
    xlim(XLIM);
    ylim(YLIM);
    xlabel('X-axis (cm)');
    ylabel('Y-axis (cm)');
    axis equal
    title(['Left Hand, X vs Y - Exp 1, Trial ' num2str(trials(n))], 'FontSize', 24)
    saveppt(pptfile);
    
    scatter(RX,RY,10,RV,'filled')
    xlim(XLIM);
    ylim(YLIM);
    xlabel('X-axis (cm)');
    ylabel('Y-axis (cm)');
    axis equal
    title(['Right Hand, X vs Y - Exp 1 Trial ' num2str(trials(n))], 'FontSize', 24)
    saveppt(pptfile);
end