%Encontrar vectores de características por descomposición de bandas en cada
%canal
prueba =2;
ftures = [1,1,1,1,1,1]; %[power,media,desviacion,curtosis,asimetria,zc]
op=1;       %op=1 se calcula matriz features para todas las bandas/ op=0 para una epecifica
banda = 1; %(de 1 a 5) 6 para aproximacion Gamma Beta Alpha Theta Delta
waveletFunction = 'db10'; %Daubechies 4 order wavelet  

if prueba==1
 load ('C:\Users\USUARIO\OneDrive Personal\OneDrive\Megaproyecto\Base de datos\SVM\Bonn_datasets.mat');
 muestras = 4096;
 Fs = 173.61; 
 i=1;
 signal1 = [setAdata;setEdata];
 %signal1 = [setDdata;setEdata];
elseif prueba==2
%cargar datos etiquetados de 5 pacientes de Physionet
 load 'C:\Users\USUARIO\Downloads\Physionet EEG scalp database\Physionet_data_etiquetada.mat'
 %Dejar un paciente afuera de train, para realizar testeo
%x = randi([1 5],1);
x=2;
if x==1
    traindata = [chb01(:,1:length(chb01/2)),chb03(:,1:length(chb03/2)),chb08(:,1:length(chb08/2)),...
        chb13(:,1:length(chb13/2)),chb01(:,length(chb01/2)+1:length(chb01)),chb03(:,length(chb03/2)+1:length(chb03))...
        ,chb13(:,length(chb13/2)+1:length(chb13))];
    testdata = chb15;
elseif x==2
    traindata = [chb01(:,1:length(chb01/2)),chb03(:,1:length(chb03/2)),chb08(:,1:length(chb08/2)),...
        chb15(:,1:length(chb15/2)),chb01(:,length(chb01/2)+1:length(chb01)),chb03(:,length(chb03/2)+1:length(chb03))...
        ,chb08(:,length(chb08/2)+1:length(chb08)),chb15(:,length(chb15/2)+1:length(chb15))];
    testdata = chb13;
    %test_data = chb13;
elseif x==3
    traindata = [chb01(:,1:length(chb01/2)),chb03(:,1:length(chb03/2)),chb13(:,1:length(chb13/2)),...
        chb15(:,1:length(chb15/2)),chb01(:,length(chb01/2)+1:length(chb01)),chb03(:,length(chb03/2)+1:length(chb03))...
        ,chb13(:,length(chb13/2)+1:length(chb13)),chb15(:,length(chb15/2)+1:length(chb15))];
     testdata = chb08;
elseif x==4
    traindata = [chb01(:,1:length(chb01/2)),chb08(:,1:length(chb08/2)),chb13(:,1:length(chb13/2)),...
        chb15(:,1:length(chb15/2)),chb01(:,length(chb01/2)+1:length(chb01)),chb08(:,length(chb08/2)+1:length(chb08))...
        ,chb13(:,length(chb13/2)+1:length(chb13)),chb15(:,length(chb15/2)+1:length(chb15))];
    testdata = chb03;
elseif x==5
    traindata = [chb03(:,1:length(chb03/2)),chb08(:,1:length(chb08/2)),chb13(:,1:length(chb13/2)),...
        chb15(:,1:length(chb15/2)),chb03(:,length(chb03/2)+1:length(chb03)),chb08(:,length(chb08/2)+1:length(chb08))...
        ,chb13(:,length(chb13/2)+1:length(chb13)),chb15(:,length(chb15/2)+1:length(chb15))];
    testdata = chb01;
end
%ventanas de 10s
muestras = 2500;  
Fs = 256;
c = 23;
i = 11
signal1 = testdata;
signal2 = traindata;
end
%a=0;
signal=signal1;
%Calcular caracteristicas para todas las banda
if op==1
    %for i=1:c
    [L2,~,c2]= Features_wavelet(signal,muestras,i,waveletFunction,2,ftures);
    [L3,~,c3] =  Features_wavelet(signal,muestras,i,waveletFunction,3,ftures);
    [L4,~,c4] = Features_wavelet(signal,muestras,i,waveletFunction,4,ftures);
    [L5,~,c5] = Features_wavelet(signal,muestras,i,waveletFunction,5,ftures);
    [L6,~,c6] = Features_wavelet(signal,muestras,i,waveletFunction,6,ftures);
    [L7,~,c7] = Features_wavelet(signal,muestras,i,waveletFunction,7,ftures);
    [A7,~,cA7] = Features_wavelet(signal,muestras,i,waveletFunction,8,ftures);
