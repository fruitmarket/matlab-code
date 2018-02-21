function MClustCutter

% MClustCutter
% 
% INPUTS (now gotten from globals)
%     currentClusters 
%     featureData = nS x nD data
%     featureNames = names of feature data dimensions
%
% OUTPUTS
%     modifies MClust_Clusters
%
% ADR 1998
%
% Status: PROMOTED (Release version) 
% See documentation for copyright (owned by original authors) and warranties (none!).
% This code released as part of MClust 3.5.
% Version control M3.5.

global MClust_Autosave
global MClust_Clusters MClust_FeatureData MClust_FeaturesToUse MClust_FeatureTimestamps 
global MClust_TTData MClust_TTfn MClust_ChannelValidity
global MClust_FeatureIndex 
global MClust_ClusterCutWindow_Pos
global MClust_FeatureNames
global MClust_Directory
global MClust_AvailableClusterTypes

global MClust_Hide 
global MClust_Undo MClust_Redo MClust_MaxUndoNmbr % Keep length of Undo cue limited to save memroy - JCJ Oct 2007

MClust_Autosave    = 10;
MClust_Undo = [];  
MClust_Redo = [];
MClust_MaxUndoNmbr = 10; % Keep length of Undo cue limited to save memroy - JCJ Oct 2007

while length(MClust_Hide)<(length(MClust_Clusters)+1)  % Repair MClust_Hide variable if too small.
    MClust_Hide(end+1)=1; %#ok<AGROW>
end


%--------------------------------
% constants to make everything identical

uicHeight = 0.05;
uicWidth  = 0.175;
uicWidth0 = 0.075;
uicWidth1 = 0.10;
uicWdith2 = 0.04375;
XLocs = [0.05 0.40:uicWidth1:0.9];
dY = 0.05;
YLocs = 0.9:-dY:0.05;

%-------------------------------
% figure
figHandle = figure(...
    'Name', 'Cluster Cutting Control Window',...
    'NumberTitle', 'off', ...
    'Tag', 'ClusterCutWindow', ...
    'HandleVisibility', 'On', ...
    'Position', MClust_ClusterCutWindow_Pos, ...
    'CreateFcn', 'MClustCutterCallbacks');

% -------------------------------
% axes

uicontrol('Parent', figHandle, ...
    'Units', 'Normalized', 'Position', [XLocs(1) YLocs(1) uicWidth0 + uicWidth uicHeight], ...
    'Style', 'text', 'String', {MClust_TTfn, 'Axes'});
uicontrol('Parent', figHandle, ...
    'Units', 'Normalized', 'Position', [XLocs(1) YLocs(2) uicWidth0 uicHeight], ...
    'Style', 'text', 'String', ' X: ');
uicontrol('Parent', figHandle, ...
    'Units', 'Normalized', 'Position', [XLocs(1)+uicWidth0 YLocs(2) uicWidth uicHeight],...
    'Style', 'popupmenu', 'Tag', 'xdim', 'String', MClust_FeatureNames, ...
    'Callback', 'MClustCutterCallbacks', 'Value', 1, ...
    'TooltipString', 'Select x dimension');
uicontrol('Parent', figHandle, ...
    'Units', 'Normalized', 'Position', [XLocs(1) YLocs(3) uicWidth0 uicHeight], ...
    'Style', 'text', 'String', ' Y: ');
uicontrol('Parent', figHandle, ...
    'Units', 'Normalized', 'Position', [XLocs(1)+uicWidth0 YLocs(3) uicWidth uicHeight],...
    'Style', 'popupmenu', 'Tag', 'ydim', 'String', MClust_FeatureNames, ...
    'Callback', 'MClustCutterCallbacks', 'Value', 2, ...
    'TooltipString', 'Select y dimension');

uicontrol('Parent', figHandle, ...
    'Units', 'Normalized', 'Position', [XLocs(1) YLocs(4) uicWidth0 uicHeight], ...
    'Style', 'pushbutton', 'Tag', 'PrevAxis', 'String', '<', 'Callback', 'MClustCutterCallbacks', ...
    'TooltipString', 'Step backwards');
uicontrol('Parent', figHandle, ...
    'Units', 'Normalized', 'Position', [XLocs(1)+uicWidth0 YLocs(4) uicWidth-uicWidth0 uicHeight], ...
    'Style', 'text', 'String', 'Axis');
