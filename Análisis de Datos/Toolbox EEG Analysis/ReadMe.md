## Automated Analysis of Epileptic EEG Toolbox
- [Descripción del Toolbox EEG Analysis](#descripcion-del-toolbox-eeg-analysis).
- [Características del EEG, Análisis Directo y Análisis Wavelet](#caracteristicas-del-eeg-analisis-directo-y-analisis-wavelet).
- [Clasificadores](#clasificadores).
- [Instalación del Toolbox EEG Analysis](#instalacion-del-toolbox-eeg-analysis).
- [Ejemplos de Funcionamiento del Toolbox EEG Analysis](#ejemplos-de-funcionamiento-del-toolbox-eeg-analysis).

### Descripción del Toolbox EEG Analysis
El toolbox EEG Analysis es una herramienta diseñada para facilitar el análisis e implementación de algoritmos de aprendizaje automático en señales EEG con el fin de caracterizar las señales EEG de pacientes con epilepsia y detectar la presencia de crisis en las mismas. El toolbox contiene las siguientes opciones predeterminadas:

**1. Visualización de la señal EEG**

Esta opción permite visualizar la señal EEG en formato EDF. El usuario tiene opción de seleccionar la señal a cargar de su computador, como se describe en la siguiente figura en esta ventana se incluye una gráfica de amplitud vs tiempo donde se muestra el canal especificado durante el período de tiempo seleccionado. Adicionalmente, puede seleccionarse señales de prueba en línea presentes en base de datos HUMANA para visualizar las señales EEG. 

![](https://github.com/larivera-UVG/Datos-Epilepsia/blob/master/An%C3%A1lisis%20de%20Datos/Toolbox%20EEG%20Analysis/Im%C3%A1genes/ventana1.JPG) 
##### Figura 1. Ventana de Visualización Toolbox EEG Anlaysis

**2. Extracción de Características**

En esta ventana el usuario puede seleccionar opciones para extraer características de la señal previamente cargada, debe escogerse el número de canales a analizar y especificar los mismos, el tamaño de ventana y las características que desean extraerse. Como resultado, la herramienta entrega un archivo de formato MAT con el vector de característica y un vector de clases generado automáticamente con "ceros" y "unos" balanceados según el tamaño del vector de característica resultante. El vector de clases se genera tomándo en consideración que la señal EEG cargada se encuentra ordenada de forma que la primera mitad de las muestras de la señal corresponden a un tipo de registro y la siguiente mitad de las muestras corresponden al tipo de registro restante. Es decir que la cantidad de "ceros" presentes en el vector de clase es igual a la primera mitad de las muestras de la señal y la cantidad de "unos" equivalen a la mitad restante de las muestras de las señal.

En caso que la señal EEG no se encuentre ordenada de esta forma, el usuario debe generar manualmente el vector de clases y tendrá opción de cargarlo posteriormente en la ventana de clasificación del toolbox. El botón generar permite guardar el archivo de formato MAT en la ubicación que el usuario seleccione. El botón generar de la parte superior que se observa en la figura 2, calcula el resultado utilizando el análisis directo. El botón generar de la parte inferior, calcula el resultado mediante el análisis wavelet. Al generar resultados se habilitan las opciones de clasificadores, red neuronal y máquina de vectores de soporte.

![](https://github.com/larivera-UVG/Datos-Epilepsia/blob/master/An%C3%A1lisis%20de%20Datos/Toolbox%20EEG%20Analysis/Im%C3%A1genes/ventana2.JPG) 
##### Figura 2. Ventana de Extracción de Características Toolbox EEG Anlaysis

**3. Algoritmos de Clasificación**

La herramienta utiliza los resultados generados en la ventana extracción de características para implementar el clasificador seleccionado por el usuario. Si se desean cargar vectores de características y clases externos debe utilizarse formato MAT donde se incluyan las siguientes variables:

- data: vector de características de dimensión nxm, donde n representa el número de ventanas seleccionadas para entrenamiento del clasificador y m la multiplicación del número de características por el número de canales analizados.
- labels: vector de dimensión nx1, que contiene "ceros" en las ventanas que representan la clase 1, y "unos" en las ventanas que representan la clase 2. El número de filas debe corresponder al número de ventanas que contiene el vector de características "data".

**Para el clasificador SVM, el toolbox utiliza validación cruzada. El usuario debe seleccionar el número de particiones previo a cargar los datos para dividir el vector de características en muestras para entrenamiento y prueba del clasificador.**

La ventana de red neuronal permite seleccionar los porcentajes de entrenamiento, validación y testeo. Adicionalemnte puede elegir el algoritmo de entrenamiento de la red neuronal y escoger el número de capas ocultas. Si se desea implementar el clasificador con los resultados generados en la ventana de extracción de características, es importante especificar el tipo de análisis utilizado (directo o wavelet) para que la herramienta utilice el vector de características correcto al implementar el algoritmo de clasificación.

El botón visualizar, ver figura 3, entrega los resultados del toolbox deep learning de MATLAB, donde el usuario puede visualizar la estructura de la red, las matrices de confusión e indicadores típicos para evaluar desempeño del algoritmo. Adicionalmente se presenta un resumen en la parte inferior de los resultados obtenidos.

![](https://github.com/larivera-UVG/Datos-Epilepsia/blob/master/An%C3%A1lisis%20de%20Datos/Toolbox%20EEG%20Analysis/Im%C3%A1genes/ventana3.JPG) 
##### Figura 3. Ventana de Algoritmo de Clasificación: Redes Neuronales

La ventana de SVM utiliza la técnica de validación cruzada mediante la función de MATLAB **crossvalind** para dividir el vector de características en entrenamiento y prueba. El usuario puede seleccionar el número de particiones y el tipo de Kernel para implementar el algoritmo. Si se desea implementar el clasificador con los resultados generados en la ventana de extracción de características, es importante especificar el tipo de análisis utilizado (directo o wavelet) para que la herramienta utilice el vector de características correcto al implementar el algoritmo de clasificación.

El botón visualizar, ver figura 4, entrega los resultados del toolbox machine learning de MATLAB, donde el usuario puede visualizar la matriz de confusión. Adicionalmente se presenta en la parte inferior un resumen de la exactitud y resultados del algoritmo.

![](https://github.com/larivera-UVG/Datos-Epilepsia/blob/master/An%C3%A1lisis%20de%20Datos/Toolbox%20EEG%20Analysis/Im%C3%A1genes/ventana5.JPG )
##### Figura 4. Ventana de Algoritmo de Clasificación: Máquina de Vectores de Soporte

**4.  Conexión con Base de Datos HUMANA**

El toolbox EEG Analysis se incluye en la interfaz de la base de datos HUMANA (figura 5), creada por María Fernanda Pineda.  Esta base de datos incluye señales biomédicas de pacientes con epilepsia del Centro de Epilepsia y Neurocirugía Funcional HUMANA, Guatemala. De cada paciente se obtuvieron variables cualitativas y cuantitativas que permitieron la clasificación y organización de datos, así como también las señales biomédicas de cada uno de los pacientes. Es importante mencionar que, para resguardar la
privacidad de los pacientes, no se obtuvieron nombres u otra información que pudiera revelar su identificación.

La base de da phpMyAdmin se utilizó para la creación de la base de datos relacional dentro del entorno de MySQL. La base de datos desarrollada consta de
diferentes tablas en las que se puede almacenar información importante del paciente que un investigador necesita para clasificar y utilizar las señales almacenadas, información de las pruebas para realizar el análisis correspondiente para cada una de ellas, así como los datos de las pruebas almacenadas como archivos binarios y dato por dato de cada prueba.

![](https://github.com/larivera-UVG/Datos-Epilepsia/blob/master/An%C3%A1lisis%20de%20Datos/Toolbox%20EEG%20Analysis/Im%C3%A1genes/ventana0_1.PNG)
##### Figura 5. Ventana de Conexión a Base de Datos HUMANA

### Características del EEG, Análisis Directo y Análisis Wavelet
El toolbox EEG Analysis toma en consideración dos tipos de análisis: análisis directo y análisis wavelet para la extracción de características. El primero tipo de análisis inlcuye las siguientes características del dominio del tiempo:
```
1. Cruces por zero (ZC)
2. Valor medio absoluto (MAV)
3. Curtosis
4. Desviación estándar
```
El análisis wavelet descompone la señal EEG en subbandas que contienen los 5 ritmos cerebrales (Alfa, Beta, Gamma, Theta y Delta) y extrae de los coeficientes de aproximación de cada subbanda las siguientes características:
```
1. Potencia
2. Media
3. Curtosis
4. Desviación Estándar
5. Asimetría estadística
6. Cruces por cero (ZC)
```
### Clasificadores
#### Máquina de vectores de soporte SVM
El algoritmo de clasificación SVM implementado en el toolbox, permite un clasificador binario para detectar registros de la señal EEG "normales" e "ictales", es decir, segmentos de la señal con crisis y sin crisis epilépticas. Utiliza las funciones **fitcsvm** y **predict** del toolbox de stadistics and machine learning de MATLAB.

Estas funciones, validan cruzadamente un modelo de máquina vectorial de soporte (SVM) para la clasificación de dos clases (binarias) en un conjunto de datos predictor de baja dimensión o de dimensión moderada. admite la asignación de datos predictores mediante funciones del kernel y admite la optimización mínima secuencial (SMO), el algoritmo iterativo de datos únicos (ISDA) o 1 minimización de margen flexible a través de la programación cuadrática para la minimización de la función objetivo.
Encontrar documentación en el siguiente [link](https://la.mathworks.com/support/search.html?q=fitcs&page=1).

#### Redes Neuronales Artificiales ANN
El algoritmo de clasificación ANN implementado en el toolbox, permite un clasificador binario para detectar registros de la señal EEG "normales" e "ictales" de la señal EEG utilizando una red neuronal perceptrón multicapa. Utiliza el toolbox deep learning de MATLAB. La función **patternnet** regresa una estructura que define la red neuronal según el número de capas ocultas y función de entrenamiento especificada. Se utiliza la función **train** para entrenamiento de la red y la función **net** para probar el algoritmo de clasificación.

Puede encontrarse documentación acerca del toolbox deep learning en el siguiente [link](https://la.mathworks.com/help/deeplearning/ref/fitnet.html).

### Instalación del Toolbox EEG Analysis
El Toolbox EEG Analysis es compatible con el entorno MATLAB 2019. Para empezar a utilizarlo, debe descagarse el contenido de esta carpeta.
1. Abrir MATLAB y colocar esta carpeta como folder actual.
2. En la consola escribe el comando **run('procesamiento')** y presiona enter. 
3. Al abrise la ventana principal, presiona el botón cargar para seleccionar 
el archivo EDF de la señal EEG a analizar.
