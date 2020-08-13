% Se obtiene la matriz de features tomando en cuenta ZC y MAV 
% a partir de un eeg, pueden analizarse hasta 4 canales.
% Se devuelve la matrix de features, la matriz de data procesada y
% los canales que se analizaron.
function [Matriz_features,channel_ventana,c] = Features_edf(edf,canales,muestras)
% ARGUMENTOS DE LA FUNCION
%edf:   archivo .edf con señal EEG a analizar
%canales: número de canales para encontrar features (1-4)
%muestras: número de muestras para realizar ventanas

%Definir canales a analizar
for i=1:canales
    c(i)= randi([1 23]);
    eeg(:,i)= edf(i,:)';
end
%Preprocesamiento: FILTROS
Fs = 256;
fred_electrica = designfilt('bandstopiir','FilterOrder',2, ...
                'HalfPowerFrequency1',59,'HalfPowerFrequency2',61, ...
                'DesignMethod','butter','SampleRate',Fs);
fruido = designfilt('bandstopiir','FilterOrder',2, ...
                'HalfPowerFrequency1',0.5,'HalfPowerFrequency2',70, ...
                'DesignMethod','butter','SampleRate',Fs);
lowpass = designfilt('lowpassiir','FilterOrder',8, ...
         'PassbandFrequency',49,'PassbandRipple',0.2, ...
         'SampleRate',Fs);
channels = filtfilt(fred_electrica,eeg);

%for i=1:canales
    %Normalizar señales
%    channels(:,i) = channels/max(channels(:,i));
%end
%Realizar ventana
k=1;        %recorrer canales
i=1;        %recorrer muestras
j=0;
flag=0;
size_c = length(channels);
channel_ventana = zeros(size_c,canales);
zc = zeros(round(size_c/muestras)-1,canales);
mav = zeros(round(size_c/muestras)-1,canales);
%varianza = zeros(round(size_c/muestras)-1,canales);
%zero crossing index function
umbral = 0.005;
if canales==1
    z1 = ZC(channels(:,1),umbral)'; %Calcular todos los ZC de la señal
elseif canales==2
    z1 = ZC(channels(:,1),umbral)';
    z2 = ZC(channels(:,2),umbral)'; 
elseif canales==3
    z1 = ZC(channels(:,1),umbral)';
    z2 = ZC(channels(:,2),umbral)'; 
    z3 = ZC(channels(:,3),umbral)'; 
elseif canales==4
    z1 = ZC(channels(:,1),umbral)';
    z2 = ZC(channels(:,2),umbral)'; 
    z3 = ZC(channels(:,3),umbral)'; 
    z4 = ZC(channels(:,4),umbral)'; 
end

while(1)
     
     channel_ventana(i,k) = channels(i,k); 
        i = i+1;        
        if(mod(i,(muestras+1))==0)      %Calcular caracteristicas de cada ventana
            flag = flag+1;
            mav(flag,k) = mean(abs(channel_ventana(:,k)));
           %varianza(flag,k) = var(channel_ventana(:,k));
           % picos = findpeaks(channel_ventana(:,k)');
            if(j>0) %contar ZC por cada ventana
                if canales==1
                    zc(flag,1) = sum(z1(j*muestras:i) == 1);
                elseif canales==2
                    zc(flag,1) = sum(z1(j*muestras:i) == 1);
                    zc(flag,2) = sum(z2(j*muestras:i) == 1);
                elseif canales==3
                    zc(flag,1) = sum(z1(j*muestras:i) == 1);
                    zc(flag,2) = sum(z2(j*muestras:i) == 1);
                    zc(flag,3) = sum(z3(j*muestras:i) == 1);
                elseif canales==4
                    zc(flag,1) = sum(z1(j*muestras:i) == 1);
                    zc(flag,2) = sum(z2(j*muestras:i) == 1);
                    zc(flag,3) = sum(z3(j*muestras:i) == 1);
                    zc(flag,4) = sum(z4(j*muestras:i) == 1);
                end
            else
                if canales==1
                    zc(flag,1) = sum(z1(1:(i-1)) == 1);
                elseif canales==2
                    zc(flag,1) = sum(z1(1:(i-1)) == 1);
                    zc(flag,2) = sum(z2(1:(i-1)) == 1);
                elseif canales==3
                    zc(flag,1) = sum(z1(1:(i-1)) == 1);
                    zc(flag,2) = sum(z2(1:(i-1)) == 1);
                    zc(flag,3) = sum(z3(1:(i-1)) == 1);
                elseif canales==4
                    zc(flag,1) = sum(z1(1:(i-1)) == 1);
                    zc(flag,2) = sum(z2(1:(i-1)) == 1);
                    zc(flag,3) = sum(z3(1:(i-1)) == 1);
                    zc(flag,4) = sum(z4(1:(i-1)) == 1);
                end
            end
            j= j+1;   
           % fmax(flag,k)=max(picos);
        end
     if (i==size_c) 
            k=k+1;
            flag=0;
            i=1; 
            j=0;   
     end  
     if(k>canales)
            break;
     end
end
%Concatenar vector de características
    Matriz_features(:,1:2) = [mav(:,1),zc(:,1)];
if canales==2
    Matriz_features(:,3:4) = [mav(:,2),zc(:,2)];
elseif canales==3
    Matriz_features(:,3:4) = [mav(:,2),zc(:,2)];
    Matriz_features(:,5:6) = [mav(:,3),zc(:,3)];
elseif canales==4
    Matriz_features(:,3:4) = [mav(:,2),zc(:,2)];
    Matriz_features(:,5:6) = [mav(:,3),zc(:,3)];
    Matriz_features(:,7:8) = [mav(:,4),zc(:,4)];
end
end

