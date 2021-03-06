function MClustCutterCallbacks(varargin)

% MClustCutterCallbacks
%
% Callbacks for cut using convex hulls window
%
% ADR 1998
%
% Status: PROMOTED (Release version)
% See documentation for copyright (owned by original authors) and warranties (none!).
% This code released as part of MClust 3.5.
% Version control M3.5.

% modified 11 Oct 02 ncst to allow for the user to change the cluster name
% and to not redraw the data window when scrolling the clusters

% global variables
global MClust_CHDrawingAxisWindow_Pos
global MClust_ClusterCutWindow_Pos
global MClust_Clusters
global MClust_Directory
global MClust_FeatureData   % features calculated from tt data
global MClust_Hide
global MClust_UnaccountedForOnly
global MClust_Colors
global MClust_AvailableClusterTypes


%---------------------------
% get startup info
if ~isempty(varargin)
    callbackTag = varargin{1};
    if length(varargin) > 1
        cboHandle = varargin{2};
    else
        cboHandle = [];
    end
    figHandle = findobj('Type','figure','Tag', 'ClusterCutWindow');
else
    cboHandle = gcbo;
    figHandle = gcf;
    callbackTag = get(cboHandle, 'Tag');
end

redrawAxesHandle = findobj(figHandle, 'Tag', 'RedrawAxes');
redrawAxesFlag = get(redrawAxesHandle, 'Value');

while length(MClust_Hide)<(length(MClust_Clusters)+1)  % Repair MClust_Hide variable if damaged.
    MClust_Hide(end+1)=1; %#ok<AGROW>
end

GChandle = findobj('Tag', 'ClusterCutWindow');
if ~isempty(GChandle)
    MClust_ClusterCutWindow_Pos = get(GChandle,'Position');
end

GChandle = findobj('Tag', 'CHDrawingAxisWindow');
if ~isempty(GChandle)
    MClust_CHDrawingAxisWindow_Pos = get(GChandle,'Position');
end