uicontrol('Parent', figHandle, ...
    'Units', 'Normalized', 'Position', [XLocs(1)+uicWidth YLocs(4) uicWidth0 uicHeight], ...
    'Style', 'pushbutton', 'Tag', 'NextAxis', 'String', '>', 'Callback', 'MClustCutterCallbacks', ...
    'TooltipString', 'Step forwards');
% uicontrol('Parent', figHandle, ...
%     'Units', 'Normalized', 'Position', [XLocs(1) YLocs(5) uicWidth+uicWidth0 uicHeight], ...
%     'Style', 'pushbutton', 'Tag', 'CycleYDimensions', 'String', 'Cycle y dimensions', ...
%     'Value', 0, 'Callback', 'MClustCutterCallbacks', ...
%     'TooltipString','Continuously step through current x dimension vs. all y dimensions');
% uicontrol('Parent', figHandle, ...
%     'Units', 'Normalized', 'Position', [XLocs(1) YLocs(6) uicWidth+uicWidth0 uicHeight], ...
%     'Style', 'pushbutton', 'Tag', 'ViewAllDimensions', 'String', 'View all dimensions', ...
%     'Value', 0, 'Callback', 'MClustCutterCallbacks', ...
%     'TooltipString','Continuously step through all dimension pairs');
uicontrol('Parent', figHandle, ...
    'Units', 'Normalized', 'Position', [XLocs(1) YLocs(7) uicWidth+uicWidth0 uicHeight], ...
    'Style', 'checkbox','Value', 0, 'Tag', 'RedrawAxes', 'String', 'Redraw Axes', ...
    'Callback', 'MClustCutterCallbacks', ...
    'TooltipString', 'If checked, redraw axes with each update.  Uncheck and recheck to redraw axes now.');
uicontrol('Parent', figHandle, ...
    'Units', 'Normalized', 'Position', [XLocs(1) YLocs(8)+uicHeight/2 uicWidth-uicWidth0 uicHeight/2], ...
    'Style', 'text', 'String', 'Marker');

global MClust_ClusterCutWindow_Marker
global MClust_ClusterCutWindow_MarkerSize

uicontrol('Parent', figHandle, ...
    'Units', 'Normalized', 'Position', [uicWidth+XLocs(1)-uicWidth0 YLocs(8) uicWidth0 uicHeight], ...
    'Style', 'popupmenu', 'Value', MClust_ClusterCutWindow_Marker, 'Tag', 'PlotMarker', ...
    'String', {'.','o','x','+','*','s','d','v','^','<','>','p','h'}, ...
    'Callback', 'MClustCutterCallbacks', ...
    'TooltipString', 'Change marker');
uicontrol('Parent', figHandle, ...
    'Units', 'Normalized', 'Position', [uicWidth+XLocs(1) YLocs(8) uicWidth0 uicHeight], ...
    'Style', 'popupmenu', 'Value', MClust_ClusterCutWindow_MarkerSize, 'Tag', 'PlotMarkerSize', ...
    'String', {1,2,3,4,5,10,15,20,25}, ...
    'Callback', 'MClustCutterCallbacks', ...
    'TooltipString', 'Change marker size');

%----------------------------------
% general control
uicontrol('Parent', figHandle, ...
    'Units', 'Normalized', 'Position', [XLocs(1) YLocs(9) uicWidth+uicWidth0 uicHeight], ...
    'Style', 'pushbutton', 'String', 'Add', 'Tag', 'Add Cluster', ...
    'Callback', 'MClustCutterCallbacks', ...
    'TooltipString', 'Add a cluster object');

% type to create as

ui_featuresIgnoreLB =  uicontrol('Parent', figHandle,...
   'Units', 'Normalized', 'Position', [XLocs(1) YLocs(9)-uicHeight/2 uicWidth+uicWidth0 uicHeight/2],...
   'Style', 'listbox', 'Tag', 'AddAsType',...
   'HorizontalAlignment', 'right', ...
   'String', MClust_AvailableClusterTypes,...
   'Max', 1, 'Min', 1, 'value', strmatch('mccluster', MClust_AvailableClusterTypes),...
   'Enable','on', ...
   'TooltipString', 'New cluster type to add.');

