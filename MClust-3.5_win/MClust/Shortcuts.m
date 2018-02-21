function Shortcuts(varargin, e)
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
%%% "Added by Jaeeon Lee." START
global MClust_ClusterCutWindow_Marker
%%% END

%---------------------------
% get startup info
if ~isempty(varargin)
    
    figHandle = findobj('Type','figure','Tag', 'ClusterCutWindow');
    cboHandle = [];
    
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

%%
if isempty(e.Modifier)
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
    case 'backquote'
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
    case 'equal'
        DefaultCluster = findobj(figHandle, 'Tag', 'HideCluster','UserData',0);
        if MClust_Hide(1)==1
            MClust_Hide(1)=0;
            set(DefaultCluster,'Value',0);
            MClustCutterRedrawAxes(figHandle);
        else
            MClust_Hide(1)=1;
            set(DefaultCluster,'Value',1);
            MClustCutterRedrawAxes(figHandle);
        end
    case 'hyphen'
        DefaultCluster = findobj(figHandle, 'Tag', 'HideCluster','UserData',1);
        if MClust_Hide(2)==1
            MClust_Hide(2)=0;
            set(DefaultCluster,'Value',0);
            MClustCutterRedrawAxes(figHandle);
        else
            MClust_Hide(2)=1;
            set(DefaultCluster,'Value',1);
            MClustCutterRedrawAxes(figHandle);
        end
    case '0'
        DefaultCluster = findobj(figHandle, 'Tag', 'HideCluster','UserData',2);
        if MClust_Hide(3)==1
            MClust_Hide(3)=0;
            set(DefaultCluster,'Value',0);
            MClustCutterRedrawAxes(figHandle);
        else
            MClust_Hide(3)=1;
            set(DefaultCluster,'Value',1);
            MClustCutterRedrawAxes(figHandle);
        end
    case '9'
        DefaultCluster = findobj(figHandle, 'Tag', 'HideCluster','UserData',3);
        if MClust_Hide(4)==1
            MClust_Hide(4)=0;
            set(DefaultCluster,'Value',0);
            MClustCutterRedrawAxes(figHandle);
        else
            MClust_Hide(4)=1;
            set(DefaultCluster,'Value',1);
            MClustCutterRedrawAxes(figHandle);
        end
    case '8'
        DefaultCluster = findobj(figHandle, 'Tag', 'HideCluster','UserData',4);
        if MClust_Hide(5)==1
            MClust_Hide(5)=0;
            set(DefaultCluster,'Value',0);
            MClustCutterRedrawAxes(figHandle);
        else
            MClust_Hide(5)=1;
            set(DefaultCluster,'Value',1);
            MClustCutterRedrawAxes(figHandle);
        end
    case '7'
        DefaultCluster = findobj(figHandle, 'Tag', 'HideCluster','UserData',5);
        if MClust_Hide(6)==1
            MClust_Hide(6)=0;
            set(DefaultCluster,'Value',0);
            MClustCutterRedrawAxes(figHandle);
        else
            MClust_Hide(6)=1;
            set(DefaultCluster,'Value',1);
            MClustCutterRedrawAxes(figHandle);
        end
    case 'comma' % undo
        MClustCutterClearClusterKeys(figHandle);
        MClustCutterUndoRecall;
        MClustCutterRedrawClusterKeys(figHandle);
        if redrawAxesFlag
            MClustCutterRedrawAxes(figHandle);
        end
        
    case 'period' % redo
        MClustCutterClearClusterKeys(figHandle);
        MClustCutterUndoRedo;
        MClustCutterRedrawClusterKeys(figHandle);
        if redrawAxesFlag
            MClustCutterRedrawAxes(figHandle);
        end
    case 'f1'
        xdimHandle = findobj(figHandle, 'Tag', 'xdim');
        ydimHandle = findobj(figHandle, 'Tag', 'ydim');
        set(xdimHandle, 'Value', 5);
        set(ydimHandle, 'Value', 6);
        if redrawAxesFlag
            MClustCutterRedrawAxes(figHandle, 'full', 1);
        end
        
    case 'f2'
        xdimHandle = findobj(figHandle, 'Tag', 'xdim');
        ydimHandle = findobj(figHandle, 'Tag', 'ydim');
        set(xdimHandle, 'Value', 5);
        set(ydimHandle, 'Value', 7);
        if redrawAxesFlag
            MClustCutterRedrawAxes(figHandle, 'full', 1);
        end
    case 'f3'
        xdimHandle = findobj(figHandle, 'Tag', 'xdim');
        ydimHandle = findobj(figHandle, 'Tag', 'ydim');
        set(xdimHandle, 'Value', 5);
        set(ydimHandle, 'Value', 8);
        if redrawAxesFlag
            MClustCutterRedrawAxes(figHandle, 'full', 1);
        end
    case 'f4'
        xdimHandle = findobj(figHandle, 'Tag', 'xdim');
        ydimHandle = findobj(figHandle, 'Tag', 'ydim');
        set(xdimHandle, 'Value', 6);
        set(ydimHandle, 'Value', 8);
        if redrawAxesFlag
            MClustCutterRedrawAxes(figHandle, 'full', 1);
        end
    case 'f5'
        xdimHandle = findobj(figHandle, 'Tag', 'xdim');
        ydimHandle = findobj(figHandle, 'Tag', 'ydim');
        set(xdimHandle, 'Value', 7);
        set(ydimHandle, 'Value', 8);
        if redrawAxesFlag
            MClustCutterRedrawAxes(figHandle, 'full', 1);
        end
    case 'f6'
        xdimHandle = findobj(figHandle, 'Tag', 'xdim');
        ydimHandle = findobj(figHandle, 'Tag', 'ydim');
        set(xdimHandle, 'Value', 7);
        set(ydimHandle, 'Value', 6);
        if redrawAxesFlag
            MClustCutterRedrawAxes(figHandle, 'full', 1);
        end
    end
