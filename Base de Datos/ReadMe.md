Read Me
//***************************************************************************************************************************************
La base de datos utilizada para la prueba de creación de bases de datos y almacenamiento de archivos es proporcionada por Bonn University. Esta base de datos incluye 5 set de datos: A,B,C,D y E. Cada set contiene 100 señales EEG de un solo canal de 24s de grabación de 5 pacientes sanos y 5 pacientes epilépticos, todas las señales estan muestreadas a una frecuencia de 173.6Hz. El set A y B corresponden a señales de pacientes sanos con ojos abiertos y cerrados respectivamente. Los sets C y D contienen señales de pacientes epilépticos candidatos a cirugía, en lapsos sin crisis epilépticas, el set E corresponde a señales de pacientes epilépticos que experimentan una crisis.Los sets de datos se incluyen en en el ZIP señales. Para mayor información acceder al link: http://epileptologie-bonn.de/cms/front_content.php?idcat=193&lang=3&changelang=3//

Para las pruebas, se utilizó el set A de los primeros 50 pacientes sanos.
 //*************************************************************************************************************************************
 imagenes_servidor ->
 Esta carpeta cuenta con 4 scripts .php que sirvieron como pruebas para la creación de la base de datos y almacenamiento de imágenes:
 index.php -> Archivo que crea el formulario en html, en dicho script se selecciona la imagen a subir a la base de datos.
 config.php -> archivo en php que se encarga de almacenar los datos del usuario y contraseña del servidor y del nombre de la base de datos.
 datosImagen.php -> Archivo en php que se encarga de realizar el enlace con la base de datos y subir la imagen al servidor para luego guardarla dentro de la base de datos, en su respectiva tabla y determinado producto.
leerImagen.php -> Archivo en php que se encarga de realizar el enlace con la base de datos y leer la imagen almacenada para determinado producto.
 //*************************************************************************************************************************************
 proyecto->
 Esta carpeta cuenta con 3 scripts .php que sirvieron para la creación de la base de datos y almacenamiento de archivos, además de la carpeta que almacena los archivos .txt de las señales:
 index.php -> Archivo que crea el formulario en html, en dicho script se selecciona el archivo a subir y se indica el ID del paciente.
 config.php -> Archivo en php que se encarga de almacenar los datos del usuario y contraseña del servidor y del nombre de la base de datos.
 archivos.php -> Archivo en php que se encarga de realizar el enlace con la base de datos y subir el archivo al servidor para luego guardarla dentro de la base de datos, en su respectiva tabla para el paciente indicado.
uploads -> Carpeta del servidor en el que se almacenan las señales que se guardaron dentro de la base de datos.
