function [ttfile, ncell] = tfilecollector()
%%%%%%%%%%%%%%%%%%%%
% [ttfile, ncell] = tfilecollector()
% Purpose: The function collect all t file
% 1st Author: Joonyeup Lee (Extract from DK's code) 
% 1st written: 2015. 4. 19.
% Last modified: 
%%%%%%%%%%%%%%%%%%%%
switch nargin
    case 0 % without input
        ttfile = FindFiles('TT*.t','CheckSubdirs',1);
        if isempty(ttfile)
            disp('TT file does not exist');
            return;
        end
    case 1 % with input
        if ~iscell(folders)
            disp('Input argument is wrong. It should be a cell array.');
            return;
        elseif isempty(folders);
            ttfile = FindFiles('TT*.t','CheckSubdirs',1);
            if isempty(ttfile)
                disp('Cluster does not exist!');
                return;
            end
        else % Cell with non-empty array, check each cell
            nfolder = length(folders);
            ttfile = cell(0,1);
            for ifolder = 1:nfolder
                if exist(folders{ifolder}) == 7; 
                    cd(folders{ifolder});
                    ttfile = [ttfile; FindFiles('TT*.t','CheckSubdirs',1)];
                elseif strcmp(folders{ifolder}(end-1:end),'.t')
                    ttfile = [ttfile; folders{ifolder}];
                end
            end
            if isempty(ttfile)
                disp('TT file does not exist!');
                return;
            end
        end
end

ncell = length(ttfile);
        
end