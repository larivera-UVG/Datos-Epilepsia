%Generador de matrices features con funcion Features_edf
% Las pruebas se realizaron con 10 grabaciones de 5 pacientes distintos siendo
%"edf" la opción de la grabacion a analizar. 
% Pueden elegirse de 2-4 canales a procesar.
% Paciente: (1-5) 
% si custering==0 se generan las matrices de caracteristicas con etiquetas
%reales sin crisis/con crisis si clustering==1 se generan las amtrices con
%kmeans
%Si se desea un nuevo edf especificar nombre y ruta, colocar clustering=1 edf=0
clustering=1;
paciente=1;
edf=1;
canales = 1;
muestras = 2000;
ruta = 'C:\Users\USUARIO\OneDrive Personal\OneDrive\Megaproyecto\Base de datos\edf_files\';
Fs = 256;
if edf ==0
    nombre = '';
elseif edf==1
    nombre = 'chb01_15';
elseif edf==2
    nombre = 'chb01_16';
elseif edf==3
    nombre = 'chb02_16';
elseif edf==4
    nombre = 'chb02_19';
elseif edf==5
    nombre = 'chb03_03';
elseif edf==6
    nombre = 'chb03_04';
elseif edf==7
    nombre = 'chb05_13';
elseif edf==8
    nombre = 'chb05_22';
    paciente=4;
elseif edf==9
    nombre = 'chb11_82';
elseif edf==10
    nombre = 'chb11_92';
end
if clustering==1
%Colocar ruta de archivos de prueba edf
[header, recorddata] = edfread([ruta,nombre,'.edf']);

%Para llamar función de Features_edf
%Indicar número de canales que se desean analizar, número de muestras
%por cada ventana tomar en cuenta Fs = 256Hz 
[Matriz_Features,channel_ventana,c]= Features_edf(recorddata,canales,muestras);

%Guardar vector de caracteristicas con K_means 
if canales==1
    csvwrite(['Features_',nombre,'_',num2str(c(1)),'.csv'],Matriz_Features);
    csvwrite([nombre,'_',num2str(c(1)),'_Data','.csv'],channel_ventana);
elseif canales==2
    csvwrite(['Features_',nombre,'_',num2str(c(1)),'_',num2str(c(2)),'.csv'],Matriz_Features);
    csvwrite([nombre,'_',num2str(c(1)),num2str(c(2)),'_Data','.csv'],channel_ventana);
elseif canales==3
    csvwrite(['Features_',nombre,'_',num2str(c(1)),num2str(c(2)),num2str(c(3)),'.csv'],Matriz_Features);
    csvwrite([nombre,'_',num2str(c(1)),num2str(c(2)),num2str(c(3)),'_Data','.csv'],channel_ventana);
elseif canales==4
    csvwrite(['Features_',nombre,'_',num2str(c(1)),'_',num2str(c(2)),'_',num2str(c(3)),'_',num2str(c(4)),'.csv'],Matriz_Features);
    csvwrite([nombre,'_',num2str(c(1)),num2str(c(2)),num2str(c(3)),num2str(c(4)),'_Data','.csv'],channel_ventana);
end

