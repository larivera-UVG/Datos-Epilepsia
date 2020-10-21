# Análisis de Señales EEG de Pacientes con Epilepsia Implementando Algoritmos de Aprendizaje Automático Mediante Toolbox
Se calcula que hay 50 millones de afectados por la epilepsia en todo el mundo. Sin embargo, el estudio de esta enfermedad sigue siendo reservado a minorías de neurólogos. El análisis de señales EEG de pacientes epilépticos es un área de estudio de constante investigación. En este proyecto se aplican técnicas y algoritmos de aprendizaje de máquina o aprendizaje automático a señales EEG de pacientes con epilepsia con el fin de encontrar características y patrones que permitan detectar la presencia de crisis epilépticas en dichas señales. Para ello, se implementan los clasificadores, máquinas de vectores de soporte (SVM) y redes neuronales artificiales (ANN). Con el fin de motivar y facilitar proyectos de investigación relacionados a la detección de crisis y extracción de características de las señales biomédicas de pacientes epilépticos se diseña una herramienta de software (Toolbox) el cual incluye una interfaz gráfica para el usuario y genera resultados de los clasificadores mencionados. Adicionalmente, el toolbox permite la visualización de las señales y la extracción de características relevantes para optimizar la generación de pruebas en trabajos de investigación.

Para ejemplificar su funcionamiento, en los resultados de este repositorio se utilizan señales EEG de tres diferentes bases de datos, “UBonn EEG Dataset”, “CHB-MIT” y datos obtenidos del Centro de Epilepsia y Neurocirugía Funcional (HUMANA). En todos los casos, se utilizan características del dominio del tiempo: varianza, valor medio absoluto, curtosis, cruces por cero, desviación estándar y adicionalmente se realiza un análisis de características del tiempo-escala mediante la descomposición Wavelet: potencia, curtosis, cruzes por cero, desviación estándar, valor medio absoluto y asimetría estadística.

