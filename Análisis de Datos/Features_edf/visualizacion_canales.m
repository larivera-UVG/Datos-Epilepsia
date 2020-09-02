
%-------------------------------------------------------------------
%Descripción de variables.mat:
%-------------------------------------------------------------------
% c = canales que presentaron el mejor resultado del paciente 2
% canales = numero de canales que se analizan
% data_train = grabación utilizada para entrenar el SVM
% data_test = grabación utilizada para testear el SVM
% Fs = frecuencia de muestreo de las grabaciones
% headertest-headertrain = informacion de las dos grabaciones del paciente2
% testname/trainname = nombre de las grabaciones utilizadas
% Kmeans_labels = labels generadas por k_means (2 grupos)
% model_linear = modelo de SVM con rendimiento del 98.0456% Kernel lineal
% muestras = numero de muestras por ventana que se utilizo 
% Predicted_labels = vector para visualizar las clases con y sin crisis
% Real_labels = clases segun anotaciones de la base de datos (data_test)
% test_data/train_data = matriz de features : MAV y ZC
% test_label/train_label = clases obtenidas mediante K-means 
% *1 grabación completa se utilizó train y otra grabación para test 
%----------------------------------------------------------------------

%cargar workspace
%load 'resumen_paciente2.mat';

% Si se desea testear SVM
% [predict_label_L, accuracy_L, dec_values_L] = svmpredict(test_label, test_data, model_linear);
% % matriz de confusion
% figure(1);
% cm = plotconfusion(test_label',predict_label_L',{'Matriz de confusion Kernel Lineal'});
% set(gca,'xticklabel',{'Clase 1' 'Clase 2' ''})
% set(gca,'yticklabel',{'Clase 1' 'Clase 2' ''})

%Visualizar 23 canales
data = data_test;
t= 1:1:length(Real_labels);
figure(2);
for i=1:8
    subplot(4,2,i)
    plot(t(Real_labels==0),data(i,Real_labels==0),'color','b' );
    hold on;
    plot(t(Real_labels==1),data(i,Real_labels==1),'color','r' );
    ylabel(['Clasificación Real Paciente ',num2str(paciente)])
    xlabel(['Muestras canal ',num2str(i)])
end
figure(3);
for i=9:8+8
    subplot(4,2,i-8)
    plot(t(Real_labels==0),data(i,Real_labels==0),'color','b' );
    hold on;
    plot(t(Real_labels==1),data(i,Real_labels==1),'color','r' );
    ylabel(['Clasificación Real Paciente ',num2str(paciente)])
    xlabel(['Muestras canal ',num2str(i)])
end
figure(4);
for i=17:23
    subplot(4,2,i-16)
    plot(t(Real_labels==0),data(i,Real_labels==0),'color','b' );
    hold on;
    plot(t(Real_labels==1),data(i,Real_labels==1),'color','r' );
    ylabel(['Clasificación Real Paciente ',num2str(paciente)])
    xlabel(['Muestras canal ',num2str(i)])
end
