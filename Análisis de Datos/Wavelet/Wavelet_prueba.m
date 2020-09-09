
ruta = 'C:\Users\USUARIO\OneDrive Personal\OneDrive\Megaproyecto\Base de datos\edf_files\';
nombre = 'chb01_15';
[header, edf] = edfread([ruta,nombre,'.edf']);
canales = 4;
%Analizar de muestra 200000-300000 (presencia de crisis)
edf = edf(:,200000:300000);

Fs = header.frequency(1);
inicio_crisis = 59840;
fin_crisis = 72896;
ctot = header.ns;
comb = combnk(1:ctot,canales); %para eeg de 23 canales
x = randi([1 length(comb)],1);

% eeg = zeros(length(edf),canales);
% for i=1:canales
%         eeg(:,i)= edf(c(i),:)';
% end

%ventanas de 9s
muestras = 2300;    
k=1;        %recorrer canales
i=1;        %recorrer muestras
j=0;
flag=0;
size_c = length(edf);
channel_ventana = zeros(size_c,canales);

%Aplicar DWT en cada ventana 
[cA1,cD1] = dwt(edf(:,1),'db2');

%graficar señal aproximada por la DWT 1D
%rec(:,1) = idwt(cA1,zeros(size(cA1)),'db2');   %Señal reconstruida por DWT canal 1

% figure(1);
% grid on;
% subplot(2,1,1)
% plot(channeltest(:,1))
% hold on
% grid on
% plot(rec(:,1))
% legend('Señal Original','Señal Reconstruida canal 1')
% subplot(2,1,2)
% plot(channeltest(:,2))
% hold on
% grid on
% plot(rec(:,2))
% legend('Señal Original','Señal Reconstruida canal 22')


%Descomposición de señal en wavelets
waveletFunction = 'db4'; %Daubechies 4 order wavelet  
[C,L] = wavedec(edf(:,1),5,waveletFunction);
 %%Coeficientes
cD1 = detcoef(C,L,1);                   %NOISY
cD2 = detcoef(C,L,2);                   %GAMMA  32 - 64Hz
cD3 = detcoef(C,L,3);                   %BETA   16 - 32Hz
cD4 = detcoef(C,L,4);                   %ALPHA  8  - 16 Hz
cD5 = detcoef(C,L,5);                   %THETA  4  -  8Hz
cA5 = appcoef(C,L,waveletFunction,5);   %DELTA  0.5-  4Hz

%%PSD Calculation the Details Vectors
D1 = wrcoef('d',C,L,waveletFunction,1); %NOISY
D2 = wrcoef('d',C,L,waveletFunction,2); %GAMMA
D3 = wrcoef('d',C,L,waveletFunction,3); %BETA
D4 = wrcoef('d',C,L,waveletFunction,4); %ALPHA
D5 = wrcoef('d',C,L,waveletFunction,5); %THETA
A5 = wrcoef('a',C,L,waveletFunction,5); %DELTA

POWER_BETA = (sum(D3.^2))/length(D3);
%graficar
figure(2);
%canal 1
subplot(6,1,1)
plot(cA5(:,1))
title('Approximation Coefficients canal 1')
subplot(6,1,3)
plot(cD5)
title('Level 5 Theta')
subplot(6,1,5)
plot(cD4)
title('Level 4 Delta')
subplot(6,1,7)
plot(cD3)
title('Level 3 Alpha')
subplot(6,1,9)
plot(cD2)
title('Level 2 Beta')
subplot(6,1,11)
plot(cD1)
title('Level 1 Gamma')
