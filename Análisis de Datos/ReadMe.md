Read Me
//****************************************************************************************************************************************
Contenido Carpeta SVM:
Script Caracteristicas.m  --> Se construye la matriz de características de las señales a analizar
Script clasificador.m     --> Incluye el diseño, entrenamiento y validación del clasificador SVM presenta matrices de confusión
Carpeta features          --> Se incluyen los workspaces de cada matriz de característica generada en los 24 experimentos 
                              12 experimentos se realizaron con una ventana de 150 muestras, los 12 restantes con ventana de 80 muestras
                              Se incluyen gráficas de características generadas con el experimento 1,7 [setA/setE], 12 y 18 [setB/setE]
                              Se incluyen 3 gráficas generadas en excel del comportamiento promedio de las características en los 3 sets
                              Se inlcuye excel donde se generaron las gráficas presentadas

//****************************************************************************************************************************************
Contenido Carpeta NN:
Script Redes_Neuronales.m    --> Incluye el diseño entrenamiento y validación del clasificador NN mediante funciones del toolbox 
                                nntool de MATLAB.Se incluyen dos workspace que contienen las matrices de características generadas 
                                del script Características.m utilizando ventana de 150 y 80 muestras.
                                Carpeta prueba preliminar: resultado obtenido en primeras pruebas de setA/setE mediante nntool.
Carpeta matrices de confusión: --> Incluye 14 matrices de confusión generadas con el toolbox nntool. 12 de estas corresponden
                                   a resultados obtenidos con la ventana de 150 muestras y dos de estas corresponden a experimentos
                                   1 y 9 
//****************************************************************************************************************************************
Información respecto a base de datos: La base de datos utilizadas para las pruebas es proporcionada por Bonn University. 
Incluye 5 set de datos: A,B,C,D y E. Cada set contiene 100 señales EEG de un solo canal de 24s de grabación de 5 pacientes
sanos y 5 pacientes epilépticos, todas las señales estan muestreadas a una frecuencia de 173.6Hz. El set A y B corresponden
a señales de pacientes sanos con ojos abiertos y cerrados respectivamente. Los sets C y D contienen señales de pacientes 
epilépticos candidatos a cirugía, en lapsos sin crisis epilépticas, el set E corresponde a señales de pacientes epilépticos
que experimentan una crisis.Los sets de datos se incluyen en en el ZIP señales. Para mayor información acceder al link:
http://epileptologie-bonn.de/cms/front_content.php?idcat=193&lang=3&changelang=3 
//****************************************************************************************************************************************
                              