%---------------------------
% main switch
switch callbackTag
    
    %%
    case 'ClusterCutWindow'
        MClustCutterRedrawClusterKeys(cboHandle, 0);
        
        %%
    case {'xdim', 'ydim', 'RedrawAxes', 'PlotMarker', 'PlotMarkerSize'}
        if redrawAxesFlag
            MClustCutterRedrawAxes(figHandle, 'full', 1);
        end
        %% Custome codes by DK
    case 'E12'
        xdimHandle = findobj(figHandle, 'Tag', 'xdim');
        ydimHandle = findobj(figHandle, 'Tag', 'ydim');
        set(xdimHandle, 'Value', 1);
        set(ydimHandle, 'Value', 2);
        if redrawAxesFlag
            MClustCutterRedrawAxes(figHandle, 'full', 1);
        end
    case 'E13'
        xdimHandle = findobj(figHandle, 'Tag', 'xdim');
        ydimHandle = findobj(figHandle, 'Tag', 'ydim');
        set(xdimHandle, 'Value', 1);
        set(ydimHandle, 'Value', 3);
        if redrawAxesFlag
            MClustCutterRedrawAxes(figHandle, 'full', 1);
        end
    case 'E14'
        xdimHandle = findobj(figHandle, 'Tag', 'xdim');
        ydimHandle = findobj(figHandle, 'Tag', 'ydim');
        set(xdimHandle, 'Value', 1);
        set(ydimHandle, 'Value', 4);
        if redrawAxesFlag
            MClustCutterRedrawAxes(figHandle, 'full', 1);
        end
    case 'E24'
        xdimHandle = findobj(figHandle, 'Tag', 'xdim');
        ydimHandle = findobj(figHandle, 'Tag', 'ydim');
        set(xdimHandle, 'Value', 2);
        set(ydimHandle, 'Value', 4);
        if redrawAxesFlag
            MClustCutterRedrawAxes(figHandle, 'full', 1);
        end
    case 'E34'
        xdimHandle = findobj(figHandle, 'Tag', 'xdim');
        ydimHandle = findobj(figHandle, 'Tag', 'ydim');
        set(xdimHandle, 'Value', 3);
        set(ydimHandle, 'Value', 4);
        if redrawAxesFlag
            MClustCutterRedrawAxes(figHandle, 'full', 1);
        end
    case 'E32'
        xdimHandle = findobj(figHandle, 'Tag', 'xdim');
        ydimHandle = findobj(figHandle, 'Tag', 'ydim');
        set(xdimHandle, 'Value', 3);
        set(ydimHandle, 'Value', 2);
        if redrawAxesFlag
            MClustCutterRedrawAxes(figHandle, 'full', 1);
        end
    case 'P12'
        xdimHandle = findobj(figHandle, 'Tag', 'xdim');
        ydimHandle = findobj(figHandle, 'Tag', 'ydim');
        set(xdimHandle, 'Value', 14);
        set(ydimHandle, 'Value', 15);
        if redrawAxesFlag
            MClustCutterRedrawAxes(figHandle, 'full', 1);
        end
    case 'P13'
        xdimHandle = findobj(figHandle, 'Tag', 'xdim');
        ydimHandle = findobj(figHandle, 'Tag', 'ydim');
        set(xdimHandle, 'Value', 14);
        set(ydimHandle, 'Value', 16);
        if redrawAxesFlag
            MClustCutterRedrawAxes(figHandle, 'full', 1);
        end
    case 'P14'
        xdimHandle = findobj(figHandle, 'Tag', 'xdim');
        ydimHandle = findobj(figHandle, 'Tag', 'ydim');
        set(xdimHandle, 'Value', 14);
        set(ydimHandle, 'Value', 17);
        if redrawAxesFlag
            MClustCutterRedrawAxes(figHandle, 'full', 1);
        end
    case 'P24'
        xdimHandle = findobj(figHandle, 'Tag', 'xdim');
        ydimHandle = findobj(figHandle, 'Tag', 'ydim');
        set(xdimHandle, 'Value', 15);
        set(ydimHandle, 'Value', 17);
        if redrawAxesFlag
            MClustCutterRedrawAxes(figHandle, 'full', 1);
        end
    case 'P34'
        xdimHandle = findobj(figHandle, 'Tag', 'xdim');
        ydimHandle = findobj(figHandle, 'Tag', 'ydim');
        set(xdimHandle, 'Value', 16);
        set(ydimHandle, 'Value', 17);
        if redrawAxesFlag
            MClustCutterRedrawAxes(figHandle, 'full', 1);
        end
    case 'P32'
        xdimHandle = findobj(figHandle, 'Tag', 'xdim');
        ydimHandle = findobj(figHandle, 'Tag', 'ydim');
        set(xdimHandle, 'Value', 16);
        set(ydimHandle, 'Value', 15);
        if redrawAxesFlag
            MClustCutterRedrawAxes(figHandle, 'full', 1);
        end
        %%
    case 'PrevAxis'
        xdimHandle = findobj(figHandle, 'Tag', 'xdim');
        xdim = get(xdimHandle, 'Value');
        nxdim = length(get(xdimHandle, 'String'));
        ydimHandle = findobj(figHandle, 'Tag', 'ydim');
        ydim = get(ydimHandle, 'Value');
        nydim = length(get(ydimHandle, 'String'));
        if ydim > xdim+1
            set(ydimHandle, 'Value', ydim-1);
        else
            if xdim > 1
                set(xdimHandle, 'Value', xdim-1);
            else
                set(xdimHandle, 'Value', nxdim-1);
            end
            set(ydimHandle, 'Value', nydim);
        end
        if redrawAxesFlag
            MClustCutterRedrawAxes(figHandle, 'full', 1);
        end
        
    case 'NextAxis'
        xdimHandle = findobj(figHandle, 'Tag', 'xdim');
        xdim = get(xdimHandle, 'Value');
        nxdim = length(get(xdimHandle, 'String'));
        ydimHandle = findobj(figHandle, 'Tag', 'ydim');
        ydim = get(ydimHandle, 'Value');
        nydim = length(get(ydimHandle, 'String'));
        if ydim == nydim
            if xdim < nxdim-1
                set(xdimHandle, 'Value', xdim+1);
            else
                set(xdimHandle, 'Value', 1);
            end
            set(ydimHandle, 'Value', get(xdimHandle, 'Value') + 1);
        else
            set(ydimHandle, 'Value', ydim+1);
        end
        if redrawAxesFlag
            MClustCutterRedrawAxes(figHandle, 'full', 1);
        end
        
    case 'CycleYDimensions'
        xdimHandle = findobj(figHandle, 'Tag', 'xdim'); %#ok<NASGU>
        ydimHandle = findobj(figHandle, 'Tag', 'ydim');
        ynD = length(get(ydimHandle, 'String'));
        ysD = get(ydimHandle, 'Value');
        for jD = ysD:ynD
            set(ydimHandle, 'Value', jD);
            MClustCutterRedrawAxes(figHandle, 'full', 1);
            drawnow
            pause(0.1)
        end
        MClustCutterRedrawAxes(figHandle);
        set(cboHandle, 'Value', 0);
        
    case 'ViewAllDimensions'
        xdimHandle = findobj(figHandle, 'Tag', 'xdim');
        ydimHandle = findobj(figHandle, 'Tag', 'ydim');
        xnD = length(get(xdimHandle, 'String'));
        ynD = length(get(ydimHandle, 'String'));
        xsD = get(xdimHandle, 'Value');
        ysD = get(ydimHandle, 'Value');
        for iD = xsD:xnD
            for jD = max((iD+1),ysD):ynD
                set(xdimHandle, 'Value', iD);
                set(ydimHandle, 'Value', jD);
                MClustCutterRedrawAxes(figHandle, 'full', 1);
                drawnow
                pause(0.1)
            end
        end
        MClustCutterRedrawAxes(figHandle);
        set(cboHandle, 'Value', 0);
        
        %%
    case 'HideCluster'
        iClust = get(cboHandle, 'UserData');
        MClust_Hide(iClust + 1) = get(cboHandle, 'Value');
        if redrawAxesFlag
            MClustCutterRedrawAxes(figHandle);
        end
        
    case 'HideAll'
        MClust_Hide = ones(size(MClust_Hide));
        hideObjects = findobj(figHandle, 'Style', 'checkbox', 'Tag', 'HideCluster');
        set(hideObjects, 'Value', 1);
        if redrawAxesFlag
            MClustCutterRedrawAxes(figHandle);
        end
        
    case 'ShowAll'
        MClust_Hide = zeros(size(MClust_Hide));
        hideObjects = findobj(figHandle, 'Style', 'checkbox', 'Tag', 'HideCluster');
        set(hideObjects, 'Value', 0);
        if redrawAxesFlag
            MClustCutterRedrawAxes(figHandle);
        end
        
        %%
    case 'CutterFunctions'
        % automatically call cutter functions
        cboString = get(cboHandle, 'String');
        cboValue = get(cboHandle, 'Value');
        if cboValue == 1; return; end
        set(cboHandle, 'Value', 1);
        redraw = false; rekey = false;
        if exist(fullfile(MClust_Directory,'MClustCutterOptions', cboString{cboValue}), 'file')
            stateForUndo = MClustCutterUndoGetCurrentState(cboString{cboValue});
            [redraw, rekey, undoable] = feval(cboString{cboValue});
        else
            warndlg({'Function not yet available.', get(cboHandle, 'Tag')}, 'Implementation Warning');
        end
        if undoable
            MClustCutterUndoStore(stateForUndo);
        end
        if rekey
            MClustCutterClearClusterKeys(figHandle);
            MClustCutterRedrawClusterKeys(figHandle);
        end
        if redraw && redrawAxesFlag
            MClustCutterRedrawAxes(figHandle);
        end
        
        
        %%
    case 'Add Cluster'
        MClustCutterUndoStore('Add Cluster');
        clusterType = MClust_AvailableClusterTypes{get(findobj('Tag', 'AddAsType'), 'value')};
        
        if isempty(MClust_Clusters)
            MClust_Clusters{1} = feval(clusterType, 'Cluster 01');
            MClust_Hide(2) = 0;
        else
            MClust_Clusters{end+1} = feval(clusterType, sprintf('Cluster %02d', length(MClust_Clusters)+1));
            MClust_Hide(length(MClust_Clusters) + 1) = 0;
        end
        MClustCutterClearClusterKeys(figHandle);
        MClustCutterRedrawClusterKeys(figHandle, max(0,length(MClust_Clusters)-16));
        if redrawAxesFlag
            MClustCutterRedrawAxes(figHandle);
        end
        
    case 'Pack Clusters'
        MClustCutterUndoStore('Pack Clusters');
        MClustCutterClearClusterKeys(figHandle);
        keep = zeros(size(MClust_Clusters));
        for iC = 1:length(MClust_Clusters)
            keep(iC) = ~isempty(FindInCluster(MClust_Clusters{iC}));
        end
        from = find(keep);
        to = 1:sum(keep);
        erase = (sum(keep)+1):length(MClust_Clusters);
        MClust_Hide(to+1) = MClust_Hide(from+1); MClust_Hide(erase+1) = 0;
        MClust_Clusters(to) = MClust_Clusters(from); MClust_Clusters(erase) = [];
        MClust_Colors(to+1,:) = MClust_Colors(from+1,:);
        MClustCutterRedrawClusterKeys(figHandle);
        if redrawAxesFlag
            MClustCutterRedrawAxes(figHandle);
        end
        
    case 'Undo'
        MClustCutterClearClusterKeys(figHandle);
        MClustCutterUndoRecall;
        MClustCutterRedrawClusterKeys(figHandle);
        if redrawAxesFlag
            MClustCutterRedrawAxes(figHandle);
        end
        
    case 'Redo'
        MClustCutterClearClusterKeys(figHandle);
        MClustCutterUndoRedo;
        MClustCutterRedrawClusterKeys(figHandle);
        if redrawAxesFlag
            MClustCutterRedrawAxes(figHandle);
        end
        
    case 'Autosave'
        MClustCutterStepAutosave(1);
        
    case 'Exit'
        drawingFigHandle = findobj('Type', 'figure', 'Tag', 'CHDrawingAxisWindow');  % figure to draw in
        if ~isempty(drawingFigHandle)
            close(drawingFigHandle)
        end
        contourFigHandle = findobj('Type', 'figure', 'Tag', 'ContourWindow'); % contour plot window
        if ~isempty(contourFigHandle)
            close(contourFigHandle)
        end
        close(figHandle)
        
    case 'ChooseColor'
        iClust = get(cboHandle, 'UserData')+1;
        MClust_Colors(iClust,:) = uisetcolor(MClust_Colors(iClust,:), 'Set Cluster Color');
        set(cboHandle, 'BackgroundColor', MClust_Colors(iClust,:));
        lineHandle = findobj('Tag', 'ClusterLine', 'UserData', iClust-1);
        if ~isempty(lineHandle)
            set(lineHandle, 'Color', MClust_Colors(iClust, :));
        elseif redrawAxesFlag
            MClustCutterRedrawAxes(figHandle);
        end
        
    case 'ScrollClusters'
        MClustCutterClearClusterKeys(figHandle);
        MClustCutterRedrawClusterKeys(figHandle);
        
    case 'UnaccountedForOnly'
        MClust_UnaccountedForOnly = get(cboHandle, 'Value');
        if redrawAxesFlag
            MClustCutterRedrawAxes(figHandle);
        end
    case 'DK'
        cboString = get(cboHandle, 'String');
        if strcmp(cboString,'Rn')
            cboString = '00_Rename_Cluster';
        elseif strcmp(cboString,'+')
            cboString = '01_Add_Points';
        elseif strcmp(cboString,'Lmt')
            cboString = '03_Add_Limit';
        elseif strcmp(cboString,'Chk')
            cboString = 'CO_01_CheckCluster';
        elseif strcmp(cboString,'X')
            cboString = 'CO_02_DeleteCluster';
        elseif strcmp(cboString,'Wv')
            cboString = 'ShowWaveformDensity';
        end
        
        iClust = get(cboHandle, 'UserData');
        
        XdimHandle = findobj(figHandle, 'Tag', 'xdim'); % get x dimension
        xdim = get(XdimHandle, 'Value');
        
        YdimHandle = findobj(figHandle, 'Tag', 'ydim'); % get y dimension
        ydim = get(YdimHandle, 'Value');
        
        drawingFigHandle = findobj('Type', 'figure', 'Tag', 'CHDrawingAxisWindow');  % figure to draw in
        if isempty(drawingFigHandle),
            %errordlg('No drawing axis available.', 'Error');
            drawingAxisHandle = [];
        else
            drawingAxisHandle = findobj(drawingFigHandle, 'Type', 'axes');
        end
        
        if ~isempty(which(fullfile(class(MClust_Clusters{iClust}), ['CTO_',cboString])))
            % is it a clustertype option
            stateForUndo = MClustCutterUndoGetCurrentState(['Cluster ' num2str(iClust) ':' cboString]);
            [MClust_Clusters{iClust}, redraw, rekey, undoable] = feval(['CTO_' cboString],MClust_Clusters{iClust}, ...
                'iClust', iClust, 'figHandle', figHandle, ...
                'xdim', xdim, 'ydim', ydim, 'drawingAxis', drawingAxisHandle);
            if undoable
                MClustCutterUndoStore(stateForUndo);
            end
        elseif exist(fullfile(MClust_Directory,'ClusterOptions', [cboString '.m']), 'file')
            % is it an extra option?
            stateForUndo = MClustCutterUndoGetCurrentState(['Cluster ' num2str(iClust) ':' cboString]);
            if ~strcmp(cboString,'CO_03_CompareMeans')
                [redraw, rekey, undoable] = feval(cboString,iClust);
                if undoable
                    MClustCutterUndoStore(stateForUndo);
                end
            else
                feval(cboString);
                redraw = false; rekey = false; undoable = false;
            end
        else
            redraw = false; rekey = false; undoable = false; %#ok<NASGU>
            warndlg({'Function not yet available.', get(cboHandle, 'Tag')}, 'Implementation Warning');
        end
        if rekey
            MClustCutterClearClusterKeys(figHandle);
            MClustCutterRedrawClusterKeys(figHandle);
        end
        if redraw && redrawAxesFlag
            MClustCutterRedrawAxes(figHandle);
        end
        
        
        %%
    case 'ClusterFunctions'
        cboString = get(cboHandle, 'String');
        cboValue = get(cboHandle, 'Value');
        if cboValue == 1; return; end
        set(cboHandle, 'Value', 1);
        if streq('--------------', cboString(cboValue)); return; end
        
        iClust = get(cboHandle, 'UserData');
        
        XdimHandle = findobj(figHandle, 'Tag', 'xdim'); % get x dimension
        xdim = get(XdimHandle, 'Value');
        
        YdimHandle = findobj(figHandle, 'Tag', 'ydim'); % get y dimension
        ydim = get(YdimHandle, 'Value');
        
        drawingFigHandle = findobj('Type', 'figure', 'Tag', 'CHDrawingAxisWindow');  % figure to draw in
        if isempty(drawingFigHandle),
            %errordlg('No drawing axis available.', 'Error');
            drawingAxisHandle = [];
        else
            drawingAxisHandle = findobj(drawingFigHandle, 'Type', 'axes');
        end
        
        if ~isempty(which(fullfile(class(MClust_Clusters{iClust}), ['CTO_' cboString{cboValue}])))
            % is it a clustertype option
            stateForUndo = MClustCutterUndoGetCurrentState(['Cluster ' num2str(iClust) ':' cboString{cboValue}]);
            [MClust_Clusters{iClust}, redraw, rekey, undoable] = feval(['CTO_' cboString{cboValue}],MClust_Clusters{iClust}, ...
                'iClust', iClust, 'figHandle', figHandle, ...
                'xdim', xdim, 'ydim', ydim, 'drawingAxis', drawingAxisHandle);
            if undoable
                MClustCutterUndoStore(stateForUndo);
            end
        elseif exist(fullfile(MClust_Directory,'ClusterOptions', [cboString{cboValue} '.m']), 'file')
			% is it an extra option?
            stateForUndo = MClustCutterUndoGetCurrentState(['Cluster ' num2str(iClust) ':' cboString{cboValue}]);         
            if ~strcmp(cboString{cboValue},'CO_03_CompareMeans')
                [redraw, rekey, undoable] = feval(cboString{cboValue},iClust);
                if undoable
                    MClustCutterUndoStore(stateForUndo);
                end
            else
                feval(cboString{cboValue});
                redraw = false; rekey = false; undoable = false;
            end
        else
            redraw = false; rekey = false; undoable = false; %#ok<NASGU>
            warndlg({'Function not yet available.', get(cboHandle, 'Tag')}, 'Implementation Warning');
        end
        if rekey
            MClustCutterClearClusterKeys(figHandle);
            MClustCutterRedrawClusterKeys(figHandle);
        end
        if redraw && redrawAxesFlag
            MClustCutterRedrawAxes(figHandle);
        end
        
        
        %%
        
    otherwise
        warndlg({'Feature not yet available.', get(cboHandle, 'Tag')}, 'Implementation Warning');
        
