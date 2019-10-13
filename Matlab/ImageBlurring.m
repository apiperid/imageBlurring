function varargout = ImageBlurring(varargin)
% IMAGEBLURRING MATLAB code for ImageBlurring.fig
%      IMAGEBLURRING, by itself, creates a new IMAGEBLURRING or raises the existing
%      singleton*.
%
%      H = IMAGEBLURRING returns the handle to a new IMAGEBLURRING or the handle to
%      the existing singleton*.
%
%      IMAGEBLURRING('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in IMAGEBLURRING.M with the given input arguments.
%
%      IMAGEBLURRING('Property','Value',...) creates a new IMAGEBLURRING or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before ImageBlurring_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to ImageBlurring_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help ImageBlurring

% Last Modified by GUIDE v2.5 12-Jun-2018 21:00:00

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @ImageBlurring_OpeningFcn, ...
                   'gui_OutputFcn',  @ImageBlurring_OutputFcn, ...
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

end

% --- Executes just before ImageBlurring is made visible.
function ImageBlurring_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to ImageBlurring (see VARARGIN)

% Choose default command line output for ImageBlurring
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes ImageBlurring wait for user response (see UIRESUME)
% uiwait(handles.figure1);
end

% --- Outputs from this function are returned to the command line.
function varargout = ImageBlurring_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;
end


function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double
end

% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
end

% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
warning('off', 'Images:initSize:adjustingMag');
file = get(handles.edit1,'string');
if isempty(file)
    errordlg('This File does not Exist','File Not Found');
end
set(handles.edit1,'string','');
set(handles.edit2,'string',file);
image = imread(file);
axes(handles.axes1);
imshow(image);
title(file);
clear image
end
% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
warning('off', 'Images:initSize:adjustingMag');
FLAG = 1;
file = get(handles.edit2,'string');
if isempty(file)
    errordlg('This File does not Exist','File Not Found');
end
set(handles.edit2,'string','');
image = imread(file);
file = ['BLUR__',file];
imwrite(image,file);

while (FLAG)
image = im2double(image);
imshow(image);
title(file);
% START PROCEDURE
    
% GET 2 POINTS
[YPOS,XPOS] = getpts;
% ROUND THEM
XPOS = ceil(XPOS);
YPOS = ceil(YPOS);
% GET THE SIZE
X = size(XPOS);
Y = size(YPOS);
% SAVE MEMORY CONSUME
X = X(1);
Y = Y(1);

if (X == 2)
% FIND THE MAX AND MIN VALUES
MAX_Y = max(YPOS);
MIN_Y = min(YPOS);
MAX_X = max(XPOS);
MIN_X = min(XPOS);
% BLURRING WITH GAUSSIAN MASK
SIGMA = 15;
image(MIN_X:MAX_X,MIN_Y:MAX_Y,:) = imgaussfilt(image(MIN_X:MAX_X,MIN_Y:MAX_Y,:),SIGMA);
% CONVERT IMAGE FROM DOUBLE TO UINT8
image = im2uint8(image);
imwrite(image,file);
else
    FLAG = 0;
end

end
end

% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close;
end

function edit2_Callback(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit2 as text
%        str2double(get(hObject,'String')) returns contents of edit2 as a double

end
% --- Executes during object creation, after setting all properties.
function edit2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
end