%     L2Features(:,i+a:(i+a)+2) = Gamma_Features; coeffG(:,i) = c2;
%     L3Features(:,i+a:(i+a)+2) = Beta_Features;  coeffB(:,i) = c3;
%     L4Features(:,i+a:(i+a)+2) = Alpha_Features; coeffA(:,i) = c4;
%     L5Features(:,i+a:(i+a)+2) = Theta_Features; coeffT(:,i) = c5;
%     L6Features(:,i+a:(i+a)+2) = Delta_Features; coeffD(:,i) = c6;
%     L7Features(:,i+a:(i+a)+2) = Delta_Features; coeffD(:,i) = c7;
%     A7Features(:,i+a:(i+a)+2) = Delta_Features; coeffD(:,i) = cA7;
     test_data = [L2,L3,L4,L5,L6,L7,A7];
    %a=a+2;
    %end
elseif op==0
   if banda==1 %gamma
        [M_features1,~,~] = Features_wavelet(signal,muestras,canal,waveletFunction,2,ftures);
        [M_features2,~,~] = Features_wavelet(signal,muestras,canal,waveletFunction,3,ftures);
         test_data = [M_features1,M_features2];              
    elseif banda==2 %Beta
        [M_features1,~,~] = Features_wavelet(signal,muestras,canal,waveletFunction,3,ftures);
        [M_features2,~,~] = Features_wavelet(signal,muestras,canal,waveletFunction,4,ftures);
         test_data = [M_features1,M_features2];      
    elseif banda==3 % Alpha       
        [M_features1,~,~] = Features_wavelet(signal,muestras,canal,waveletFunction,4,ftures);
        [M_features2,~,~] = Features_wavelet(signal,muestras,canal,waveletFunction,5,ftures);
         test_data = [M_features1,M_features2];  
    elseif banda==4 %Theta
        [M_features1,~,~] = Features_wavelet(signal,muestras,canal,waveletFunction,5,ftures);
        [M_features2,~,~] = Features_wavelet(signal,muestras,canal,waveletFunction,6,ftures);
         test_data = [M_features1,M_features2];  
    elseif banda==5 %Delta
        [M_features1,~,~] = Features_wavelet(signal,muestras,canal,waveletFunction,6,ftures);
        [M_features2,~,~] = Features_wavelet(signal,muestras,canal,waveletFunction,7,ftures);
         test_data = [M_features1,M_features2];  
    elseif banda==6
        [test_data,~,~] = Features_wavelet(signal,muestras,canal,waveletFunction,8,ftures);
   end
end
if prueba==2
signal=signal2;
if op==1
    %for i=1:c
    [L2,~,c2]= Features_wavelet(signal,muestras,i,waveletFunction,2,ftures);
    [L3,~,c3] =  Features_wavelet(signal,muestras,i,waveletFunction,3,ftures);
    [L4,~,c4] = Features_wavelet(signal,muestras,i,waveletFunction,4,ftures);
    [L5,~,c5] = Features_wavelet(signal,muestras,i,waveletFunction,5,ftures);
    [L6,~,c6] = Features_wavelet(signal,muestras,i,waveletFunction,6,ftures);
    [L7,~,c7] = Features_wavelet(signal,muestras,i,waveletFunction,7,ftures);
    [A7,~,cA7] = Features_wavelet(signal,muestras,i,waveletFunction,8,ftures);
