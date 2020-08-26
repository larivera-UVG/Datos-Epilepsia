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

% Last Modified by GUIDE v2.5 26-Aug-2020 09:37:56

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

global p
p.MyData=[];

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
global p
id_paciente=handles.npac;
%------ Conexion con la base de datos------------------------
conn = database('mysql', 'root', 'secret');

%Set query to execute on the database
query = ['SELECT * ' ...
    'FROM proyecto.pacientes WHERE pacientes.id_paciente= "' ...
    id_paciente...
    '"'];

query2 = ['SELECT id_prueba, ' ...
    '	Fecha, ' ...
    '	Hora, ' ...
    '	Duración, ' ...
    '	Prueba ' ...
    'FROM proyecto.pruebas WHERE pruebas.id_paciente= "' ...
    id_paciente...
    '"'];

data = fetch(conn,query);
data2 = fetch(conn,query2);

if(isempty(data)==1)
    errordlg('Paciente no encontrado','Curso_GUIDE');
    ini = char(' ');
    set(handles.sexo,'String',ini);
    set(handles.edad,'String',ini);
    set(handles.cond,'String',ini);
else
    set(handles.sexo,'String',sprintf('%s',cell2mat(data.Sexo)));
    set(handles.edad,'String',sprintf('%d',data.Edad));
    set(handles.cond,'String',sprintf('%s',cell2mat(data.Condici_n_1)));
    %     ceros=get(handles.tabla,'data');
    %     ceros(end,1)=data2.id_prueba(1);
    dimension=size(data2);
    for i=1:dimension(1)
        prueba = sprintf('%d',data2.id_prueba(i));
        fecha = sprintf('%s',cell2mat(data2.Fecha(i)));
        hora = sprintf('%s',cell2mat(data2.Hora(i)));
        duracion = sprintf('%d',data2.Duraci_n_1(i));
        p.MyData=[p.MyData; [{prueba} {fecha} {hora} {duracion}]];
    end
    set(handles.tabla,'Data', p.MyData)
    %set(handles.tabla,'data',data2);
    %t = uitable('ColumnName',{'id_prueba';'Fecha';'Hora';'Duración (s)'},'Data',data2);
end

%Close database connection.
close(conn);

%Clear variables
clear conn query query2


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close(Ejemplo);
Ejemplo





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


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close(Ejemplo);
principal


% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[file,path,indx] = uigetfile( ...
{'*.m;*.mlx;*.fig;*.mat;*.slx;*.mdl',...
    'MATLAB Files (*.m,*.mlx,*.fig,*.mat,*.slx,*.mdl)';
   '*.m;*.mlx','Code files (*.m,*.mlx)'; ...
   '*.fig','Figures (*.fig)'; ...
   '*.mat','MAT-files (*.mat)'; ...
   '*.mdl;*.slx','Models (*.slx, *.mdl)'; ...
   '*.*',  'All Files (*.*)'}, ...
   'Select a File');
if isequal(file,0)
   disp('User selected Cancel');
else
   disp(['User selected ', fullfile(path,file)]);
   fileID=strcat(path,file);
end
handles.var=fileID;
guidata(hObject,handles);


% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global p
p.MyData=[];
set(handles.tabla,'Data',p.MyData)
id_paciente=handles.npac;
%------ Conexion con la base de datos------------------------
conn = database('mysql', 'root', 'secret');

%Set query to execute on the database
query = ['SELECT id_prueba, ' ...
    '	Fecha, ' ...
    '	Hora, ' ...
    '	Duración, ' ...
    '	Prueba ' ...
    'FROM proyecto.pruebas WHERE pruebas.id_paciente= "' ...
    id_paciente...
    '"'];

data = fetch(conn,query);

dimension=size(data);
for i=1:dimension(1)
    prueba = sprintf('%d',data.id_prueba(i));
    fecha = sprintf('%s',cell2mat(data.Fecha(i)));
    hora = sprintf('%s',cell2mat(data.Hora(i)));
    duracion = sprintf('%d',data.Duraci_n_1(i));
    p.MyData=[p.MyData; [{prueba} {fecha} {hora} {duracion}]];
end
set(handles.tabla,'Data', p.MyData)

%Close database connection.
close(conn);

%Clear variables
clear conn query


% --- Executes on button press in pushbutton6.
function pushbutton6_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
id_paciente=handles.npac;
fecha=handles.fecha;
hora=handles.hora;
duracion=str2double(handles.duracion);
%archivo=handles.var;

%[info,datos]=edfread(archivo);
% binary=fopen(archivo,'r');
% binaryData=fread(binary, 'integer*8');
% fclose(binary);

conn = database('mysql', 'root', 'secret');
query = ['SELECT * ' ...
    'FROM proyecto.pruebas'];
data = fetch(conn,query);

nuevo={id_paciente,fecha,hora,duracion};
columnas={'id_paciente','Fecha','Hora','Duración'};
insert(conn,'pruebas',columnas,nuevo);
%     for i=1:length(archivo)
%         save={id_prueba,archivo(i)};
%         col={'id_prueba','datos'};
%         insert(conn,'pruebas_datos',col,save);
%     end
close(conn);
msgbox('Se ha guardado correctamente','Mensaje');
clear conn query



function fecha_Callback(hObject, eventdata, handles)
% hObject    handle to fecha (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Val = get(hObject,'String');
handles.fecha=Val;
guidata(hObject,handles);

% Hints: get(hObject,'String') returns contents of fecha as text
%        str2double(get(hObject,'String')) returns contents of fecha as a double


% --- Executes during object creation, after setting all properties.
function fecha_CreateFcn(hObject, eventdata, handles)
% hObject    handle to fecha (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function hora_Callback(hObject, eventdata, handles)
% hObject    handle to hora (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Val = get(hObject,'String');
handles.hora=Val;
guidata(hObject,handles);

% Hints: get(hObject,'String') returns contents of hora as text
%        str2double(get(hObject,'String')) returns contents of hora as a double


% --- Executes during object creation, after setting all properties.
function hora_CreateFcn(hObject, eventdata, handles)
% hObject    handle to hora (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function duracion_Callback(hObject, eventdata, handles)
% hObject    handle to duracion (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Val = get(hObject,'String');
handles.duracion=Val;
guidata(hObject,handles);

% Hints: get(hObject,'String') returns contents of duracion as text
%        str2double(get(hObject,'String')) returns contents of duracion as a double


% --- Executes during object creation, after setting all properties.
function duracion_CreateFcn(hObject, eventdata, handles)
% hObject    handle to duracion (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