end % switch


% Code added by Jaeeon Lee. 2015/06/07

function Shortcuts(varargin, e,cboHandle)
%%
global MClust_CHDrawingAxisWindow_Pos
global MClust_ClusterCutWindow_Pos
global MClust_Clusters
global MClust_Directory
global MClust_FeatureData   % features calculated from tt data
global MClust_Hide
global MClust_UnaccountedForOnly
global MClust_Colors
global MClust_AvailableClusterTypes


%---------------------------
% get startup info
if ~isempty(varargin)
    
    figHandle = findobj('Type','figure','Tag', 'ClusterCutWindow');
%     cboHandle = [];
    
else
%     cboHandle = gcbo;
    figHandle = gcf;
    callbackTag = get(cboHandle, 'Tag');
end
redrawAxesHandle = findobj(figHandle, 'Tag', 'RedrawAxes');
redrawAxesFlag = get(redrawAxesHandle, 'Value');

while length(MClust_Hide)<(length(MClust_Clusters)+1)  % Repair MClust_Hide variable if damaged.
    MClust_Hide(end+1)=1; %#ok<AGROW>
end

GChandle = findobj('Tag', 'ClusterCutWindow');
if ~isempty(GChandle)
    MClust_ClusterCutWindow_Pos = get(GChandle,'Position');
