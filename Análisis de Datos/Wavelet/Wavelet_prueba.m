%Cargar señal de physionet
load ('C:\Users\USUARIO\OneDrive Personal\OneDrive\Megaproyecto\Machine learning\Clustering\Physionet.mat');
channeltest = recorddata(20,:)';
%Preprocesamiento: FILTROS
% Fs = 256;
% fruido = designfilt('bandstopiir','FilterOrder',2, ...
%                 'HalfPowerFrequency1',0.5,'HalfPowerFrequency2',70, ...
%                 'DesignMethod','butter','SampleRate',Fs);
% lowpass = designfilt('lowpassiir','FilterOrder',8, ...
%          'PassbandFrequency',49,'PassbandRipple',0.2, ...
%          'SampleRate',Fs);
%      
% channeltest = filtfilt(fruido,channeltest);
% channeltest = filtfilt(lowpass,channeltest);
% 
% %Normalizar señal
% channeltest = channeltest/max(channeltest);

%Aplicar DWT
[cA,cD] = dwt(channeltest,'db2');
%graficar señal aproximada por la DWT
rec = idwt(cA,zeros(size(cA)),'db2');   %Señal reconstruida por DWT
figure;
grid on;
plot(channeltest)
hold on
grid on
plot(rec)
legend('Señal Original','Señal Reconstruida')


%Descomposición de señal en wavelets
waveletFunction = 'db2'; %Daubechies wavelet   
[C,L] = wavedec(channeltest,5,waveletFunction);
approx = appcoef(C,L,waveletFunction);
cD1 = detcoef(C,L,1);                   %Gamma
cD2 = detcoef(C,L,2);                   %Beta
cD3 = detcoef(C,L,3);                   %Alpha
cD4 = detcoef(C,L,4);                   %Delta
cD5 = detcoef(C,L,5);                   %Theta

%graficar
figure;
subplot(6,1,1)
plot(approx)
title('Approximation Coefficients')
subplot(6,1,2)
plot(cD5)
title('Level 5 Theta')
subplot(6,1,3)
plot(cD4)
title('Level 4 Delta')
subplot(6,1,4)
plot(cD3)
title('Level 3 Alpha')
subplot(6,1,5)
plot(cD2)
title('Level 2 Beta')
subplot(6,1,6)
plot(cD1)
title('Level 1 Gamma')
