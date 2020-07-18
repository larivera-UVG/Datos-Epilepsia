function varargout = Ejemplo(varargin)
% EJEMPLO MATLAB code for Ejemplo.fig
%      EJEMPLO, by itself, creates a new EJEMPLO or raises the existing
%      singleton*.
%
%      H = EJEMPLO returns the handle to a new EJEMPLO or the handle to
%      the existing singleton*.
%
%      EJEMPLO('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in EJEMPLO.M with the given input arguments.
%
%      EJEMPLO('Property','Value',...) creates a new EJEMPLO or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Ejemplo_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Ejemplo_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Ejemplo

% Last Modified by GUIDE v2.5 15-Jul-2020 11:18:04

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Ejemplo_OpeningFcn, ...
                   'gui_OutputFcn',  @Ejemplo_OutputFcn, ...
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


% --- Executes just before Ejemplo is made visible.
function Ejemplo_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Ejemplo (see VARARGIN)

% Choose default command line output for Ejemplo
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Ejemplo wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Ejemplo_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
id_paciente=handles.npac;
bandera=0;
%------ Conexion con la base de datos------------------------
%Set preferences with setdbprefs.
setdbprefs('DataReturnFormat', 'cellarray');
setdbprefs('NullNumberRead', 'NaN');
setdbprefs('NullStringRead', 'null');

conn = database('mysql', 'root', 'secret');

%Read data from database.
curs = exec(conn, ['SELECT 	datos.id_paciente'...
    ' ,	datos.Sexo'...
    ' ,	datos.Edad'...
    ' ,	datos.`Condición`'...
    ' ,	datos.EEG'...
    ' FROM 	`proyecto`.datos WHERE datos.id_paciente= "' ...
    id_paciente...
    '"']);

curs = fetch(curs);
close(curs);

%Assign data to output variable
datosDB = curs.Data;

%Leer los datos y mostrarlos en la interfaz
n=1:1:length(datosDB(:,1));
for i=1:length(n)
    if(strcmp(datosDB(i,1), id_paciente))
        sexo = datosDB(i,2);
        edad = datosDB(i,3);
        condicion = datosDB(i,4);
        EEG = datosDB(i,5);
        
        set(handles.sexo,'String',sexo);
        set(handles.edad,'String',edad);
        set(handles.cond,'String',condicion);
        
        bandera=1;
    end
end
if (bandera==0)
    errordlg('Paciente no encontrado','Curso_GUIDE');
end
%Close database connection.
close(conn);

%Clear variables
clear curs conn


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
ini = char(' ');
set(handles.sexo,'String',ini);
set(handles.edad,'String',ini);
set(handles.cond,'String',ini);




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