end

GChandle = findobj('Tag', 'CHDrawingAxisWindow');
if ~isempty(GChandle)
    MClust_CHDrawingAxisWindow_Pos = get(GChandle,'Position');
end

%%
switch e.Key
    case '1'
        xdimHandle = findobj(figHandle, 'Tag', 'xdim');
        ydimHandle = findobj(figHandle, 'Tag', 'ydim');
        set(xdimHandle, 'Value', 1);
        set(ydimHandle, 'Value', 2);
        if redrawAxesFlag
            MClustCutterRedrawAxes(figHandle, 'full', 1);
        end
    case '2'
        xdimHandle = findobj(figHandle, 'Tag', 'xdim');
        ydimHandle = findobj(figHandle, 'Tag', 'ydim');
        set(xdimHandle, 'Value', 1);
        set(ydimHandle, 'Value', 3);
        if redrawAxesFlag
            MClustCutterRedrawAxes(figHandle, 'full', 1);
        end
    case '3'
        xdimHandle = findobj(figHandle, 'Tag', 'xdim');
        ydimHandle = findobj(figHandle, 'Tag', 'ydim');
        set(xdimHandle, 'Value', 1);
        set(ydimHandle, 'Value', 4);
        if redrawAxesFlag
            MClustCutterRedrawAxes(figHandle, 'full', 1);
        end
    case '4'
        xdimHandle = findobj(figHandle, 'Tag', 'xdim');
        ydimHandle = findobj(figHandle, 'Tag', 'ydim');
        set(xdimHandle, 'Value', 2);
        set(ydimHandle, 'Value', 4);
        if redrawAxesFlag
            MClustCutterRedrawAxes(figHandle, 'full', 1);
        end
    case '5'
        xdimHandle = findobj(figHandle, 'Tag', 'xdim');
        ydimHandle = findobj(figHandle, 'Tag', 'ydim');
        set(xdimHandle, 'Value', 3);
        set(ydimHandle, 'Value', 4);
        if redrawAxesFlag
            MClustCutterRedrawAxes(figHandle, 'full', 1);
        end
    case '6'
        xdimHandle = findobj(figHandle, 'Tag', 'xdim');
        ydimHandle = findobj(figHandle, 'Tag', 'ydim');
        set(xdimHandle, 'Value', 3);
        set(ydimHandle, 'Value', 2);
        if redrawAxesFlag
            MClustCutterRedrawAxes(figHandle, 'full', 1);
        end
    case 'q'
        xdimHandle = findobj(figHandle, 'Tag', 'xdim');
        ydimHandle = findobj(figHandle, 'Tag', 'ydim');
        set(xdimHandle, 'Value', 14);
        set(ydimHandle, 'Value', 15);
        if redrawAxesFlag
            MClustCutterRedrawAxes(figHandle, 'full', 1);
        end
    case 'w'
        xdimHandle = findobj(figHandle, 'Tag', 'xdim');
        ydimHandle = findobj(figHandle, 'Tag', 'ydim');
        set(xdimHandle, 'Value', 14);
        set(ydimHandle, 'Value', 16);
        if redrawAxesFlag
            MClustCutterRedrawAxes(figHandle, 'full', 1);
        end
    case 'e'
        xdimHandle = findobj(figHandle, 'Tag', 'xdim');
        ydimHandle = findobj(figHandle, 'Tag', 'ydim');
        set(xdimHandle, 'Value', 14);
        set(ydimHandle, 'Value', 17);
        if redrawAxesFlag
            MClustCutterRedrawAxes(figHandle, 'full', 1);
        end
    case 'r'
        xdimHandle = findobj(figHandle, 'Tag', 'xdim');
        ydimHandle = findobj(figHandle, 'Tag', 'ydim');
        set(xdimHandle, 'Value', 15);
        set(ydimHandle, 'Value', 17);
        if redrawAxesFlag
            MClustCutterRedrawAxes(figHandle, 'full', 1);
        end
    case 't'
        xdimHandle = findobj(figHandle, 'Tag', 'xdim');
        ydimHandle = findobj(figHandle, 'Tag', 'ydim');
        set(xdimHandle, 'Value', 16);
        set(ydimHandle, 'Value', 17);
        if redrawAxesFlag
            MClustCutterRedrawAxes(figHandle, 'full', 1);
        end
    case 'y'
        xdimHandle = findobj(figHandle, 'Tag', 'xdim');
        ydimHandle = findobj(figHandle, 'Tag', 'ydim');
        set(xdimHandle, 'Value', 16);
        set(ydimHandle, 'Value', 15);
        if redrawAxesFlag
            MClustCutterRedrawAxes(figHandle, 'full', 1);
        end
    case 's'
        redrawAxesHandle = findobj(figHandle, 'Tag', 'RedrawAxes');
        if get(redrawAxesHandle, 'Value')==0
            set(redrawAxesHandle, 'Value',1);
            MClustCutterRedrawAxes(figHandle, 'full', 1);
        else
            set(redrawAxesHandle, 'Value',0);
        end
    case 'a' %'add cluster'
        MClustCutterUndoStore('Add Cluster');
        clusterType = MClust_AvailableClusterTypes{get(findobj('Tag', 'AddAsType'), 'value')};
        
        if isempty(MClust_Clusters)
            MClust_Clusters{1} = feval(clusterType, 'Cluster 01');
            MClust_Hide(2) = 0;
        else
            MClust_Clusters{end+1} = feval(clusterType, sprintf('Cluster %02d', length(MClust_Clusters)+1));
            MClust_Hide(length(MClust_Clusters) + 1) = 0;
        end
        MClustCutterClearClusterKeys(figHandle);
        MClustCutterRedrawClusterKeys(figHandle, max(0,length(MClust_Clusters)-16));
        if redrawAxesFlag
            MClustCutterRedrawAxes(figHandle);
        end
    case '0'
%         iClust = get(cboHandle, 'UserData');
        MClust_Hide(1) = 1;
        DefaultCluster = findobj(figHandle, 'Tag', 'HideCluster','UserData',1);
        set(DefaultCluster,'Value',1);
        MClustCutterRedrawAxes(figHandle);
        
    case 'n' % undo      
        MClustCutterClearClusterKeys(figHandle);
        MClustCutterUndoRecall;
        MClustCutterRedrawClusterKeys(figHandle);
        if redrawAxesFlag
            MClustCutterRedrawAxes(figHandle);
        end

    case 'm' % redo             
        MClustCutterClearClusterKeys(figHandle);
        MClustCutterUndoRecall;
        MClustCutterRedrawClusterKeys(figHandle);
        if redrawAxesFlag
            MClustCutterRedrawAxes(figHandle);
        end
        
end

