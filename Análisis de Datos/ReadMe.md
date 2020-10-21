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
1. Cruces por zero (ZC)
2. Valor medio absoluto (MAV)
3. Curtosis
4. Desviación estándar
El análisis wavelet descompone la señal EEG en subbandas que contienen los 5 ritmos cerebrales (Alfa, Beta, Gamma, Theta y Delta) y extrae de los coeficientes de aproximación de cada subbanda las siguientes características:
1. Potencia
2. Media
3. Curtosis
4. Desviación Estándar
5. Asimetría estadística
6. Cruces por cero (ZC)
### Clasificadores


### Descripción del Toolbox EEG Analysis
### Instalación del Toolbox EEG Analysis
### Ejemplos de Funcionamiento del Toolbox EEG Analysis

