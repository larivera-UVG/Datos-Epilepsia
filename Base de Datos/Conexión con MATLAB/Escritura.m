function varargout = Escritura(varargin)
% ESCRITURA MATLAB code for Escritura.fig
%      ESCRITURA, by itself, creates a new ESCRITURA or raises the existing
%      singleton*.
%
%      H = ESCRITURA returns the handle to a new ESCRITURA or the handle to
%      the existing singleton*.
%
%      ESCRITURA('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in ESCRITURA.M with the given input arguments.
%
%      ESCRITURA('Property','Value',...) creates a new ESCRITURA or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Escritura_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Escritura_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Escritura

% Last Modified by GUIDE v2.5 29-Jul-2020 09:45:36

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Escritura_OpeningFcn, ...
                   'gui_OutputFcn',  @Escritura_OutputFcn, ...
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


% --- Executes just before Escritura is made visible.
function Escritura_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Escritura (see VARARGIN)

% Choose default command line output for Escritura
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Escritura wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Escritura_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function npac_Callback(hObject, eventdata, handles)
% hObject    handle to npac (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Val = get(hObject,'String');
handles.npac=Val;
guidata(hObject,handles);

% Hints: get(hObject,'String') returns contents of npac as text
%        str2double(get(hObject,'String')) returns contents of npac as a double


% --- Executes during object creation, after setting all properties.
function npac_CreateFcn(hObject, eventdata, handles)
% hObject    handle to npac (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edad_Callback(hObject, eventdata, handles)
% hObject    handle to edad (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Val = get(hObject,'String');
handles.edad=Val;
guidata(hObject,handles);

% Hints: get(hObject,'String') returns contents of edad as text
%        str2double(get(hObject,'String')) returns contents of edad as a double


% --- Executes during object creation, after setting all properties.
function edad_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edad (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu1.
function popupmenu1_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
opcion=get(handles.popupmenu1,'Value');
switch opcion
    case 1
        sexo ='';
    case 2
        sexo='F';
    case 3
        sexo='M';
    otherwise
end
set(handles.popupmenu1, 'UserData', sexo);
        

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu1


% --- Executes during object creation, after setting all properties.
function popupmenu1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
id=handles.npac;
sexo = handles.popupmenu1.String{handles.popupmenu1.Value};
edad=str2double(handles.edad);
cond=handles.popupmenu2.String{handles.popupmenu2.Value};
%------ Conexion con la base de datos------------------------
conn = database('mysql', 'root', 'secret');
query = ['SELECT * ' ...
    'FROM proyecto.pacientes WHERE pacientes.id_paciente= "' ...
    id...
    '"'];
data = fetch(conn,query);

if((isempty(id)==1) || (isempty(sexo)==1) || (isnan(edad)==1) || (isempty(cond)==1))
    errordlg('Ingrese todos los campos','Error');
else
    if(isempty(data)==0)
        errordlg('ID Paciente ya existente','Error');
    else
        nuevo={id,sexo,edad,cond};
        columnas={'id_paciente','Sexo','Edad','Condición'};
        insert(conn,'pacientes',columnas,nuevo);
        close(conn);
        msgbox('Se ha guardado correctamente','Mensaje');
        clear conn query
    end   
end



% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close(Escritura);
Escritura



% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close(Escritura);
principal


% --- Executes on selection change in popupmenu2.
function popupmenu2_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
opcion=get(handles.popupmenu2,'Value');
switch opcion
    case 1
        cond='';
    case 2
        cond='SANO';
    case 3
        cond='ENFERMO';
    otherwise
end
set(handles.popupmenu2, 'UserData', cond);

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu2 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu2


% --- Executes during object creation, after setting all properties.
function popupmenu2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
