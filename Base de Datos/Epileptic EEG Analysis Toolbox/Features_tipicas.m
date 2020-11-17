function [Matriz_features,c] = Features_tipicas(edf,fs,canales,muestras,c,op)
% ARGUMENTOS DE LA FUNCION
%edf:   archivo .edf con señal EEG a analizar
%canales: número de canales para encontrar features (1-4)
%muestras: número de muestras para realizar ventanas
%op=0 vector de opciones [111111] MEdia , mav, zc, Amax, std, crutosis
%arreglar dimension

eeg(:,1)= edf';


%Preprocesamiento: FILTROS
Fs = fs;
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
media = zeros(round(size_c/muestras)-1,canales);
mav = zeros(round(size_c/muestras)-1,canales);
z = zeros(length(eeg),canales);
zc = zeros(round(size_c/muestras)-1,canales);
fmax = zeros(round(size_c/muestras)-1,canales);
desviacion = zeros(round(size_c/muestras)-1,canales);
curtosis = zeros(round(size_c/muestras)-1,canales);
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
            if op(1)==1
                media(flag,k) = mean(channel_ventana(:,k));
            elseif op(2) ==1
                mav(flag,k) = mean(abs(channel_ventana(:,k)));
            elseif op(4)==1
                picos = findpeaks(channel_ventana(:,k)');
                fmax(flag,k)=max(picos);   
            elseif op(5)==1
                desviacion(flag,k) = std(channel_ventana(:,k));    
            elseif op(6)==1
                 curtosis(flag,k) = kurtosis(channel_ventana(:,k));
            elseif op(3)==1
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
            end   
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
b=0;

totfeatures(:,1:6) = [media(:,i),mav(:,i),zc(:,i),fmax(:,i), desviacion(:,i),curtosis(:,i)];



for i=1:6
   if op(i)==1 
       vfeatures(:,1) = totfeatures(:,i); 
   end
end
Matriz_features = vfeatures;
end