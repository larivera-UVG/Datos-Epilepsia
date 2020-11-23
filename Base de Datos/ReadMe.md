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
│   ├── selectprueba: Código MATLAB 
│   ├── serialize: Código MATLAB
│   ├── deserialize: Código MATLAB 
│   └── edfread: Código MATLAB 
├── _Conexión con MATLAB
│   ├── Ejemplo: Código MATLAB y MATLAB Figure
│   ├── Escritura: Código MATLAB y MATLAB Figure
│   ├── Lectura: Código MATLAB y MATLAB Figure
│   ├── lecturatxt: Código MATLAB 
│   ├── license: Archivo de texto
│   ├── principal: Código MATLAB y MATLAB Figure
│   ├── pruebas_datos: Código MATLAB y MATLAB Figure
│   └── edfread: Código MATLAB 
├── _Documentos
│   ├── Protocolo de Tesis
│   ├── Tesis
│   └── Reporte Técnico
├── _Epileptic EEG Analysis Toolbox
│   ├── agregarpac: Código MATLAB 
│   ├── consultas: Código MATLAB 
│   ├── logouvg: Imagen JPG
│   ├── principal: Código MATLAB 
│   ├── procesamiento: Código MATLAB 
│   ├── selectprueba: Código MATLAB 
│   ├── Features: Código MATLAB 
│   ├── Features_tipicas: Código MATLAB
│   ├── ZC: Código MATLAB 
│   ├── clasificadorRN: Código MATLAB
│   ├── clasificadorSVM: Código MATLAB 
│   ├── features: Código MATLAB 
│   ├── serialize: Código MATLAB
│   ├── deserialize: Código MATLAB 
│   └── edfread: Código MATLAB 
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
Para poder implementar y utilizar la base de datos, la página web de interacción y el *toolbox* de MATLAB es necesario contar con las siguientes herramientas:
1. [Servidor Apache](####Servidor-Apache)
2. [PHP](####PHP)
3. [MySQL](####MySQL)
4. [phpMyAdmin](####phpMyAdmin)
    
####  1. Servidor Apache
![](https://github.com/larivera-UVG/Datos-Epilepsia/blob/master/Base%20de%20Datos/Im%C3%A1genes%20-%20ReadMe/apache.jpg) 

Apache es un *software* que se ejecuta en un servidor. Su trabajo es establecer una conexión entre un servidor y los navegadores de los visitantes del sitio web mientras se envían archivos entre ellos. Para instalarlo y habilitarlo:
1. Descargar Apache desde https://httpd.apache.org/download.cgi, seleccionando el instalador para Windows seguido de la opción de *Apache Haus* y seleccionando la arquitectura de la computadora.
   1. Descargar adicionalmente la última versión del redistribuible de Microsoft Visual C++.
   2. Intalar el redistribuible descargado.
2. Descomprimir carpeta descargada del sito de Apache.
3. Cortar la carpeta Apache24 de la carpeta descargada y pegarla dentro del disco C:.
4. Instalarlo:
   1. Ejecutar el *CMD* como administrador.
   2. Acceder a la carpeta \Apache\bin.
   3. Escribir *httpd.exe* para permitir acceso.
   4. Escribir *httpd -k install* para instalar Apache.
5. Habilitarlo:
   1. Acceder a *Servicios* desde el buscador dentro de la computadora.
   2. Buscar Apache2.4.
   3. Iniciar el servicio.
      - Para deshabilitarlo: *Detener el servicio*.
   4. Acceder a la dirección *localhost* desde un navegador web para verificar que el servidor esté habilitado.
      - Si se desea cambiar la pantalla del *localhost*, acceder a la carpeta C:\Apache24\htdocs y editar el archivo index.
6. Habilitar módulo *VHOSTS* para hospedar varios sitios en un mismo servidor.

####  2. PHP
![](https://github.com/larivera-UVG/Datos-Epilepsia/blob/master/Base%20de%20Datos/Im%C3%A1genes%20-%20ReadMe/php.png)

PHP es un lenguaje de programación de uso general que se adapta especialmente al desarrollo web. Para instalarlo e integrarlo al servidor:
1. Descargar PHP desde https://www.php.net/downloads.php, seleccionando el instalador para Windows u la arquitectura de la computadora.
2. Descomprimir carpeta descargada del sito de PHP.
3. Cortar la carpeta ya descomprimida y pegarla dentro del disco C: (para facilitar su búsqueda se recomienda cambiar el nombre).
4. Añadir *php* a las variables de entorno del sistema.
   1. Abrir propiedades del sistema.
   2. Abrir variable PATH de variables del sistema.
   3. Añadir la ruta de de la carpeta de los binarios de PHP.
5. Integrar PHP al servidor:
   1. Acceder al archivo *httpd.conf* dentro de la carpeta C:\Apache24\conf
   2. Cargar módulo de PHP para Apache2.4.
   3. Guardar cambios en el archivo y reiniciar el servicio de Apache2.4.

####  3. MySQL
![](https://github.com/larivera-UVG/Datos-Epilepsia/blob/master/Base%20de%20Datos/Im%C3%A1genes%20-%20ReadMe/mysql.png)

MySQL es un sistema de gestión de bases de datos relacionales de código abierto (RDBMS, por sus siglas en inglés) con un modelo cliente-servidor. Para instalarlo y habilitarlo:
1. Descargar MySQL desde https://dev.mysql.com/downloads/windows/installer/8.0.html, seleccionando el instalador *offline*.
2. Acceder al instalador de MySQL.
   1. Seleccionar configuración personalizada.
   2. Seleccionar los paquetes de MySQL Server, MySQL Workbench, MySQL Shell, MySQL Documentations y Samples and Examples.
   3. Ejecutar instalación.
   4. Presionar siguiente hasta que esté la opción de Método de Autenticación.
   5. Seleccionar Método de Autenticación Heredado.
   6. Ingresar contraseña del usuario administrador.
   7. Presionar siguiente hasta que esté la opción de ajustes.
   8. Ejecutar configuración.
   9. Presionar siguiente hasta que esté la opción de conexión servidor.
   10. Escribir nuevamente la contraseña.
   11. Presionar siguiente.
   12. Ejecutar configuración.
   13. Finalizar.
3. Añadir *mysql* a las variables de entorno del sistema.
   1. Abrir propiedades del sistema.
   2. Abrir variable PATH de variables del sistema.
   3. Añadir la ruta de de la carpeta de los binarios del servidor de MySQL.
   
####  4. phpMyAdmin
![](https://github.com/larivera-UVG/Datos-Epilepsia/blob/master/Base%20de%20Datos/Im%C3%A1genes%20-%20ReadMe/phpmyadmin.png)

phpMyAdmin es una herramienta escrita en PHP con la intención de manejar la administración de MySQL a través de páginas web, utilizando un navegador web. Para instalarlo e implementarlo:
1. Descargar phpMyAdmin desde https://www.phpmyadmin.net/, seleccionando la opción de descargar que aparece en pantalla.
2. Descomprimir carpeta descargada del sito de phpMyAdmin.
3. Cortar la carpeta ya descomprimida y pegarla dentro de una carpeta dentro del disco C y cambiar el nombre a phpmyadmin.local.
4. Crear una entrada hacia los hosts del servidor:
   1. Ejecutar el *CMD* como administrador.
   2. Acceder a la carpeta \drivers\etc\ .
   3. Escribir *notepad hosts*.
   4. Al final del archivo añadir *127.0.0.1 phpmyadmin.local*
5. Acceder al archivo *httpd-vhosts.conf* dentro de la carpeta C:\Apache24\conf\extra
6. Escribir bloque de código para implementar phpmyadmin.local.
7. Reiniciar el servicio del servidor.
8. Habilitar la librería *mysqli*:
   1. Acceder a la carpeta de donde se encuentrar los binarios de php.
   2. Copiar el archivo *php.ini-development*.
   3. Pegar en la misma carpeta el archivo y renombrarlo a *php.ini*.
   4. Abrir el archivo.
   6. Buscar el término *mysqli* en todo el cocumento
   7. Descomentar la línea de código donde se encuentra la extensión de la librería.
   8. Reiniciar el servicio del servidor.
   9. Acceder en el navegador web a la página httpd://phpmyadmin.local/setup
   10. Entrar al error Bzip2.
   11. Deshabilitar opciones GZip y Bzip2.
   12. Actualizar.
9. Configurar nuevo servidor (si se desea se puede trabajar con el usuario administrador de MySQL creando el usuario en el MySQL Shell):
   1. Ejecutar el *CMD* como usuario regular.
   2. Restaurar el backup de instalación de phpMyAdmin.
   3. Acceder en el navegador web a la página httpd://phpmyadmin.local/setup
   4. Configurar nuevo servidor con usuario y contraseña.
   5. Aplicar configuración.
   6. Cambiar el idioma a conveniencia.
   7. Descargar archivo.
   8. Cortar el archivo de descargas y pegar en la carpeta phpmyadmin.local.
