function vt2mat()
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Purpose: The function creates VT1 mat file
% 1st Author: Joonyeup Lee
% 1st written: 2015. 4. 19.
% Last modified: 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[vtfile, nfile] = vtfilecollector;

for ifile  = 1:nfile
    disp(['### Analyzing ',vtfile{ifile},'...']);
    [filepath, filename, ext] = fileparts(vtfile{ifile});
    vtfilename = [filename, ext];
    cd(filepath);
    
    switch lower(ext)
        case '.nvt'
        [timestamp,position,~,~] = nvt2mat(vtfilename);
        timestamp = timestamp/1000; %unit: msec
        zero = find(diff(timestamp)<0); % Delete error timestamp (timestamp should always increase)
        timestamp(zero-1) = [];
        
        save ('VT1.mat',...
        'timestamp','position'); % timestamp: usec
        
        case '.mat'
            load(vtfilename);
        otherwise
            error([vtfilename, 'VT file or mat file does not exist!']);
    end
end
disp('### VT1 nvt2mat conversion is Done ###');