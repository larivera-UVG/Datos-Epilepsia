% % fileID=fopen('C:/Users/mafer/OneDrive/Escritorio/Noveno Semestre/Diseño e Innovación/Resultados/Señales/Z001.txt','r');
% %archivo = fscanf(fileID,'%d')
% 
% % [file,path,indx] = uigetfile( ...
% % {'*.*',  'All Files (*.*)'}, ...
% %    'Select a File');
[file,path,indx] = uigetfile({'*.edf'}, 'Elijase un EDF allí...');
if isequal(file,0)
   disp('User selected Cancel');
else
   disp(['User selected ', fullfile(path,file)]);
end

[hdr, record] = edfread(strcat(path,file));
serializedData = serialize(record);

% vardouble = 12.34;
% binaryd = serialize(vardouble);
% %varuint16 = uint16([5;16]);
% 
% vector = linspace(-1,1,10);
% binaryv = serialize(vector);
% 
% varuint8 = uint8([5;16]);

% Guardar los vectores del archivo original en archivo.bin
fid = fopen('archivo.bin', 'w');
%fwrite(fid, record, 'double');
fwrite(fid, serializedData, '*uint8');
fclose(fid);

% Leer archivo.bin para insertar como binario en la BD
fid = fopen('archivo.bin', 'r');
binaryData = fread(fid, '*uint8');
%binaryData = fread(fid, 'double');
fclose(fid);

% disp('Inserting...');
% conn = database('mysql', 'root', 'secret');
% columnas = {'id_paciente', 'Fecha', 'Hora', 'Duracion', 'Prueba'};
% nuevo = {'Z004', '2020-09-05', '09:06:00', 100, binaryData};
% insert(conn, 'pruebas', columnas, nuevo);
% 
% deserializedData = deserialize(binaryData);