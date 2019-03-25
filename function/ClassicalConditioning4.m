function varargout = ClassicalConditioning4(varargin)
% CLASSICALCONDITIONING4 MATLAB code for ClassicalConditioning4.fig
% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @ClassicalConditioning4_OpeningFcn, ...
                   'gui_OutputFcn',  @ClassicalConditioning4_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


function ClassicalConditioning4_OpeningFcn(hObject, eventdata, handles, varargin)
handles.output = hObject;

% Set timer
handles.timer = timer(...
    'ExecutionMode', 'fixedSpacing', ...
    'BusyMode', 'drop', ...
    'Period', 0.1, ...
    'TimerFcn', {@ArduinoDataReader4,hObject});

% Set serial
currentPort = {'COM5'};
if isempty(currentPort)
    set(handles.connectionText,'String','No available serial ports!');
    set(handles.connectionText,'BackgroundColor','r');
else
    a = instrfindall;
    if ~isempty(a);
        fclose(a);
        delete(a);
    end
    handles.arduino = serial(currentPort{1}, 'Baudrate', 115200, 'Timeout', 10);
    fopen(handles.arduino);
    
    set(handles.connectionText,'String',['Connected to ',currentPort{1}]);
    set(handles.connectionText,'BackgroundColor','g');
    set(handles.stopButton, 'Enable', 'off');
    set(handles.startButton, 'Enable', 'on');
end

% Graph
nCue = 4;
set(handles.aBar,'TickDir','out','FontSize',8, ...
    'XLim',[0.5 nCue+0.5],'XTick',1:4,'XTickLabel',{'A','B','C','D'}, ...
    'YLim',[0 1], 'YTick',[0 1]);
xlabel(handles.aBar,'Cue');
ylabel(handles.aBar,'Licking number');

hold(handles.aRaster,'on');
plot(handles.aRaster,[0.5 0.5],[0 1000],'LineWidth',1,'Color',[0.8 0.8 0.8]);
plot(handles.aRaster,[1.5 1.5],[0 1000],'LineWidth',1,'Color',[0.8 0.8 0.8]);
plot(handles.aRaster,[2.5 2.5],[0 1000],'LineWidth',1,'Color',[0.8 0.8 0.8]);
set(handles.aRaster,'TickDir','out','FontSize',8, ...
    'XLim',[0 8],'XTIck',[0 0.5 1.5 2.5 8],...
    'YLim',[0 10],'YTick',0:10,'YTickLabel',{0,[],[],[],[],[],[],[],[],[],10});
xlabel(handles.aRaster,'Time (s)');
ylabel(handles.aRaster,'Trial');

% Cam
handles.cam = webcam;
preview(handles.cam);

guidata(hObject, handles);


function varargout = ClassicalConditioning4_OutputFcn(hObject, eventdata, handles) 
varargout{1} = handles.output;


function startButton_Callback(hObject, eventdata, handles)
% Get Trial Information
cueSelectTemp = get(handles.cueSelect, 'Value');
StartCue = 0;
nCue = 1;
switch cueSelectTemp
    case 1
        cueSelect = 10;
    case 2
        cueSelect = 11;
        StartCue = 1;
    case 3
        cueSelect = 12;
        StartCue = 2;
    case 4
        cueSelect = 20;
        nCue = 2;
    case 5
        cueSelect = 21;
        nCue = 2;
    case 6
        cueSelect = 30;
        nCue = 3;
    case 7
        cueSelect = 31;
        nCue = 4;
    case 8
        cueSelect = 40;
        nCue = 4;
end

rewardProbTemp = cellstr(get(handles.rewardProb, 'String'));
rewardProb = rewardProbTemp{get(handles.rewardProb,'Value')};

nTrialTemp = cellstr(get(handles.nTrial,'String'));
nTrial = str2double(nTrialTemp{get(handles.nTrial,'Value')});

rewardAmountTemp = cellstr(get(handles.rewardAmount,'String'));
rewardAmount = str2double(rewardAmountTemp{get(handles.rewardAmount, 'Value')});

