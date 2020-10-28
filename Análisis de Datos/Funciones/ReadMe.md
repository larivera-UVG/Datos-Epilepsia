### Funciones para Análisis de Señales Biomédicas
En esta carpeta se encuentran funciones en formato ".m" (compatible con MATLAB) para analizar y procesar las señales biomédicas. Los scripts fueron adaptados para realizar las pruebas presentadas en la tesis que se detalla en la carpeta documentos. 

##### edfread

Esta función de MATLAB permite cargar archivos EDF. Como resultado obtiene una estructura donde se encuentra el encabeza (información y anotaciones presentes en el archivo) y un vector de nxm; donde n representa generalmente el número de canales de la señal y m las muestras registradas. Este vector representa la señal biomédica. Para mayor información consulta el siguiente [link](https://la.mathworks.com/matlabcentral/fileexchange/31900-edfread).

##### ZC

Esta función toma como argumentos la señal biomédica y un umbral para calcular los cruces por cero. El umbral debe escogerse como un porcentaje de la señal EEG para que este pueda ser significativo. Como resultado, la función entrega un vector de ceros y coloca un uno en la muestra que encontró el cruce por cero, adicionalmente entrega el total de cruces por cero de todo el vector.

##### Features_edf

Esta función toma como argumentos la señal biomédica,  la frequencia de muestreo, el número de canales a analizar, el tamaño de ventana que se desea, un vector que indica que canales se desea utilizar (0 en caso que se deseen todos los canales) y finalmente un vector de opciones de dimensión 1x4 el cual representa las características a extraer en el siguiente orden: [desviación, curtosis, cruces por cero, valor medio absoluto]. 

Ejemplo: si se desean extraer las 4 características el vector de opción sería el siguiente "[1,1,1,1]".

##### Features_wavelet

Esta función tiene como argumentos la señal biomédica, el tamaño de ventana, el canal a analizar (solo puede procesar 1 canal a la vez), la función de wavelet madre, el número de subbanda a escoger (2-6) las cuales representan los cinco ritmos cerebrales, y finalmente un vector de opción de 1x6 el cual representa las características a extraer en el siguiente orden: [Potencia,Media,Desviacion Estándar,Curtosis,Asimetría estadística,cruces por cero]. 

Ejemplo: si se desean extraer las 6 características el vector de opción sería el siguiente "[1,1,1,1,1,1]".

##### labelsGen

Esta función toma como argumentos el vector de características para entrenamiento y el vector de características para prueba y genera mediante el algoritmo k-means de 2 clases, el vector de etiquetas resultante de los vectores de características. Este vector puede utilizarse posteriormente en los scripts de los algoritmos de clasificación SVM y RB presentes en la carpeta de clasificadores. 

##### VAT
Esta función permite implementar el algoritmo VAT de un vector de características de cualquier dimensión. Este algoritmo facilita la visualización de clases presentes en la señal mediante distancias. Como resultado se obtiene una matriz coloreada, donde puede observarse en la diagonal principal un aproximado número de clusters (agrupamientos) que encuentra el algoritmo.

##### fcm y k_means
Estas funciones implementan los algoritmos de cluster  FCM (fuzzy c-means) y K-means(K medias). Como argumentos toman el vector de características de la señal y el número de clases que se desean y como resultado se obtiene un vector que contiene las características correspondientes a cada clase.

