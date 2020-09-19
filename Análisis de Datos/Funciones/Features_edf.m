% Se obtiene la matriz de features tomando en cuenta ZC y MAV 
% a partir de un eeg, pueden analizarse hasta 4 canales.
% Se devuelve la matrix de features, la matriz de data procesada y
% los canales que se analizaron.
%edf debe ingresarse en matriz de forma canales x muestras
function [Matriz_features,channel_ventana,c] = Features_edf(edf,canales,muestras,c,op)
% ARGUMENTOS DE LA FUNCION
%edf:   archivo .edf con señal EEG a analizar
%canales: número de canales para encontrar features (1-4)
%muestras: número de muestras para realizar ventanas
%op=0 MAV,ZC    op=1 varianza, curtosis, mav
%arreglar dimension
if size(edf,1)>size(edf,2)
    edf = edf';
end
ctot = size(edf,1);
%eeg = zeros(ctot,length(edf));
if c==0
%Definir canales a analizar
    comb = combnk(1:ctot,canales);
    x = randi([1 length(comb)],1);
    for i=1:canales
        eeg(:,i)= edf(comb(x,i),:)';
    end
else
    for i=1:canales
        eeg(:,i)= edf(c(i),:)';
    end
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
%channels = filtfilt(lowpass,eeg);
%channels = eeg;
%  for i=1:canales
%      %Normalizar señales
%      channels(:,i) = channels(:,i)/max(abs(channels(:,i)));
%  end
%Realizar ventana
k=1;        %recorrer canales
i=1;        %recorrer muestras
j=0;
flag=0;
size_c = length(channels);
channel_ventana = zeros(size_c,canales);
z = zeros(length(eeg),canales);
zc = zeros(round(size_c/muestras),canales);
mav = zeros(round(size_c/muestras),canales);
curtosis = zeros(round(size_c/muestras),canales);
desviacion = zeros(round(size_c/muestras),canales);
%zero crossing index function
max_amplitud = max(abs(channels))*0.02; % 2% de la amplitud de la señal 
umbral = max_amplitud(1,1);
for i=1:canales
   z(:,i) =  ZC(channels(:,i),umbral)'; %Calcular todos los ZC de la señal
end
while(1)
     
     channel_ventana(i,k) = channels(i,k); 
        i = i+1;        
        if(mod(i,(muestras+1))==0)      %Calcular caracteristicas de cada ventana
            flag = flag+1;
            mav(flag,k) = mean(abs(channel_ventana(:,k)));
            curtosis(flag,k) = kurtosis(channel_ventana(:,k));
            desviacion(flag,k) = std(channel_ventana(:,k));
            if(j>0) %contar ZC por cada ventana
                for o=1:canales
                    zc(flag,o) = sum(z(j*muestras:i,o) == 1);
                end 
            else
               for o=1:canales
                     zc(flag,o) = sum(z(1:(i-1),o) == 1);
                end 
            end
            j= j+1;   
            %fmax(flag,k)=max(picos);
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
a=0;
if op ==0
for i=1:canales
    Matriz_features(:,i+a:((i+a)+1)) = [mav(:,i),zc(:,i)];
    a=a+1;
end
elseif op==1
    for i=1:canales
    Matriz_features(:,i+a:((i+a)+3)) = [zc(:,i),mav(:,i),curtosis(:,i),desviacion(:,i)];
    a=a+3;
    end
end

end