delayDuration = get(handles.delayDuration,'Value');
ITI = get(handles.ITI,'Value');
modType = get(handles.modType, 'Value');

% Reset figure
cla(handles.aRaster);
hold(handles.aRaster,'on');
handles.bar.s0 = bar(handles.aRaster,0.25,1000,'BarWidth',0.5,'LineStyle','none','FaceColor',[1 1 0.4],'Visible','off');
handles.bar.s1 = bar(handles.aRaster,1,1000,'BarWidth',1,'LineStyle','none','FaceColor',[1 1 0.4],'Visible','off');
handles.bar.s2 = bar(handles.aRaster,1.5+delayDuration/2,1000,'BarWidth',delayDuration,'LineStyle','none','FaceColor',[1 1 0.4],'Visible','off');
handles.bar.s3 = bar(handles.aRaster,1.5+delayDuration+1.25,1000,'BarWidth',2.5,'LineStyle','none','FaceColor',[1 1 0.4],'Visible','off');
plot(handles.aRaster,[0.5 0.5],[0 1000],'LineWidth',1,'Color',[0.8 0.8 0.8]);
plot(handles.aRaster,[1.5 1.5],[0 1000],'LineWidth',1,'Color',[0.8 0.8 0.8]);
plot(handles.aRaster,[1.5+delayDuration 1.5+delayDuration],[0 1000],'LineWidth',1,'Color',[0.8 0.8 0.8]);
set(handles.aRaster,'TickDir','out','FontSize',8, ...
    'XLim',[0 5+delayDuration+ITI],'XTIck',[0 0.5 1.5 1.5+delayDuration 5+delayDuration+ITI],...
    'YLim',[0 10],'YTick',0:10,'YTickLabel',{0,[],[],[],[],[],[],[],[],[],10});
xlabel(handles.aRaster,'Time (s)');
ylabel(handles.aRaster,'Trial');

set(handles.aBar,'XLim',[0.5+StartCue StartCue+nCue+0.5]);

% Reset variables
set(handles.iTrial, 'String', '0');
set(handles.nReward, 'String', '0');
set(handles.cue0, 'String', '0');
set(handles.cue0, 'BackgroundColor', 'w');
set(handles.cue1, 'String', '0');
set(handles.cue1, 'BackgroundColor', 'w');
set(handles.cue2, 'String', '0');
set(handles.cue2, 'BackgroundColor', 'w');
set(handles.cue3, 'String', '0');
set(handles.cue3, 'BackgroundColor', 'w');
set(handles.reward0, 'String', '0');
set(handles.reward0, 'BackgroundColor', 'w');
set(handles.reward1, 'String', '0');
set(handles.reward1, 'BackgroundColor', 'w');
set(handles.reward2, 'String', '0');
set(handles.reward2, 'BackgroundColor', 'w');
set(handles.reward3, 'String', '0');
set(handles.reward3, 'BackgroundColor', 'w');
set(handles.omit0, 'String', '0');
set(handles.omit0, 'BackgroundColor', 'w');
set(handles.omit1, 'String', '0');
set(handles.omit1, 'BackgroundColor', 'w');
set(handles.omit2, 'String', '0');
set(handles.omit2, 'BackgroundColor', 'w');
set(handles.omit3, 'String', '0');
set(handles.omit3, 'BackgroundColor', 'w');

% Data variables
handles.data.stateTime = zeros(nTrial, 5);
handles.data.cue = zeros(nTrial, 1);
handles.data.reward = zeros(nTrial, 1);
handles.data.lickNum = zeros(nTrial, 1);
handles.data.lickTime = [];

% Start reading serial
fprintf(handles.arduino, '%s', ['t', num2str(nTrial)]);
pause(0.25);
fprintf(handles.arduino, '%s', ['r', num2str(rewardAmount)]);
pause(0.25);
fprintf(handles.arduino, '%s', ['i', num2str(ITI)]);
pause(0.25);
fprintf(handles.arduino, '%s', ['c', num2str(cueSelect)]);
pause(0.25);
fprintf(handles.arduino, '%s', ['p', rewardProb]);
pause(0.25);
fprintf(handles.arduino, '%s', ['d', num2str(delayDuration)]);
pause(0.25);
fprintf(handles.arduino, '%s', ['s', num2str(modType-1)]);

