%Pruebas para encontrar matriz de caracteristicas y vector de clases
%Se comparan señales de set A con set E y set D con set E 
%En cada grabación: Fs = 173.61 Hz, 4097 muestras - 24s de grabación


%Cambiar variable opción: 1 para comparar set A - set E
%Cambiar variable opción: 2 para comparar set D - set E
%Cambiar variable opción: 3 para cargar nuevos sets de datos
%indicar ruta de archivos nuevos a cargar descomentar siguiente linea
%dataconcrisis = load (''); datasincrisis = load (''); 
opcion = 2;

%Definir tamaño de ventana
%Para los experimentos se utilizó muestras = 4 y 8
muestras =4096; 
load Bonn_datasets.mat

Seizure_active = setEdata;
if opcion==1  
   Non_seizure = setAdata;
elseif opcion==2
   Non_seizure = setDdata; 
elseif opcion==3
    Seizure_active = dataconcrisis;
    Non_seizure = canalsincrisis;
end

%Preprocesamiento: FILTROS
Fs = 173.61;     
%Definir canales a analizar
channel1 = Seizure_active; 
channel2 = Non_seizure;      


%Normalizar señales
%channel1 = channel1/max(Non_seizure);
%channel2 = channel2/max(Seizure_active);

%Realizar ventana
i=1;
j=1;
p=0;
flag=0;
size_c = length(channel1);
channel1_ventana = zeros(size_c,1);
channel2_ventana = zeros(size_c,1);
curtosis1 = zeros(round(size_c/muestras)-1,1);
mav1 = zeros(round(size_c/muestras)-1,1);
desviacion1 = zeros(round(size_c/muestras)-1,1);
zc1 = zeros(round(size_c/muestras)-1,1);
curtosis2 = zeros(round(size_c/muestras)-1,1);
mav2 = zeros(round(size_c/muestras)-1,1);
zc2 = zeros(round(size_c/muestras)-1,1);
desviacion2 = zeros(round(size_c/muestras)-1,1);
%zero crossing index function
max_amplitud = max(abs(channel1))*0.02; % 2% de la amplitud de la señal 
umbral = max_amplitud(1,1);
z1 =  ZC(channel1,umbral)'; %Calcular todos los ZC de la señal
z2 =  ZC(channel2,umbral)'; 

while(1)
    channel1_ventana(i,1) = channel1(j,1); 
        channel2_ventana(i,1) = channel2(j,1);  
        i = i+1;        
        j = j+1;
        if(mod(i,(muestras+1))==0)      %Calcular caracteristicas de cada ventana
            flag = flag+1;
            mav1(flag,1) = mean(abs(channel1_ventana));
            curtosis1(flag,1) = kurtosis (channel1_ventana);
            desviacion1(flag,1) = std(channel1_ventana);
            if(p>0) %contar ZC por cada ventana
                zc1(flag,1) = sum(z1(p*muestras:i,1) == 1);
                zc2(flag,1) = sum(z2(p*muestras:i,1) == 1);
            else
               zc1(flag,1) = sum(z1(1:(i-1),1) == 1);
               zc2(flag,1) = sum(z2(1:(i-1),1) == 1);
            end 
            mav2(flag,1) = mean(abs(channel2_ventana));
            curtosis2(flag,1) = kurtosis (channel2_ventana);
            desviacion2(flag,1) = std(channel2_ventana);
            p= p+1; 
            
        end
        if j>size_c
            i=1;
            j=1;
            break;
        end  
end

% Concatenar vector de características
features = [zc2,curtosis2,mav2,desviacion2;zc1,curtosis1,mav1,desviacion1];
%Descomentar para guardar vector de caracteristicas
%csvwrite(['Matriz_Features',num2str(name),'.csv'],features);

%  Descomentar para graficar características
  t = 0:length(zc1)-1;
  title('Características Encontradas')
  subplot(4,2,1);
  plot(t,zc1','color','r');
  ylabel('ZC set E')
  xlabel('tiempo (s)')
  xlim([0 24]);
  subplot(4,2,2);
  plot(t,zc2','color','b');
  ylabel('ZC set A')
  xlabel('tiempo (s)')
  xlim([0 24]);
  subplot(4,2,3);
  plot(t,mav1','color','r');
  ylabel('MAV set E')
  xlabel('tiempo (s)')
  subplot(4,2,4);
  plot(t,mav2','color','b');
  ylabel('MAV set A')
  xlabel('tiempo (s)')
  xlim([0 24]);
  subplot(4,2,5);
  plot(t,curtosis1','color','r');
  ylabel('Curtosis set E')
  xlabel('tiempo (s)')
  xlim([0 24]);
  subplot(4,2,6);
  plot(t,curtosis2','color','b');
  ylabel('Curtosis set A')
  xlabel('tiempo (s)')
  xlim([0 24]);
  subplot(4,2,7);
  plot(t,desviacion1','color','r');
  ylabel('Desviación set E')
  xlabel('tiempo (s)')
  xlim([0 24]);
  subplot(4,2,8);
  plot(t,desviacion2','color','b');
  ylabel('Desviación set A')
  xlabel('tiempo (s)')
  xlim([0 24]);