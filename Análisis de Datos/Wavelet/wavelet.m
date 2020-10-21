%Encontrar vectores de características por descomposición de bandas en cada
%canal
function [M_Features_train,M_Features_test] = wavelet(train_data,test_data,i)

%cargar datos etiquetados de 5 pacientes de Physionet
 %load 'C:\Users\USUARIO\Downloads\Physionet EEG scalp database\Physionet_data_etiquetada.mat'
% x = 1;
% if x==1
%     train_data = [chb01(1:length(chb01/2)),chb08(1:length(chb01/2)),chb03(1:length(chb03/2)),chb01(length(chb01/2)+1:length(chb01)),chb08(length(chb08/2)+1:length(chb08)),chb03(length(chb03/2)+1:length(chb03))];
%     test_data = chb08;
% elseif x==2
%     train_data = [chb01,chb03,chb08,chb15];
%     test_data = chb13;
%     %test_data = chb13;
% elseif x==3
%     train_data = [chb01,chb03,chb13,chb15];
%     test_data = chb08;
% elseif x==4
%     train_data = [chb01,chb08,chb13,chb15];
%     test_data = chb03;
% else
%     train_data = [chb03,chb08,chb13,chb15];
%     test_data = chb01;
% end

%ventanas de 10s
muestras = 2500;  
Fs = 256;
ctot = 1;
%x = randi([1 ctot],1);
ftures = [1,1,1,1,1,1]; %[power,max,min,media,curtosis]=[1,1,1,1,1]
op=1;       %op=1 se calcula matriz features para todas las bandas/ op=0 para una epecifica


%banda = 1 NOISY
%banda = 2 NOISY
%banda = 3 GAMMA  32 - 64Hz
%banda = 4 BETA   16 - 32Hz
%banda = 5 ALPHA  8  - 16 Hz
%banda = 6 THETA  4  -  8Hz
%banda = 7 DELTA  0.5-  4Hz
%banda = 3; %(de 2 a 7) 8 para aproximacion
%load ('C:\Users\USUARIO\OneDrive Personal\OneDrive\Megaproyecto\Base de datos\SVM\Bonn_datasets.mat');
%signal = [setAdata;setEdata];
%signal = [setDdata;setEdata];
signal = test_data;
%signal = test_data;
waveletFunction = 'coif3'; %Daubechies 4 order wavelet  
a=0;
%i=4;
%Calcular caracteristicas por banda
if op==1
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
     M_Features_test = [L2,L3,L4,L5,L6,L7,A7];
    %a=a+2;
elseif op==0
   [ M_Features,ritmo] = Features_wavelet(signal,muestras,waveletFunction,banda);
end
signal = train_data;
if op==1
    for i=1:ctot
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
     M_Features_train = [L2,L3,L4,L5,L6,L7,A7];
    %a=a+2;
    end
end
end
