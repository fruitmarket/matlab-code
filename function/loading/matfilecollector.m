function [matfile, nfile] = matfilecollector()
%%%%%%%%%%%%%%%%%%%%%%%%%%
%% matfilecollector()
% Find all mat-files in the folder, 
% and return file location and the number of file.
% 1st Author: Dohoung Kim 2014. 9. 19
% Editor: Junyeop Lee 2015. 4. 18. (Modified as function)

%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
switch nargin
    case 0 % If there is no input, start to search t files in folder
        matfile = FindFiles('*TT*.mat','CheckSubdirs',0); % Do not search subfolders
        if isempty(matfile)
            disp('Mat file does not exist');
            return;
        end
    case 1 % If there is inputs
        if ~iscell(folders) % Check whether it is a cell array or not
            disp('Input argument is wrong. It should be a cell array.');
            return;
        elseif isempty(folders);
            matfile = FindFiles('*TT*.mat','CheckSubdirs',1);
            if isempty(matfile)
                disp('Mat file does not exist!');
                return;
            end
        else
            nfolder = length(folders);
            matfile = cell(0,1);
            for ifolder = 1:nfolder
                if exist(folders{ifolder}) == 7;
                    cd(folders{ifolder});
                    matfile = [matfile; FindFiles('*TT*.mat','CheckSubdirs',1)];
                elseif strcmp(folders{ifolder}(end-1:end),'.t')
                    matfile = [matfile; folders{ifolder}];
                end
            end
            if isempty(matfile)
                disp('Mat file does not exist!');
                return;
            end
        end
end

nfile = length(matfile);
        
end