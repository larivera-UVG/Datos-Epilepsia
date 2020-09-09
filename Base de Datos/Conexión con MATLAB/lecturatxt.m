
fid = fopen('prueba.txt', 'r');
Data = fscanf(fid, '%d');
fclose(fid);


% GUARDAR EN LA BASE DE DATOS
% disp('Inserting...');
% conn = database('mysql', 'root', 'secret');
% columnas = {'id_paciente', 'Fecha', 'Hora', 'Duracion', 'Prueba2'};
% nuevo = {'Z005', '2020-09-02', '20:35:00', 100, Data};
% insert(conn, 'pruebas', columnas, nuevo);

% Lectura 

%deserialize(data.Prueba{2,1})

id_paciente='Z005';
conn = database('mysql', 'root', 'secret');

%Set query to execute on the database
query = ['SELECT id_prueba, Prueba ' ...
    'FROM proyecto.pruebas WHERE pruebas.id_paciente= "' ...
    id_paciente...
    '"'];

data = fetch(conn,query);
close(conn);

%Clear variables
clear conn query

vectorrec = deserialize(data.Prueba{3,1});
