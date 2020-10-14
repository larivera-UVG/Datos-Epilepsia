%Analisis de señales EEG centro HUMANA
%--------------------------------- PUEDE MODIFICARSE .-------------------------------------
%Elegir edf: 1. AL  2. GIKA  3. CLEA
op =2;
%Elegir numero de canales (2-4)
canales = 2;
%Elegir numero de muestras por ventana
muestras= 2500; 
mostrar=0; %VER TODOS LOS CANALES mostrar=1
%--------------------------------------------------------------------------------------------
ruta = 'C:\Users\USUARIO\Downloads\HUMANA\';
%cargar archivos
if op==1
    nombre = 'AL';
elseif op==2
    nombre = 'GIKA';
elseif op==3
    nombre = 'CLEA';
elseif op==4
    nombre = '';
end
%[header, edf] = edfread([ruta,nombre,'.edf']);
Fs = header.frequency(1);
ctot = header.ns;               %# de canales presentes en el eeg
comb = combnk(1:ctot,canales);  %combinaciones para generar mejor respuesta
%i=1;
x = randi([1 length(comb)],1);
%----------------------------------------------------------------------------------------------
%Encontrar matriz de features 
if canales ==1    
    [Matriz_features,data,c] = Features_edf(edf,canales,muestras,x);
elseif canales ==2
    [Matriz_features,data,c] = Features_edf(edf,canales,muestras,[comb(x,1),comb(x,2)]);
elseif canales==3
    [Matriz_features,data,c] = Features_edf(edf,canales,muestras,[comb(x,1),comb(x,2),comb(x,3)]);
elseif canales==4
    [Matriz_features,data,c] = Features_edf(edf,canales,muestras,[comb(x,1),comb(x,2),comb(x,3),comb(x,4)]);
end
%----------------------------------------------------------------------------------------------
%Clustering: Fuzzy c-means
m=2;    %Numero de clusters
q=3;    %fuzzifier>1
[U, centros] = fcm(Matriz_features, m, q, 0);
%----------------------------------------------------------------------------------------------
%Clustering: K-means
[E, ~] = k_means(Matriz_features,m,0);
%----------------------------------------------------------------------------------------------
%Graficar Clustering
j=0;
for i=1:length(U)
    Predicted_clusters_fcm((j*muestras)+1:i*muestras,1) = U(i,1)*ones(muestras,1);
    Predicted_clusters_fcm((j*muestras)+1:i*muestras,2) = U(i,2)*ones(muestras,1);
    Predicted_clusters_km((j*muestras)+1:i*muestras,1) = E(i,1)*ones(muestras,1);
    j = j+1;
end
data = data(1:length(Predicted_clusters_fcm),:);
t1=1:length(Predicted_clusters_fcm);
figure(1);

for j = 1:m  
    for i=1:canales
    subplot(canales,1,i);
    hold off;
    scatter(t1,data(:,i), 2, Predicted_clusters_fcm(:,j), 'filled');
    ylabel('Predicción FCM ')
    xlabel(['Muestras canal ',num2str(c(i))])
    end
end
figure(2);
for j = 1:m
    subplot(canales,1,j);
    hold off;
    plot(t1(Predicted_clusters_km==1),data(Predicted_clusters_km==1,j),'color','b' )
    hold on;
    plot(t1(Predicted_clusters_km==2),data(Predicted_clusters_km==2,j),'color','y' )
    hold off;
    ylabel('Predicción KMeans ')
    xlabel(['Muestras canal ',num2str(c(i))])

end

