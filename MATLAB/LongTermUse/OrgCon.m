cd C:/OrgCon/OrgConCode/MATLAB
commonvars %Sets up many global constants

global ANALYSIS_DIR
addpath('LongTermUse/'); %Adds subfolder to path
analysisFolders = genpath(ANALYSIS_DIR); %Includes all subfolders
addpath(analysisFolders);

% Changes default plotting of lines to be more colorful
set(0,'DefaultAxesColorOrder',morelines,'DefaultAxesLineStyleOrder','-|--|:')

clearvars;