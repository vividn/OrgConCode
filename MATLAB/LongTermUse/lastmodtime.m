function dateNum = lastmodtime(fileStr)
fileInfo = dir(fileStr);

%If fileStr is a folder, return datenums for all sub files and folders
nSubFiles = size(fileInfo,1);
dateNum = zeros(nSubFiles,1);

for iSubFile = 1:nSubFiles;
    dateNum(iSubFile) = fileInfo(iSubFile).datenum;
end
end