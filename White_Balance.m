function varargout = White_Balance(varargin)
% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Balance_blancos_OpeningFcn, ...
                   'gui_OutputFcn',  @Balance_blancos_OutputFcn, ...
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

function Balance_blancos_OpeningFcn(hObject, eventdata, handles, varargin)
handles.output = hObject;
guidata(hObject, handles);

function varargout = Balance_blancos_OutputFcn(hObject, eventdata, handles) 
varargout{1} = handles.output;

% --- Executes on button press in Cargar.
function Cargar_Callback(hObject, eventdata, handles)
I=(imread(uigetfile({'*.jpg'})));
imwrite(I,'im1.jpg');
I=double(I);
I=(uint8(I));
axes(handles.axes1);
axis off;
imshow(I);

% --- Executes on button press in Aplicar.
function Aplicar_Callback(hObject, eventdata, handles)

I=double(imread('im1.jpg'));
media=sort([mean(mean(I(:,:,1))),mean(mean(I(:,:,2))),mean(mean(I(:,:,3)))]);
medGris=mean([mean(mean(I(:,:,1))),mean(mean(I(:,:,2))),mean(mean(I(:,:,3)))]);
if (media(1)+media(2)>medGris&&(uint8(medGris)<123||uint8(medGris)>131))
    %For some special pictures we have to use medGris=max(media) instead of medGris=mean(media) 
    if (mean(media)<110)
        medGris=mean(media);
    end
    I(:,:,1)=(medGris/mean(mean(I(:,:,1)))).*I(:,:,1);
    I(:,:,2)=(medGris/mean(mean(I(:,:,2)))).*I(:,:,2);
    I(:,:,3)=(medGris/mean(mean(I(:,:,3)))).*I(:,:,3);
end
I=(uint8(I));
axes(handles.axes2)
axis off;
imshow(I);