set(handles.mouseName, 'Enable', 'off');
set(handles.nTrial, 'Enable', 'off');
set(handles.ITI, 'Enable', 'off');
set(handles.rewardAmount, 'Enable', 'off');
set(handles.modType, 'Enable', 'off');
set(handles.startButton, 'Enable', 'off');
set(handles.stopButton, 'Enable', 'on');
set(handles.valve5, 'Enable', 'off');
set(handles.valve10, 'Enable', 'off');
set(handles.valve1000, 'Enable', 'off');
set(handles.trialType, 'Enable', 'off');
set(handles.cueSelect, 'Enable', 'off');
set(handles.airpuff, 'Enable', 'off');
set(handles.delayDuration, 'Enable', 'off');
set(handles.rewardProb, 'Enable', 'off');

fileDir = 'D:\Data\Classical_conditioning\';
handles.fileName = [fileDir get(handles.mouseName,'String'), '_', num2str(clock, '%4d%02d%02d_%02d%02d%02.0f')];

pause(2);
tic;
start(handles.timer);

guidata(hObject,handles);


function stopButton_Callback(hObject, eventdata, handles)
fwrite(handles.arduino,'e');

% Trial type
%   1: Cue A (p=100)
%   2: Cue AD (p=75/75)
%   3: Cue AB (p=75/25)
%   4: Cue AB (p=75/25) + mod (cue or reward)
%   5: Cue ABCD (p=75/25/75/25) 
% nTrial
%   1: 200 trial, 2: 320, 3: 400, 4: 480, 5: 600, 6: 720, 7: 800
% Reward amount
%   1: 3 ul, 2: 4 ul, 3: 5 ul, 4: 6 ul, 5: 7 ul, 6: 8 ul, 7: 9 ul, 8: 10 ul
% Reward probability
%   1: 100, 2: 90, 3: 80, 4: 75, 5: 50, 6: 25, 7:20, 8:10, 9:0
function trialType_Callback(hObject, eventdata, handles)
switch get(hObject,'Value');
    case 1
        set(handles.cueSelect,'Value',1); % cue C
        set(handles.rewardProb,'Value',1);  % 100%
        set(handles.nTrial,'Value',1); % 200 trial
        set(handles.rewardAmount,'Value',3); % 5 ul
        set(handles.ITI,'Value',1); 
        set(handles.modType,'Value',1);
    case 2
        set(handles.cueSelect,'Value',4); % cue AD
        set(handles.rewardProb,'Value',4); % 75%
        set(handles.nTrial,'Value',3); % 400 trial
        set(handles.rewardAmount,'Value',5); % 7 ul
        set(handles.ITI,'Value',1);
        set(handles.modType,'Value',1);
    case 3
        set(handles.cueSelect,'Value',5); % cue AB
        set(handles.rewardProb,'Value',4); % 75%
        set(handles.nTrial,'Value',3); % 400 trial
        set(handles.rewardAmount,'Value',3); % 5 ul
        set(handles.ITI,'Value',1);
        set(handles.modType,'Value',1);
    case 4
        set(handles.cueSelect,'Value',5); % cue AB + modulation
        set(handles.rewardProb,'Value',4); % 75%
        set(handles.nTrial,'Value',4); % 480 trial
        set(handles.rewardAmount,'Value',2); % 4 ul
        set(handles.ITI,'Value',1);
        set(handles.modType,'Value',4);
        set(handles.delayDuration,'Value',2);
    case 5
        set(handles.cueSelect,'Value',8); % cue ABCD 
        set(handles.rewardProb,'Value',4); % 75%
        set(handles.nTrial,'Value',7); % 800 trial
        set(handles.rewardAmount,'Value',3); % 5 ul
        set(handles.ITI,'Value',2);
        set(handles.modType,'Value',1);
