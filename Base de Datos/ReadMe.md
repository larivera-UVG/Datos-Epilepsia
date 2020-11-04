# Diseño e Implementación de una Base de Datos de Señales Biomédicas

En este proyecto se creó e implementó una base de datos relacional de señales biomédicas de pacientes con epilepsia, utilizando *MySQL*. Adicionalmente, se desarrolló una herramienta de *software* o *toolbox* para enlazar la base de datos y Matlab. Dentro de la herramienta es posible agregar un nuevo paciente, consultar información de los pacientes y sus respectivas pruebas, así como agregar un nuevo archivo, y visualizar las pruebas, seleccionando sus respectivos canales y ventanas de tiempo.

## Distribución de carpetas
```
├── _App Designer
│   ├── agregarpac: Código MATLAB 
│   ├── consultas: Código MATLAB 
│   ├── logouvg: Imagen JPG
│   ├── principal: Código MATLAB 
│   ├── procesamiento: Código MATLAB 
│   └── selectprueba: Código MATLAB 
├── _Conexión con MATLAB
│   ├── Ejemplo: Código MATLAB y MATLAB Figure
│   ├── Escritura: Código MATLAB y MATLAB Figure
│   ├── Lectura: Código MATLAB y MATLAB Figure
│   ├── lecturatxt: Código MATLAB 
│   ├── license: Archivo de texto
│   ├── principal: Código MATLAB y MATLAB Figure
│   └── pruebas_datos: Código MATLAB y MATLAB Figure
├── _Documentos
│   ├── Protocolo de Tesis
│   ├── Tesis
│   └── Reporte Técnico
├── _Imágenes - ReadMe
├── _imagenes_servidor
│   ├── config: Código PHP
│   ├── datosImagen: Código PHP 
│   ├── index: Código PHP 
│   └── leerImagen: Código PHP
└── _Proyecto
    ├── config: Código PHP
    ├── datosImagen: Código PHP 
    ├── index: Código PHP 
    └── leerImagen: Código PHP
```
## Requisitos Generales
Para poder implementar y utilizar la base de datos, la página web de interacción y el *toolbox* de MATLAB es necesario contar con las siguientes herramientas.
####  1. Servidor Apache
![](https://github.com/larivera-UVG/Datos-Epilepsia/blob/master/Base%20de%20Datos/Im%C3%A1genes%20-%20ReadMe/apache.jpg) 

Apache es un *software* que se ejecuta en un servidor. Su trabajo es establecer una conexión entre un servidor y los navegadores de los visitantes del sitio web mientras se envían archivos entre ellos. Para instalarlo y habilitarlo:
1. Descargar Apache desde https://httpd.apache.org/download.cgi, seleccionando el instalador para Windows seguido de la opción de *Apache Haus* y seleccionando la arquitectura de la computadora.
   1. Descargar adicionalmente el redistribuible de Microsoft Visual C++ 2015.
   2. Intalar el redistribuible descargado.
2. Descomprimir carpeta descargada del sito de Apache.
3. Cortar la carpeta Apache24 de la carpeta descargada y pegarla dentro del disco C:.
4. Instalarlo:
   1. Ejecutar el *CMD* como administrador.
   2. Acceder a la carpeta \Apache\bin\ .
   3. Escribir *httpd.exe* para permitir acceso.
   4. Escribir *httpd -k install* para instalar Apache.
5. Habilitarlo:
   1. Acceder a *Servicios* desde el buscador dentro de la computadora.
   2. Buscar Apache2.4.
   3. Iniciar el servicio.
      - Para deshabilitarlo: *Detener el servicio*.
   4. Acceder a la dirección *localhost* desde un navegador web para verificar que el servidor esté habilitado.
      - Si se desea cambiar la pantalla del *localhost*, acceder a la carpeta C:\Apache24\htdocs y editar el archivo index.
6. Habilitar módulo *VHOSTS* para hospedar varios sitios en un mismo servidor: 
####  2. PHP
![](https://github.com/larivera-UVG/Datos-Epilepsia/blob/master/Base%20de%20Datos/Im%C3%A1genes%20-%20ReadMe/php.jpg)
####  3. MySQL
####  4. phpMyAdmin