## Tabla de contenido
- [Características del EEG](#caracteristicas-del-eeg).
- [Clasificadores](#clasificadores).
- [Descripción del Toolbox EEG Analysis](#descripcion-del-toolbox-eeg-analysis).
- [Instalación del Toolbox EEG Analysis](#funciones-del-toolbox-eeg-analysis).
- [Ejemplos de Funcionamiento del Toolbox EEG Analysis](#ejemplos-de-funcionamiento-del-toolbox-eeg-analysis).

## Extructura de las Carpetas
```
##### Análisis de señales EEG de pacientes con epilepsia
.
├── _Clasificadores
│   ├── SVM: Código MATLAB 
│   └── ANN: Código MATLAB 
├── _Clustering
│   ├── K-medias y FCM HUMANA Base de Datos
├── _Documentos
│   ├── Protocolo de Tesis
│   └── Tesis
├── _Funciones: Códigos MATLAB
│   ├── Features_edf
│   └── Features_wavelet
|   └── Edfread
|   └── FCM
|   └── K_means
|   └── LabelsGen
|   └── Graficar_Clusters
|   └── VAT
|   └── ZC
├── _Resultados Finales: Matrices de Confusión
│   ├── HUMANA
│   └── Physionet
│   └── UBonn
├── _Toolbox EEG Analysis
│   ├── Imágenes
│   └── _Códigos MATLAB
|       └── Features
|       └── Features_wavelet
|       └── ZC
|       └── EdfRead
│   └── _Códigos MATLAB AppDesigner
|       └── Procesamiento
|       └── Features
|       └── ClasificadorSVM
|       └── ClasificadorRN
├── _Wavelet
|   ├── Wavelet: código MATLAB
|   └── Imágenes sub-bandas Wavelets
```
### Características del EEG
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
El algoritmo de clasificación SVM implementado en el toolbox, permite un clasificador binario para detectar registros de la señal EEG "normales" e "ictales", es decir, segmentos de la señal con crisis y sin crisis epilépticas. Utiliza las funciones fitcsvm y predict del toolbox de stadistics and machine learning de MATLAB.

Estas funciones, validan cruzadamente un modelo de máquina vectorial de soporte (SVM) para la clasificación de dos clases (binarias) en un conjunto de datos predictor de baja dimensión o de dimensión moderada. admite la asignación de datos predictores mediante funciones del kernel y admite la optimización mínima secuencial (SMO), el algoritmo iterativo de datos únicos (ISDA) o 1 minimización de margen flexible a través de la programación cuadrática para la minimización de la función objetivo.
Encontrar documentación en el siguiente [link](https://la.mathworks.com/support/search.html?q=fitcs&page=1).

#### Redes Neuronales Artificiales ANN
El algoritmo de clasificación ANN implementado en el toolbox, permite un clasificador binario para detectar registros de la señal EEG "normales" e "ictales" de la señal EEG. Utiliza el toolbox deep learning de MATLAB. La función patternnet regresa una estructura que define la red neuronal según el número de capas ocultas y función de entrenamiento especificada. Se utiliza la función train para entrenamiento de la red y la función net para probar el algoritmo de clasificación.

Puede encontrarse documentación acerca del toolbox deep learning en el siguiente [link](https://la.mathworks.com/help/deeplearning/ref/fitnet.html).
### Descripción del Toolbox EEG Analysis
El toolbox EEG Analysis es una herramienta diseñada para facilitar el análisis e implementación de algoritmos de aprendizaje automático en señales EEG con el fin de caracterizar las señales EEG de pacientes con epilepsia y detectar la presencia de crisis en las mismas. El toolbox contiene las siguientes opciones predeterminadas:
1. @@Visualización de la señal EEG@@
Esta opción permite visualizar la señal EEG en formato EDF. El usuario tiene opción de seleccionar la señal a cargar de su computador, como se describe en la siguiente figura en esta ventana se incluye una gráfica de amplitud vs tiempo donde se muestra el canal especificado durante el período de tiempo seleccionado. Adicionalmente, puede seleccionarse señales de prueba en línea presentes en base de datos HUMANA para visualizar las señales EEG. 

![](https://github.com/larivera-UVG/Datos-Epilepsia/blob/master/An%C3%A1lisis%20de%20Datos/Toolbox%20EEG%20Analysis/Im%C3%A1genes/ventana1.JPG) 
##### Figura 1. Ventana de Visualización Toolbox EEG Anlaysis

2. @@ Extracción de Características@@
En esta ventana el usuario puede seleccionar opciones para extraer características de la señal previamente cargada, debe escogerse el número de canales a analizar y especificar los mismos, el tamaño de ventana y las características que desean extraerse. Como resultado, la herramienta entrega un archivo de formato MAT con el vector de característica y un vector de clases generado automáticamente con "ceros" y "unos" balanceados según el tamaño del vector de característica resultante. El vector de clases se genera tomándo en consideración que la señal EEG cargada se encuentra ordenada de forma que la primera mitad de las muestras de la señal corresponden a un tipo de registro y la siguiente mitad de las muestras corresponden al tipo de registro restante. Es decir que la cantidad de "ceros" presentes en el vector de clase es igual a la primera mitad de las muestras de la señal y la cantidad de "unos" equivalen a la mitad restante de las muestras de las señal.

En caso que la señal EEG no se encuentre ordenada de esta forma, el usuario debe generar manualmente el vector de clases y tendrá opción de cargarlo posteriormente en la ventana de clasificación del toolbox. El botón generar permite guardar el archivo de formato MAT en la ubicación que el usuario seleccione. El botón generar de la parte superior que se observa en la figura 2, calcula el resultado utilizando el análisis directo. El botón generar de la parte inferior, calcula el resultado mediante el análisis wavelet. Al generar resultados se habilitan las opciones de clasificadores, red neuronal y máquina de vectores de soporte.

![](https://github.com/larivera-UVG/Datos-Epilepsia/blob/master/An%C3%A1lisis%20de%20Datos/Toolbox%20EEG%20Analysis/Im%C3%A1genes/ventana2.JPG) 
##### Figura 2. Ventana de Extracción de Características Toolbox EEG Anlaysis

3. @@ Algoritmos de Clasificación @@
La herramienta utiliza los resultados generados en la ventana extracción de características para implementar el clasificador seleccionado por el usuario. Si se desean cargar vectores de características y clases externos debe utilizarse formato MAT donde se incluyan las siguientes variables:
```
1. data: Vector de características de dimensión nxm, donde n representa el número de ventanas seleccionadas para entrenamiento del clasificador y m la multiplicación del número de características por el número de canales analizados.
2. labels: Vector de dimensión nx1, que contiene "ceros" en las ventanas que representan la clase 1, y "unos" en las ventanas que representan la clase 2. El número de filas debe corresponder al número de ventanas que contiene el vector de características "data".
```
@@Para el clasificador SVM, el toolbox utiliza validación cruzada. El usuario debe seleccionar el número de particiones previo a cargar los datos para dividir el vector de características en muestras para entrenamiento y prueba del clasificador.@@

#### Redes Neuronales, ANN
La ventana de red neuronal permite seleccionar los porcentajes de entrenamiento, validación y testeo. Adicionalemnte puede elegir el algoritmo de entrenamiento de la red neuronal y escoger el número de capas ocultas. Si se desea implementar el clasificador con los resultados generados en la ventana de extracción de características, es importante especificar el tipo de análisis utilizado (directo o wavelet) para que la herramienta utilice el vector de características correcto al implementar el algoritmo de clasificación.

El botón visualizar, ver figura 3, entrega los resultados del toolbox deep learning de MATLAB, donde el usuario puede visualizar la estructura de la red, las matrices de confusión e indicadores típicos para evaluar desempeño del algoritmo. Adicionalmente se presenta un resumen en la parte inferior de los resultados obtenidos.
![](https://github.com/larivera-UVG/Datos-Epilepsia/blob/master/An%C3%A1lisis%20de%20Datos/Toolbox%20EEG%20Analysis/Im%C3%A1genes/ventana3.JPG) 
##### Figura 3. Ventana de Algoritmo de Clasificación: Redes Neuronales

#### Máquina de vectores de soporte, SVM
La ventana de SVM utiliza la técnica de validación cruzada mediante la función de MATLAB @@crossvalind@@ para dividir el vector de características en entrenamiento y prueba. El usuario puede seleccionar el número de particiones y el tipo de Kernel para implementar el algoritmo. Si se desea implementar el clasificador con los resultados generados en la ventana de extracción de características, es importante especificar el tipo de análisis utilizado (directo o wavelet) para que la herramienta utilice el vector de características correcto al implementar el algoritmo de clasificación.

El botón visualizar, ver figura 4, entrega los resultados del toolbox machine learning de MATLAB, donde el usuario puede visualizar la matriz de confusión. Adicionalmente se presenta en la parte inferior un resumen de la exactitud y resultados del algoritmo.

![](https://github.com/larivera-UVG/Datos-Epilepsia/blob/master/An%C3%A1lisis%20de%20Datos/Toolbox%20EEG%20Analysis/Im%C3%A1genes/ventana5.JPG )
##### Figura 4. Ventana de Algoritmo de Clasificación: Máquina de Vectores de Soporte

### Instalación del Toolbox EEG Analysis
### Ejemplos de Funcionamiento del Toolbox EEG Analysis

