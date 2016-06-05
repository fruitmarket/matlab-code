function [vtfile, nfile] = vtfilecollector()
%%%%%%%%%%%%%%%%%%%%
% [vtfile, nfile] = vtfilecollector();
% Purpose: Collect all VT1 files
% 1st author: Joonyeup Lee (Used DK's code)
% 1st written: 2015. 4. 19.
% Last modified:
%%%%%%%%%%%%%%%%%%%%

switch nargin
    case 0
        vtfile = FindFiles('VT1.*','CheckSubdirs',0);
        if isempty(vtfile)
            disp('VT file does not exist!');
            return;
        end
    case 1
        if isempty(folders)
            vtfile = FindFiles('VT1.*','CheckSubdirs',1);
            if isempty(ttfile)
                disp('Video recording does not exist.');
                return;
            end
        else
            nfolder = length(folders);
            vtfile = cell(0,1);
            for ifolder = 1:nfolder
                if exist(folders{ifolder}) == 7;
                    cd(folders{ifolder});
                    vtfile = [vtfile; FindFiles('VT1.*','CheckSubdirs',1)];
                elseif strcmp(folders{ifolder}(end-1:end),'.nvt');
                    vtfile = [vtfile; folders{ifolder}];
                end
            end
            if isempty(vtfile)
                disp('VT1 file does not exist!');
                return;
            end
        end
end
nfile = length(vtfile);
end
