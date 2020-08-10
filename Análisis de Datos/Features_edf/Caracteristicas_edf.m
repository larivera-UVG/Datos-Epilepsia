%Encontrar matriz de caracteristicas y vector de etiquetas EEG .edf
% Fs = 256Hz muestras = 921601 duración = 60min
% 5 pacientes con grabaciones que presentan al menos 1 crisis epileptica
edf=4;
if edf==1
    nombre = 'chb01_15';
elseif edf==2
    nombre = 'chb02_16';
elseif edf==3
    nombre = 'chb03_04';
elseif edf==4
    nombre = 'chb04_28';
elseif edf==5
    nombre = 'chb05_22';
end

[header, recorddata] = edfread(['C:\Users\USUARIO\OneDrive Personal\OneDrive\Megaproyecto\Base de datos\edf_files\',nombre,'.edf']);
%Definir canales a analizar
c1= randi([1 23]);
c2= randi([1 23]);


%-----------------------------------------------------------------------
edf1 = recorddata(c1,:)';
edf2 = recorddata(c1,:)';
%Preprocesamiento: FILTROS
Fs = 256;
fred_electrica = designfilt('bandstopiir','FilterOrder',2, ...
                'HalfPowerFrequency1',59,'HalfPowerFrequency2',61, ...
                'DesignMethod','butter','SampleRate',Fs);
fruido = designfilt('bandstopiir','FilterOrder',2, ...
                'HalfPowerFrequency1',0.5,'HalfPowerFrequency2',70, ...
                'DesignMethod','butter','SampleRate',Fs);
lowpass = designfilt('lowpassiir','FilterOrder',8, ...
         'PassbandFrequency',49,'PassbandRipple',0.2, ...
         'SampleRate',Fs);
%Definir canal a analizar
channel1 = edf1; 
channel2 = edf2;
% Aplicar los filtros 
channel1 = filtfilt(fred_electrica,channel1);
channel1 = filtfilt(lowpass,channel1);
channel1 = filtfilt(fruido,channel1); 
channel2 = filtfilt(fred_electrica,channel2);
channel2 = filtfilt(lowpass,channel2);
channel2 = filtfilt(fruido,channel2); 

%Normalizar señales
channel1 = channel1/max(channel1);
channel2 = channel2/max(channel2);
%Realizar ventana
i=1;
j=0;
flag=0;
muestras =2000; %(cada 8s)
size_c1 = length(channel1);
channel_ventana = zeros(size_c1,2);
zc = zeros(round(size_c1/muestras)-1,2);
mav = zeros(round(size_c1/muestras)-1,2);
fmax = zeros(round(size_c1/muestras)-1,2);
%zero crossing index function
umbral = 0.01;
%zcindex = @(v) find(v(:).*circshift(v(:), [-1 0]) <= 0.0005); 
[zy(:,1), zi1] = ZC(channel1,umbral); %Calcular todos los ZC de la señal
[zy(:,2), zi2] = ZC(channel2,umbral); %Calcular todos los ZC de la señal
while(1)
     channel_ventana(i,1) = channel1(i,1); 
     channel_ventana(i,2) = channel2(i,1); 
        i = i+1;        
        if(mod(i,(muestras+1))==0)      %Calcular caracteristicas de cada ventana
            flag = flag+1;
            mav(flag,1) = mean(abs(channel_ventana(:,1)));
            mav(flag,2) = mean(abs(channel_ventana(:,2)));
            picos1 = findpeaks(channel_ventana(:,1)');
            picos2 = findpeaks(channel_ventana(:,2)');
            if(j>0) %contar ZC por cada ventana
                zc(flag,1) = sum(zi1(j*muestras:i) == 1);
                zc(flag,2) = sum(zi2(j*muestras:i) == 1);
            else
                zc(flag,1) = sum(zi1(1:(i-1)) == 1);
                zc(flag,2) = sum(zi2(1:(i-1)) == 1);
            end
            j= j+1;   
            fmax(flag,1)=max(picos1);
            fmax(flag,2)=max(picos2);
        end
        if (i>size_c1)
            i=1; 
            j=0;
            break;
        end  
end
%Concatenar vector de características
features = [mav(:,1),zc(:,1);mav(:,2),zc(:,2)];
%Guardar vector de caracteristicas
csvwrite(['Features_',nombre,'_canales_',num2str(c1),'_',num2str(c2),'.csv'],features);

%Graficar
figure(1);
hold off;
scatter(features(:,1), features(:,2), 20,'filled');
title('Características');
ylabel('ZC')
xlabel('MAV')
%figure(2);
%hold off;
%[E, centros] = k_means(features,2,1);
figure(3);
[D, P]=VAT(features);
figure(4);
hold off
t = 0:length(channel1)-1;
subplot(1,2,1);
plot(t, channel1, '-r');
ylabel(['Canal ',num2str(c1)])
xlabel('Muestras')
subplot(1,2,2);
plot(t, channel2,'b');
ylabel(['Canal ',num2str(c2)])
xlabel('Muestras')


% 
% %SVM con libreria
% % Split Data 60% training  40% testing
%  train_data = features(1:877,:);
%  train_label = labels(1:877,:);
%  test_data = features(878:1462,:);
%  test_label = labels(878:1462,:);
% 
%  % RBF Kernel
%  model_rbf = svmtrain(train_label, train_data, '-t 2');
%  % Testing model
%  [predict_label_L, accuracy_L, dec_values_L] = svmpredict(test_label, test_data, model_rbf);
% 
%  % Precomputed Kernel
%  model_precomputed = svmtrain(train_label, [(1:877)', train_data*train_data'], '-t 4');
%  % Testing model
%  [predict_label_P, accuracy_P, dec_values_P] = svmpredict(test_label, [(1:585)', test_data*train_data'], model_precomputed);
% 
%  accuracy_L % Display the accuracy using linear kernel
%  accuracy_P % Display the accuracy using precomputed kernel
% 
%  [cMatrix,cOrder] = confusionmat(test_label,predict_label_L) %Display confusion matriz
%  plotconfusion(test_label,predict_label_L) 
%  %plot(channel1,'color','r')
%  %hold on
%  %plot(channel2,'color','blue')