end
nTrialTemp = cellstr(get(handles.nTrial,'String'));
nTrial = str2double(nTrialTemp{get(handles.nTrial,'Value')});
ITITemp = cellstr(get(handles.ITI,'String'));
ITI = str2double(ITITemp{get(handles.ITI,'Value')});
delayDurationTemp = cellstr(get(handles.delayDuration,'String'));
delayDuration = str2double(delayDurationTemp{get(handles.delayDuration,'Value')});
set(handles.eDuration,'String',num2str(nTrial*(delayDuration+ITI+4)/60,3));

cueSelect = get(handles.cueSelect,'Value');
if cueSelect == 4 | cueSelect==5 | cueSelect == 8; nTrial = nTrial/2;
elseif cueSelect == 7 | cueSelect == 6; nTrial = nTrial*2/3;
end;
rewardProbTemp = cellstr(get(handles.rewardProb,'String'));
rewardProb = str2double(rewardProbTemp{get(handles.rewardProb,'Value')})/100;
rewardAmountTemp = cellstr(get(handles.rewardAmount,'String'));
rewardAmount = str2double(rewardAmountTemp{get(handles.rewardAmount,'Value')});
set(handles.eReward,'String',num2str(nTrial*rewardProb*rewardAmount,4));

function nTrial_Callback(hObject, eventdata, handles)
switch get(hObject,'Value');
    case 1
        % C: only
        % rewarded: 200 trial, unrewarded: 0 trial
        % 200 trial x 5 ul = 1000 ul
        set(handles.rewardAmount,'Value',3); % 5 ul
    case 2
        % AB
        % each category: 200 trial
        % 400 trial x 0.5 x 0.75 x 7 = 1050 ul
        set(handles.rewardAmount,'Value',5); % 7 ul
    case 3
        % AB
        % each category: 200 trial
        % 400 trial x 0.5 x 5 = 1000 ul
        set(handles.rewardAmount,'Value',3); % 5 ul
    case 4
        % AD mod
        % each category: 480 / 2 (AD) / 2 (rw/non) / 3 (mod) = 40 trial
        % 480 trial x 0.5 x 0.5 x 8 = 960 ul
        set(handles.rewardAmount,'Value',6); % 8 ul
    case 5 
        % AD mod (cue or reward mod)
        % each category: 50 trial
        % 600 trial x 0.5 x 0.5 x 7 = 1050 ul
        set(handles.rewardAmount,'Value',5); % 7 ul
end
nTrialTemp = cellstr(get(hObject,'String'));
nTrial = str2double(nTrialTemp{get(hObject,'Value')});
ITITemp = cellstr(get(handles.ITI,'String'));
ITI = str2double(ITITemp{get(handles.ITI,'Value')});
delayDurationTemp = cellstr(get(handles.delayDuration,'String'));
delayDuration = str2double(delayDurationTemp{get(handles.delayDuration,'Value')});
set(handles.eDuration,'String',num2str(nTrial*(delayDuration+ITI+4)/60,3));

cueSelect = get(handles.cueSelect,'Value');
if cueSelect == 4 | cueSelect==5 | cueSelect==8; nTrial = nTrial/2;
elseif cueSelect == 6 | cueSelect==7; nTrial = nTrial*2/3;
end;
rewardAmountTemp = cellstr(get(handles.rewardAmount,'String'));
rewardAmount = str2double(rewardAmountTemp{get(handles.rewardAmount,'Value')});
set(handles.eReward,'String',num2str(nTrial*rewardAmount/2,4));

function nTrial_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function iTrial_Callback(hObject, eventdata, handles)

function iTrial_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function message_Callback(hObject, eventdata, handles)
str = get(handles.message,'String');
fprintf(handles.arduino, '%s', str);

function message_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function mouseName_Callback(hObject, eventdata, handles)

function mouseName_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function trialType_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function mainFigure_CloseRequestFcn(hObject, eventdata, handles)
t = timerfindall;
if ~isempty(t)
    stop(t);
    delete(t);
end

a = instrfindall;
if ~isempty(a)
    fclose(a);
    delete(a);
end

try
    closePreview(handles.cam);
end

delete(hObject);