uicontrol('Parent', figHandle, ...
    'Units', 'Normalized', 'Position', [XLocs(1) YLocs(11) uicWidth+uicWidth0 uicHeight], ...
    'Style', 'pushbutton', 'String', 'Pack', 'Tag', 'Pack Clusters', ...
    'Callback', 'MClustCutterCallbacks', ...
    'TooltipString', 'Pack clusters; clear unused clusters');
uicontrol('Parent', figHandle, ...
    'Units', 'Normalized', 'Position', [XLocs(1) YLocs(12) (uicWidth+uicWidth0)/2 uicHeight], ...
    'Style', 'pushbutton', 'String', 'Hide', 'Tag', 'HideAll', ...
    'Callback', 'MClustCutterCallbacks', ...
    'TooltipString', 'Hide all clusters');
uicontrol('Parent', figHandle, ...
    'Units', 'Normalized', 'Position', [XLocs(1)+(uicWidth+uicWidth0)/2 YLocs(12) (uicWidth+uicWidth0)/2 uicHeight], ...
    'Style', 'pushbutton', 'String', 'Show', 'Tag', 'ShowAll', ...
    'Callback', 'MClustCutterCallbacks', ...
    'TooltipString', 'Show all clusters');

uicontrol('Parent', figHandle, ...
    'Units', 'Normalized', 'Position', [XLocs(1) YLocs(13) uicWidth+uicWidth0 uicHeight], ...
    'Style', 'pushbutton', 'String', 'Undo', 'Tag', 'Undo', ...
    'Callback', 'MClustCutterCallbacks');
uicontrol('Parent', figHandle, ...
    'Units', 'Normalized', 'Position', [XLocs(1) YLocs(14) uicWidth+uicWidth0 uicHeight], ...
    'Style', 'pushbutton', 'String', 'Redo', 'Tag', 'Redo', ...
    'Callback', 'MClustCutterCallbacks');
MClustCutterUndoUpdateTooltip();  % ADR 2 Mar 2008

% Cutter options
CutterOptionsFiles = FindFiles('*.m','CheckSubdirs',0, ...
	'StartingDirectory', [MClust_Directory filesep 'MClustCutterOptions' filesep]);
Extra_Options = cell(length(CutterOptionsFiles),1);
for iCOF = 1:length(CutterOptionsFiles)
	[dummy_fd Extra_Options{iCOF} ext] = fileparts(CutterOptionsFiles{iCOF});
end

uicontrol('Parent', figHandle, ...
	'Units', 'Normalized', 'Position', [XLocs(1) YLocs(15) uicWidth+uicWidth0 uicHeight],...
	'Style', 'popupmenu', 'Tag', 'CutterFunctions', 'String', cat(1, {'------------------'},Extra_Options), ...
	'Callback', 'MClustCutterCallbacks');

uicontrol('Parent', figHandle, ...
    'Units', 'Normalized', 'Position', [XLocs(1) YLocs(17) uicWidth+uicWidth0 uicHeight], ... 
    'Style', 'pushbutton', 'Tag', 'Autosave', 'String', ['Autosave in ' num2str(MClust_Autosave)], ...
    'Callback', 'MClustCutterCallbacks', ... 
    'TooltipString', 'Count steps to autosave'); 

uicontrol('Parent', figHandle, ...
    'Units', 'Normalized', 'Position', [XLocs(1) YLocs(end) uicWidth+uicWidth0 uicHeight], ...
    'Style', 'pushbutton', 'Tag', 'Exit', 'String', 'Exit', ...
    'Callback', 'MClustCutterCallbacks', ...
    'TooltipString', 'Return to main window');

uicontrol('Parent', figHandle, ...
    'Units', 'Normalized', 'Position', [XLocs(end) YLocs(end) uicWidth0/2 length(YLocs) * dY], ...
    'Style', 'slider', 'Tag', 'ScrollClusters', 'Callback', 'MClustCutterCallbacks', ...
    'Value', 0', 'Min', -99, 'Max', 0, ...
    'TooltipString', 'Scroll clusters');

curchildren = get(figHandle, 'children');
for i = 1:length(curchildren);
    set(curchildren(i), 'Fontname', 'Ariel');
    set(curchildren(i), 'Fontsize', 8);
end;