end
if ismember(e.Modifier,'shift')
        
    switch e.Key
        case 'f1'
            xdimHandle = findobj(figHandle, 'Tag', 'xdim');
            ydimHandle = findobj(figHandle, 'Tag', 'ydim');
            set(xdimHandle, 'Value', 5);
            set(ydimHandle, 'Value', 9);
            if redrawAxesFlag
                MClustCutterRedrawAxes(figHandle, 'full', 1);
            end
        case 'f2'
            xdimHandle = findobj(figHandle, 'Tag', 'xdim');
            ydimHandle = findobj(figHandle, 'Tag', 'ydim');
            set(xdimHandle, 'Value', 6);
            set(ydimHandle, 'Value', 9);
            if redrawAxesFlag
                MClustCutterRedrawAxes(figHandle, 'full', 1);
            end
        case 'f3'
            xdimHandle = findobj(figHandle, 'Tag', 'xdim');
            ydimHandle = findobj(figHandle, 'Tag', 'ydim');
            set(xdimHandle, 'Value', 7);
            set(ydimHandle, 'Value', 9);
            if redrawAxesFlag
                MClustCutterRedrawAxes(figHandle, 'full', 1);
            end
        case 'f4'
            xdimHandle = findobj(figHandle, 'Tag', 'xdim');
            ydimHandle = findobj(figHandle, 'Tag', 'ydim');
            set(xdimHandle, 'Value', 8);
            set(ydimHandle, 'Value', 9);
            if redrawAxesFlag
                MClustCutterRedrawAxes(figHandle, 'full', 1);
            end
    
    end
end

if ~isempty(e.Modifier) && ~ismember(e.Modifier,e.Key) && e.Key~='0'
    if ismember(e.Modifier,'shift')
        cboString = '01_Add_Points';
    elseif ismember(e.Modifier,'alt')
        cboString = '03_Add_Limit';
    elseif ismember(e.Modifier,'control')
        cboString = 'CO_01_CheckCluster';
    end
    if e.Key=='z';return;end
    if e.Key=='x';return;end
    if ~isempty(e.Key)
        iClust = str2double(e.Key);
    end
    
%     XdimHandle = findobj(figHandle, 'Tag', 'xdim'); % get x dimension
%     xdim = get(XdimHandle, 'Value');
%     
%     YdimHandle = findobj(figHandle, 'Tag', 'ydim'); % get y dimension
%     ydim = get(YdimHandle, 'Value');
%     
%     drawingFigHandle = findobj('Type', 'figure', 'Tag', 'CHDrawingAxisWindow');  % figure to draw in
%     if isempty(drawingFigHandle),
%         %errordlg('No drawing axis available.', 'Error');
%         drawingAxisHandle = [];
%     else
%         drawingAxisHandle = findobj(drawingFigHandle, 'Type', 'axes');
%     end
%     
%     if ~isempty(which(fullfile(class(MClust_Clusters{iClust}), ['CTO_',cboString])))
%         % is it a clustertype option
%         stateForUndo = MClustCutterUndoGetCurrentState(['Cluster ' num2str(iClust) ':' cboString]);
%         [MClust_Clusters{iClust}, redraw, rekey, undoable] = feval(['CTO_' cboString],MClust_Clusters{iClust}, ...
%             'iClust', iClust, 'figHandle', figHandle, ...
%             'xdim', xdim, 'ydim', ydim, 'drawingAxis', drawingAxisHandle);
%         if undoable
%             MClustCutterUndoStore(stateForUndo);
%         end
%     elseif exist(fullfile(MClust_Directory,'ClusterOptions', [cboString '.m']), 'file')
%         % is it an extra option?
%         stateForUndo = MClustCutterUndoGetCurrentState(['Cluster ' num2str(iClust) ':' cboString]);
%         if ~strcmp(cboString,'CO_03_CompareMeans')
%             [redraw, rekey, undoable] = feval(cboString,iClust);
%             if undoable
%                 MClustCutterUndoStore(stateForUndo);
%             end
%         else
%             feval(cboString);
%             redraw = false; rekey = false; undoable = false;
%         end
%     else
%         redraw = false; rekey = false; undoable = false; %#ok<NASGU>
%         warndlg({'Function not yet available.', get(cboHandle, 'Tag')}, 'Implementation Warning');
%     end
%     if rekey
%         MClustCutterClearClusterKeys(figHandle);
%         MClustCutterRedrawClusterKeys(figHandle);
%     end
%     if redraw && redrawAxesFlag
%         MClustCutterRedrawAxes(figHandle);
%     end
% end

%%% code imported

      
        XdimHandle = findobj(figHandle, 'Tag', 'xdim'); % get x dimension
        xdim = get(XdimHandle, 'Value');
        
        YdimHandle = findobj(figHandle, 'Tag', 'ydim'); % get y dimension
        ydim = get(YdimHandle, 'Value');
        
        drawingFigHandle = findobj('Type', 'figure', 'Tag', 'CHDrawingAxisWindow');  % figure to draw in
        if isempty(drawingFigHandle),
            errordlg('No drawing axis available.', 'Error');
            drawingAxisHandle = [];
        else
            drawingAxisHandle = findobj(drawingFigHandle, 'Type', 'axes');
        end
        
        if ~isempty(which(fullfile(class(MClust_Clusters{iClust}), ['CTO_' cboString])))
%             is it a clustertype option
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
        
%%%        
end

