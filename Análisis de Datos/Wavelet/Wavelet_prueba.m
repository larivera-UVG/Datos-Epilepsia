%Cargar workspace
load 'resumen_paciente2.mat';

channeltest(:,1) = data_test(c(1),:)';
channeltest(:,2) = data_test(c(2),:)';

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
[cA1,cD1] = dwt(channeltest(:,1),'db2');
[cA2,cD2] = dwt(channeltest(:,2),'db2');
%graficar señal aproximada por la DWT
rec(:,1) = idwt(cA1,zeros(size(cA1)),'db2');   %Señal reconstruida por DWT canal 1
rec(:,2) = idwt(cA2,zeros(size(cA2)),'db2');   %Señal reconstruida por DWT canal 22

figure(1);
grid on;
subplot(2,1,1)
plot(channeltest(:,1))
hold on
grid on
plot(rec(:,1))
legend('Señal Original','Señal Reconstruida canal 1')
subplot(2,1,2)
plot(channeltest(:,2))
hold on
grid on
plot(rec(:,2))
legend('Señal Original','Señal Reconstruida canal 22')


%Descomposición de señal en wavelets
waveletFunction = 'db2'; %Daubechies wavelet   
[C1,L1] = wavedec(channeltest(:,1),5,waveletFunction);
[C2,L2] = wavedec(channeltest(:,2),5,waveletFunction);
approx(:,1) = appcoef(C1,L1,waveletFunction);
approx(:,2) = appcoef(C2,L2,waveletFunction);
cD1 = detcoef(C1,L1,1);                   %Gamma
cD2 = detcoef(C1,L1,2);                   %Beta
cD3 = detcoef(C1,L1,3);                   %Alpha
cD4 = detcoef(C1,L1,4);                   %Delta
cD5 = detcoef(C1,L1,5);                   %Theta
cD6 = detcoef(C2,L2,1);                   %Gamma
cD7 = detcoef(C2,L2,2);                   %Beta
cD8 = detcoef(C2,L2,3);                   %Alpha
cD9 = detcoef(C2,L2,4);                   %Delta
cD10 = detcoef(C2,L2,5);                   %Theta
%graficar
figure(2);
%canal 1
subplot(6,2,1)
plot(approx(:,1))
title('Approximation Coefficients canal 1')
subplot(6,2,3)
plot(cD5)
title('Level 5 Theta')
subplot(6,2,5)
plot(cD4)
title('Level 4 Delta')
subplot(6,2,7)
plot(cD3)
title('Level 3 Alpha')
subplot(6,2,9)
plot(cD2)
title('Level 2 Beta')
subplot(6,2,11)
plot(cD1)
title('Level 1 Gamma')

%canal 22
subplot(6,2,2)
plot(approx(:,2))
title('Approximation Coefficients canal 22')
subplot(6,2,4)
plot(cD6)
title('Level 5 Theta')
subplot(6,2,6)
plot(cD7)
title('Level 4 Delta')
subplot(6,2,8)
plot(cD8)
title('Level 3 Alpha')
subplot(6,2,10)
plot(cD9)
title('Level 2 Beta')
subplot(6,2,12)
plot(cD10)
title('Level 1 Gamma')