function ITI_Callback(hObject, eventdata, handles)
nTrialTemp = cellstr(get(handles.nTrial,'String'));
nTrial = str2double(nTrialTemp{get(handles.nTrial,'Value')});
ITITemp = cellstr(get(hObject,'String'));
ITI = str2double(ITITemp{get(hObject,'Value')});
delayDurationTemp = cellstr(get(handles.delayDuration,'String'));
delayDuration = str2double(delayDurationTemp{get(handles.delayDuration,'Value')});
set(handles.eDuration,'String',num2str(nTrial*(delayDuration+ITI+4)/60,3));

function ITI_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function rewardAmount_Callback(hObject, eventdata, handles)
nTrialTemp = cellstr(get(handles.nTrial,'String'));
nTrial = str2double(nTrialTemp{get(handles.nTrial,'Value')});
rewardProbTemp = cellstr(get(hObject,'String'));
rewardProb = str2double(rewardProbTemp{get(hObject,'Value')})/100;
rewardAmountTemp = cellstr(get(hObject,'String'));
rewardAmount = str2double(rewardAmountTemp{get(hObject,'Value')});
cueSelect = get(handles.cueSelect,'Value');
if cueSelect == 4 | cueSelect==5 | cueSelect==8; nTrial = nTrial/2;
elseif cueSelect == 7 | cueSelect==6; nTrial = nTrial*2/3;
end;
set(handles.eReward,'String',num2str(nTrial*rewardProb*rewardAmount,4));

function rewardAmount_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function popupmenu3_Callback(hObject, eventdata, handles)

function popupmenu3_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function reverse_Callback(hObject, eventdata, handles)

function valve5_Callback(hObject, eventdata, handles)
fwrite(handles.arduino,'w77');
aReward = str2double(get(handles.aReward,'String'));
set(handles.aReward,'String',num2str(aReward+5,4));

function valve10_Callback(hObject, eventdata, handles)
fwrite(handles.arduino,'w116');
aReward = str2double(get(handles.aReward,'String'));
set(handles.aReward,'String',num2str(aReward+10,4));

function valve1000_Callback(hObject, eventdata, handles)
fwrite(handles.arduino,'w1000');


function delayDuration_Callback(hObject, eventdata, handles)
nTrialTemp = cellstr(get(handles.nTrial,'String'));
nTrial = str2double(nTrialTemp{get(nTrial,'Value')});
ITITemp = cellstr(get(handles.ITI,'String'));
ITI = str2double(ITITemp{get(handles.ITI,'Value')});
delayDurationTemp = cellstr(get(handles.delayDuration,'String'));
delayDuration = str2double(delayDurationTemp{get(handles.delayDuration,'Value')});
set(handles.eDuration,'String',num2str(nTrial*(delayDuration+ITI+4)/60,3));

function delayDuration_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function cueSelect_Callback(hObject, eventdata, handles)
nTrialTemp = cellstr(get(handles.nTrial,'String'));
nTrial = str2double(nTrialTemp{get(handles.nTrial,'Value')});
cueSelect = get(handles.cueSelect,'Value');
if cueSelect == 4 | cueSelect== 5 | cueSelect==8; nTrial = nTrial/2;
elseif cueSelect == 7 | cueSelect==6; nTrial = nTrial*2/3;
end;
rewardAmountTemp = cellstr(get(handles.rewardAmount,'String'));
rewardAmount = str2double(rewardAmountTemp{get(handles.rewardAmount,'Value')});
rewardProbTemp = cellstr(get(hObject,'String'));
rewardProb = str2double(rewardProbTemp{get(hObject,'Value')})/100;
set(handles.eReward,'String',num2str(nTrial*rewardProb*rewardAmount,4));

function cueSelect_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function rewardProb_Callback(hObject, eventdata, handles)

function rewardProb_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function modType_Callback(hObject, eventdata, handles)

function modType_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in airpuff.
function airpuff_Callback(hObject, eventdata, handles)
fwrite(handles.arduino,'a');


% --- Executes on button press in reset.
function reset_Callback(hObject, eventdata, handles)
set(handles.aReward,'String',num2str(0,4));
% hObject    handle to reset (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
