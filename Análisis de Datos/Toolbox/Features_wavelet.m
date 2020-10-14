function [M_features,ritmo,coeff,tag] = Features_wavelet(eeg,muestras,c,waveletFunction,banda,op)
%Descomentar siguiente linea si no se desea concatenar los resultados en matriz
%function [power,max,min,curtosis] = Features_wavelet(signal,muestras,waveletFunction,banda)
%La funci�n utiliza 6niveles de descomposici�n para una Fs de 256Hz
% Verificar si aplica para la Fs a utilizar - ceil(log2(Fs/4))
%signal : se�al EEG de un canal 
%muestras: tama�o de ventana
% waveletfun: funcion wavelet a usar
% banda: nivel de descomposici�n de la se�al a analizar
%o op: vector de caracteristicas deseadas [power,media,desviacion,curtosis,asimetria,zc]=[1,1,1,1,1,1]
%arreglar dimension
if size(eeg,1)<size(eeg,2)
    eeg = eeg';
end
signal = eeg(:,c);
%Realizar ventana
j=0;
i=1;        %recorrer muestras
flag=0;
size_c = length(signal);
channel_ventana = zeros(size_c,1);
media = zeros(round(size_c/muestras)-1,1);
power = zeros(round(size_c/muestras)-1,1);
z = zeros(length(eeg),1);
zc = zeros(round(size_c/muestras)-1,1);
oblicuidad = zeros(round(size_c/muestras)-1,1);
curtosis = zeros(round(size_c/muestras)-1,1);
desviacion = std(round(size_c/muestras)-1,1);
%zero crossing index function
max_amplitud = max(abs(eeg))*0.02; % 2% de la amplitud de la se�al 
umbral = max_amplitud(1,1);
z =  ZC(eeg(:,1),umbral)'; %Calcular todos los ZC de la se�al
while(1)
     
     channel_ventana(i,1) = signal(i,1); 
        i = i+1;        
        if(mod(i,(muestras+1))==0)      
            flag = flag+1;
            %Calcular descomposici�n wavelet
            [C,L] = wavedec(channel_ventana(1+(j*muestras):(flag*muestras)),7,waveletFunction);
            %Calcular coeficientes en el nivel especificado
            if banda==8
                cD = appcoef(C,L,waveletFunction,7); 
            elseif banda<=7 && banda>0
                cD = detcoef(C,L,banda);
            end
            %Calcular reconstruccion de coeficientes para 
            %encontrar potencia (PSD)
            if banda==8
                D = wrcoef('a',C,L,waveletFunction,7);  
            elseif banda<=7 && banda>0
                D = wrcoef('d',C,L,waveletFunction,banda);
            end
            %Calcular caracteristicas de cada ventana
            power(flag,1) = (sum(D.^2))/length(D);
            media(flag,1) = mean(D);
            desviacion(flag,1) = std(D);
            curtosis(flag,1) = var(D);
            oblicuidad(flag,1) = skewness(D);
            if(j>0) %contar ZC por cada ventana
                zc(flag,1) = sum(z(j*muestras:i,1) == 1); 
            else
                     zc(flag,1) = sum(z(1:(i-1),1) == 1);
            end
            j = j+1;
        end
        if (i==size_c) 
            flag=0;
            i=1; 
            break;
        end  
end
if banda==2
    ritmo= 'G';
elseif banda==3
    ritmo= 'G B';
elseif banda==4
    ritmo= 'B A';
elseif banda==5
    ritmo= 'A T';
elseif banda==6
    ritmo= 'T D';
elseif banda==7
    ritmo= 'D';
elseif banda==8
    ritmo= 'Aprox';
end
%concatenar features en una matriz
features =  [power,media,desviacion,curtosis,oblicuidad,zc];
a=0;
b=0;
index= zeros(1,6);
for i=1:6    
    if op(i)==0
       features(:,i-a)=[]; %eliminar columna no deseada
       a=1;   %restar dim a feature vector 
       
    end
    if op(i)==1
        index(i)= 1;
        b=1;
    end
end
tag1='';tag2='';tag3='';tag4='';tag5='';tag6='';
for i=1:length(index)
   if index(1)
       tag1 = ' POTENCIA,';
   end
   if index(2)
       tag2 = ' MEDIA,';
   end
   if index(3)
       tag3 = ' DESVIACI�N,';
   end
   if index(4)
       tag4 = ' CURTOSIS,';
   end
   if index(5)
       tag5 = ' ASIMETR�A,';
   elseif index(6)
       tag6 = ' ZC,';
   end
end
tag = [tag1,tag2,tag3,tag4,tag5,tag6];
M_features = features;
coeff = cD;
end