%     L2Features(:,i+a:(i+a)+2) = Gamma_Features; coeffG(:,i) = c2;
%     L3Features(:,i+a:(i+a)+2) = Beta_Features;  coeffB(:,i) = c3;
%     L4Features(:,i+a:(i+a)+2) = Alpha_Features; coeffA(:,i) = c4;
%     L5Features(:,i+a:(i+a)+2) = Theta_Features; coeffT(:,i) = c5;
%     L6Features(:,i+a:(i+a)+2) = Delta_Features; coeffD(:,i) = c6;
%     L7Features(:,i+a:(i+a)+2) = Delta_Features; coeffD(:,i) = c7;
%     A7Features(:,i+a:(i+a)+2) = Delta_Features; coeffD(:,i) = cA7;
     train_data = [L2,L3,L4,L5,L6,L7,A7];
    %a=a+2;
    %end
elseif op==0
    if banda==1 %gamma
        [M_features1,~,~] = Features_wavelet(signal,muestras,canal,waveletFunction,2,ftures);
        [M_features2,~,~] = Features_wavelet(signal,muestras,canal,waveletFunction,3,ftures);
         train_data = [M_features1,M_features2];              
    elseif banda==2 %Beta
        [M_features1,~,~] = Features_wavelet(signal,muestras,canal,waveletFunction,3,ftures);
        [M_features2,~,~] = Features_wavelet(signal,muestras,canal,waveletFunction,4,ftures);
         train_data = [M_features1,M_features2];      
    elseif banda==3 % Alpha       
        [M_features1,~,~] = Features_wavelet(signal,muestras,canal,waveletFunction,4,ftures);
        [M_features2,~,~] = Features_wavelet(signal,muestras,canal,waveletFunction,5,ftures);
         train_data = [M_features1,M_features2];  
    elseif banda==4 %Theta
        [M_features1,~,~] = Features_wavelet(signal,muestras,canal,waveletFunction,5,ftures);
        [M_features2,~,~] = Features_wavelet(signal,muestras,canal,waveletFunction,6,ftures);
         train_data = [M_features1,M_features2];  
    elseif banda==5 %Delta
        [M_features1,~,~] = Features_wavelet(signal,muestras,canal,waveletFunction,6,ftures);
        [M_features2,~,~] = Features_wavelet(signal,muestras,canal,waveletFunction,7,ftures);
          train_data = [M_features1,M_features2];  
    elseif banda==6
        [train_data,~,~] = Features_wavelet(signal,muestras,canal,waveletFunction,8,ftures);
    
    end

end
end
%graficar
% figure(2);
% %canal 1
% subplot(7,1,1)
% plot(cA7)
% title('Coeficientes para Aproximación')
% subplot(7,1,2)
% plot(c7)
% title('Nivel7 Delta')
% subplot(7,1,3)
% plot(c6)
% title('Nivel6 Theta/Delta')
% subplot(7,1,4)
% plot(c5)
% title('Nivel5 Alpha/Theta')
% subplot(7,1,5)
% plot(c4)
% title('Nivel4 Beta/Alpha')
% subplot(7,1,6)
% plot(c3)
% title('Nivel3 Gamma/Beta')
% plot(c2)
% title('Nivel2 Gamma')
% %%PSD Calculation the Details Vectors
% D2 = wrcoef('d',C,L,waveletFunction,2); %NOISY
% D3 = wrcoef('d',C,L,waveletFunction,3); %NOISY
% D4 = wrcoef('d',C,L,waveletFunction,4); %GAMMA
% D5 = wrcoef('d',C,L,waveletFunction,5); %BETA
% D6 = wrcoef('d',C,L,waveletFunction,6); %ALPHA
% D7 = wrcoef('d',C,L,waveletFunction,7); %THETA
% A7 = wrcoef('a',C,L,waveletFunction,7); %DELTA
% figure(3);
% title('Reconstrucción de Coeficientes')
% %canal 1
% %subplot(7,1,1)
% %plot(A7(:,1))
% subplot(7,1,2)
% plot(D7)
% title('Nivel7 Delta')
% subplot(7,1,3)
% plot(D6)
% title('Nivel6 Theta/Delta')
% subplot(7,1,4)
% plot(D5)
% title('Nivel5 Alpha/Theta')
% subplot(7,1,5)
% plot(D4)
% title('Nivel4 Beta/Alpha')
% subplot(7,1,6)
% plot(D3)
% title('Nivel3 Gamma/Beta')
% plot(D2)
% title('Nivel2 Gamma')
