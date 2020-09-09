%Analisis de caracteristicas de data con crisis physionet
ruta = 'C:\Users\USUARIO\OneDrive Personal\OneDrive\Megaproyecto\Base de datos\edf_files\';
nombre = 'chb01_15';
[header, edf] = edfread([ruta,nombre,'.edf']);

Fs = header.frequency(1);
inicio_crisis = 59840;
fin_crisis = 72896;
ctot = header.ns;
%Analizar de muestra 200000-300000 
edf = edf(:,200000:300000);
% for i=1:canales
% %      %Normalizar señales
%       edf(:,i) = edf(:,i)/max(abs(edf(:,i)));
% end
muestras = 1000;
%Etiquetas con crisis/sin crisis
Real_labels(1:inicio_crisis-1) = zeros(inicio_crisis-1,1);
Real_labels(inicio_crisis:fin_crisis) = ones(length(inicio_crisis:fin_crisis),1);
Real_labels(fin_crisis+1:length(edf)) = zeros(length(fin_crisis+1:length(edf)),1);

t = 1:length(edf);
row = ctot/4;
if  rem(row,2)~=0
    row = round(row,0)+1;
end
figure(10);
for i=1:row
    subplot(row,1,i)
    plot(t(Real_labels==1),edf(i,Real_labels==1),'color','r')
    hold on;
    plot(t(Real_labels==0),edf(i,Real_labels==0),'color','b')
    ylabel('Amplitud ')
    xlabel(['Muestras canal ',num2str(i)])
end
figure(11);
for i=row+1:(row*2)
    subplot(row,1,i-row)
    plot(t(Real_labels==1),edf(i,Real_labels==1),'color','r')
    hold on;
    plot(t(Real_labels==0),edf(i,Real_labels==0),'color','b')
    ylabel('Amplitud ')
    xlabel(['Muestras canal ',num2str(i)])
end
figure(12);
for i=(row*2)+1:(row*3)
    subplot(row,1,i-(row*2))
    plot(t(Real_labels==1),edf(i,Real_labels==1),'color','r')
    hold on;
    plot(t(Real_labels==0),edf(i,Real_labels==0),'color','b')
    ylabel('Amplitud ')
    xlabel(['Muestras canal ',num2str(i)])
end
figure(13);
for i=(row*3)+1:ctot
    subplot(row,1,i-(row*3))
    plot(t(Real_labels==1),edf(i,Real_labels==1),'color','r')
    hold on;
    plot(t(Real_labels==0),edf(i,Real_labels==0),'color','b')
    ylabel('Amplitud ')
    xlabel(['Muestras canal ',num2str(i)])
end