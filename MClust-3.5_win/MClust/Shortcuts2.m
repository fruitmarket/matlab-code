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
    case 'z'
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