elseif clustering==0
    if paciente==1  %chb01- 15 - 16
        [header, traindata] = edfread('C:\Users\USUARIO\OneDrive Personal\OneDrive\Megaproyecto\Base de datos\edf_files\chb01_15.edf');
        [header, testdata] = edfread('C:\Users\USUARIO\OneDrive Personal\OneDrive\Megaproyecto\Base de datos\edf_files\chb01_16.edf');
        inicio_crisis_train = 1732*Fs;
        fin_crisis_train= 1772*Fs;
        inicio_crisis_test = 1015*Fs;
        fin_crisis_test= 1066*Fs;
    elseif paciente==2  %chb02 16 - 19
        [header, traindata] = edfread('C:\Users\USUARIO\OneDrive Personal\OneDrive\Megaproyecto\Base de datos\edf_files\chb02_16.edf');
        [header, testdata] = edfread('C:\Users\USUARIO\OneDrive Personal\OneDrive\Megaproyecto\Base de datos\edf_files\chb02_19.edf');
        inicio_crisis_train = 130*Fs;
        fin_crisis_train= 212*Fs;
        inicio_crisis_test = 1015*Fs;
        fin_crisis_test= 1066*Fs;
    elseif paciente==3  %chb03 03 - 04
        [header, traindata] = edfread('C:\Users\USUARIO\OneDrive Personal\OneDrive\Megaproyecto\Base de datos\edf_files\chb03_03.edf');
        [header, testdata] = edfread('C:\Users\USUARIO\OneDrive Personal\OneDrive\Megaproyecto\Base de datos\edf_files\chb03_04.edf');
        inicio_crisis_train = 1732*Fs;
        fin_crisis_train= 1772*Fs;
        inicio_crisis_test = 1015*Fs;
        fin_crisis_test= 1066*Fs;
    elseif paciente==4   %chb05 13 - 22
        [header, traindata] = edfread('C:\Users\USUARIO\OneDrive Personal\OneDrive\Megaproyecto\Base de datos\edf_files\chb05_13.edf');
        [header, testdata] = edfread('C:\Users\USUARIO\OneDrive Personal\OneDrive\Megaproyecto\Base de datos\edf_files\chb05_22.edf');
        inicio_crisis_train = 1732*Fs;
        fin_crisis_train= 1772*Fs;
        inicio_crisis_test = 1015*Fs;
        fin_crisis_test= 1066*Fs;
    elseif paciente==5  %chb11 82 - 92
        [header, traindata] = edfread('C:\Users\USUARIO\OneDrive Personal\OneDrive\Megaproyecto\Base de datos\edf_files\chb11_82.edf');
        [header, testdata] = edfread('C:\Users\USUARIO\OneDrive Personal\OneDrive\Megaproyecto\Base de datos\edf_files\chb11_92.edf');
        inicio_crisis_train = 1732*Fs;
        fin_crisis_train= 1772*Fs;
        inicio_crisis_test = 1015*Fs;
        fin_crisis_test= 1066*Fs;
    end
    train_crisis = traindata(:,inicio_crisis_train:fin_crisis_train);
    train_sin_crisis = [traindata(:,1:inicio_crisis_train-1),traindata(:,fin_crisis_train+1:end)];
    test_crisis = testdata(:,inicio_crisis_test:fin_crisis_test);
    test_sin_crisis = [testdata(:,1:inicio_crisis_test-1),testdata(:,fin_crisis_test+1:end)];
    [Matriz_Features_crisis,channel_ventana_crisis,c]= Features_edf(train_crisis,canales,muestras);
    [Matriz_Features_scrisis,channel_ventana_scrisis,c1]= Features_edf(train_sin_crisis,canales,muestras);
    [test_Features_crisis,test_ventana_crisis,c2]= Features_edf(test_crisis,canales,muestras);
    [test_Features_scrisis,test_ventana_scrisis,c3]= Features_edf(test_sin_crisis,canales,muestras);
   
    %concatenar features con crisis y sin crisis en matriz caracteristicas
    Matriz_Features = [Matriz_Features_crisis;Matriz_Features_scrisis];
    channel_ventana= [channel_ventana_crisis;channel_ventana_scrisis];
    Matriz_Features1 = [test_Features_crisis;test_Features_scrisis];
    channel_ventana1= [test_ventana_crisis;test_ventana_scrisis];
    
    %Guardar .csv
    csvwrite(['Features_train_paciente_',num2str(paciente),'.csv'],Matriz_Features);
    csvwrite(['Features_test_paciente_',num2str(paciente),'.csv'],Matriz_Features1);
end
%-----------------------------------------------------------------------



%Graficar
%Descomentar si se desea graficar
% figure(3);
% [D, P]=VAT(Matriz_Features);
% figure(4);
% hold off
% t = 0:length(channel_ventana)-1;
% 
% if length(c)==1
%     subplot(2,2,1);
%     plot(t, channel_ventana(:,1), '-r');
%     ylabel(['Canal ',num2str(c(1))])
%     xlabel('Muestras')
% elseif length(c)==2
%     subplot(2,2,1);
%     plot(t, channel_ventana(:,1), '-r');
%     ylabel(['Canal ',num2str(c(1))])
%     xlabel('Muestras')
%     subplot(2,2,2);
%     plot(t, channel_ventana(:,2),'b');
%     ylabel(['Canal ',num2str(c(2))])
%     xlabel('Muestras')  
% elseif length(c)==3
%     subplot(2,2,1);
%     plot(t, channel_ventana(:,1), '-r');
%     ylabel(['Canal ',num2str(c(1))])
%     xlabel('Muestras')
%     subplot(2,2,2);
%     plot(t, channel_ventana(:,2),'b');
%     ylabel(['Canal ',num2str(c(2))])
%     xlabel('Muestras')
%     subplot(2,2,3);
%     plot(t, channel_ventana(:,3),'b');
%     ylabel(['Canal ',num2str(c(3))])
%     xlabel('Muestras')
% elseif length(c)==4
%     subplot(2,2,1);
%     plot(t, channel_ventana(:,1), '-r');
%     ylabel(['Canal ',num2str(c(1))])
%     xlabel('Muestras')
%     subplot(2,2,2);
%     plot(t, channel_ventana(:,2),'b');
%     ylabel(['Canal ',num2str(c(2))])
%     xlabel('Muestras')
%     subplot(2,2,3);
%     plot(t, channel_ventana(:,3),'b');
%     ylabel(['Canal ',num2str(c(3))])
%     xlabel('Muestras')
%     subplot(2,2,4);
%     plot(t, channel_ventana(:,4),'b');
%     ylabel(['Canal ',num2str(c(4))])
%     xlabel('Muestras')
% end
% 
