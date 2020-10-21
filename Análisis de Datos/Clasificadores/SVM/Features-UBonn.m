%Pruebas para encontrar matriz de caracteristicas y vector de clases
%Se comparan 6 señales de set A con set E y set B con set E (Total 12) 
%En cada grabación: Fs = 173.61 Hz, 4097 muestras - 24s de grabación

%Para comparación de set A con set E se utilizan las siguientes señales:
% Set E pacientes epilépticos fase ictal: S100 S080 S060 S040 S020 S001
% Set A pacientes normales ojos abiertos: Z100 Z020 Z030 Z040 Z050 Z060
%Para comparación de set B con set E se utilizan las siguientes señales:
%Set E pacientes epilépticos fase ictal: S015 S025 S035 S045 S055 S065
% Set B pacientes normales ojos cerrados: O100 O090 O080 O070 O060 O050
%------------------------------------------------------------------------
% Si se desea analizar otras señales de los sets descomentar siguiente
% lineas y editar cuales señales se desean y colocar opcion=13
% canalconcrisis = load('<ruta>\<nombrearchivo>.txt');
% canalsincrisis = load('<ruta>\<nombrearchivo>.txt');
%------------------------------------------------------------------------

%Cambiar variable opción: 1-6 para comparar set A - set E
%Cambiar variable opción: 7-12 para comparar set B - set E
opcion = 2;

%Definir tamaño de ventana
%Para los experimentos se utilizó muestras = 150 y 80
muestras =150; 

load SEÑALES.mat

if opcion==1
   Seizure_active = S100;
   Normal_pacients = Z100;
   name=1;
elseif opcion==2
   Seizure_active = S080;
   Normal_pacients = Z020; 
   name=2;
elseif opcion==3
   Seizure_active =S060;
   Normal_pacients = Z030;
   name=3;
elseif opcion==4
   Seizure_active = S040;
   Normal_pacients = Z040;
   name=4;
elseif opcion==5
   Seizure_active = S020;
   Normal_pacients = Z050;
   name=5;
elseif opcion==6
   Seizure_active = S001;
   Normal_pacients = Z060;
   name=6;
elseif opcion==7
   Seizure_active = S015;
   Normal_pacients = O100;
   name=7;
elseif opcion==8
   Seizure_active = S025;
   Normal_pacients = O090;
   name=8;
elseif opcion==9
   Seizure_active = S035;
   Normal_pacients = O080;
   name=9;
elseif opcion==10
   Seizure_active = S045;
   Normal_pacients = O070;
   name=10;
elseif opcion==11
   Seizure_active = S055;
   Normal_pacients = O060;
   name=11;
elseif opcion==12
   Seizure_active = S065;
   Normal_pacients =  O050;
   name=12;
elseif opcion==13
    Seizure_active = canalconcrisis;
    Normal_pacients = canalsincrisis;
end

%Preprocesamiento: FILTROS
Fs = 173.61;
fred_electrica = designfilt('bandstopiir','FilterOrder',2, ...
                'HalfPowerFrequency1',59,'HalfPowerFrequency2',61, ...
                'DesignMethod','butter','SampleRate',Fs);
fruido = designfilt('bandstopiir','FilterOrder',2, ...
                'HalfPowerFrequency1',0.5,'HalfPowerFrequency2',70, ...
                'DesignMethod','butter','SampleRate',Fs);
lowpass = designfilt('lowpassiir','FilterOrder',8, ...
         'PassbandFrequency',49,'PassbandRipple',0.2, ...
         'SampleRate',Fs);
     
%Definir canales a analizar
channel1 = Seizure_active; 
channel2 = Normal_pacients;      


% Aplicar los filtros a los canales
channel2 = filtfilt(fred_electrica,channel2);
channel1 = filtfilt(fred_electrica,channel1);
channel2 = filtfilt(fruido,channel2);
channel1 = filtfilt(fruido,channel1);
channel2 = filtfilt(lowpass,channel2);
channel1 = filtfilt(lowpass,channel1);

%Normalizar señales
channel1 = channel1/max(Normal_pacients);
channel2 = channel2/max(Seizure_active);

%Realizar ventana
i=1;
j=1;
flag=0;
clase=1;
size_c1 = length(channel1);
size_c2 = length(channel2);
channel1_ventana = zeros(size_c1,1);
channel2_ventana = zeros(size_c2,1);
while(1)
    channel1_ventana(i,1) = channel1(j,1); 
        channel2_ventana(i,1) = channel2(j,1);  
        i = i+1;        
        j = j+1;
        if(mod(i,(muestras+1))==0)      %Calcular caracteristicas de cada ventana
            flag = flag+1;
            varianza1(flag,1) = var(channel1_ventana);
            mav1(flag,1) = mean(abs(channel1_ventana));
            curtosis1(flag,1) = kurtosis (channel1_ventana);
            varianza2(flag,1) = var(channel2_ventana);
            mav2(flag,1) = mean(abs(channel2_ventana));
            curtosis2(flag,1) = kurtosis (channel2_ventana);
        end
        if (j>size_c1 || j>size_c2)
            i=1;
            j=1;
            break;
        end  
end

% Concatenar vector de características
features = [varianza1,curtosis1,mav1;varianza2,curtosis2,mav2];
%Guardar vector de caracteristicas
csvwrite(['Matriz_Features',num2str(name),'.csv'],features);

 %Graficar
  t = 0:length(varianza1)-1;
  title('Características Encontradas')
  subplot(3,2,1);
  plot(t,varianza1','color','r');
  ylabel('Varianza set E')
  xlabel('tiempo (s)')
  xlim([0 24]);
  subplot(3,2,2);
  plot(t,varianza2','color','b');
  ylabel('Varianza set A')
  xlabel('tiempo (s)')
  xlim([0 24]);
  subplot(3,2,3);
  plot(t,curtosis1','color','r');
  ylabel('Curtosis set E')
  xlabel('tiempo (s)')
  subplot(3,2,4);
  plot(t,curtosis2','color','b');
  ylabel('Curtosis set A')
  xlabel('tiempo (s)')
  xlim([0 24]);
  subplot(3,2,5);
  plot(t,curtosis1','color','r');
  ylabel('MAV set E')
  xlabel('tiempo (s)')
  xlim([0 24]);
  subplot(3,2,6);
  plot(t,curtosis2','color','b');
  ylabel('MAV set A')
  xlabel('tiempo (s)')
  xlim([0 24]);
