%Elegir tipo de clasificación
%Opcion =2 para dos canales
%Opcion = 4 para cuatro canales
opcion=4;

%Elegir características a clasificar (entrenamiento y testeo)
% Paciente 1: chb01      2 grabaciones: 15 - 16
% Paciente 2: chb02      2 grabaciones: 16 - 19
% Paciente 3: chb03      2 grabaciones: 03 - 04
% Paciente 5: chb05      2 grabaciones: 13 - 22
% Paciente 11: chb11     2 grabaciones: 82 - 92
paciente = 5;


%----------------------------Cargar datos----------------------------------
if opcion==2
    load Features_2canales.mat
    load Data_2canales.mat
elseif opcion==4
    load Features_4canales.mat
    load Data_4canales.mat
end
if paciente==1 && opcion==4
    test_data = Featureschb01_15_46206; %matriz features para entrenar
    train_data = Featureschb01_16_153713;%matriz features para testear
    data = chb01_16_153713Data;              %Data de dos los canales de testeo
elseif paciente==2 && opcion==4
    test_data = Featureschb02_16_2323423; %matriz features para entrenar
    train_data = Featureschb02_19_2312194;%matriz features para testear
    data = chb02_19_2312194Data;              %Data de dos los canales de testeo
elseif paciente==3 && opcion==4
    test_data = Featureschb03_03_10221923; %matriz features para entrenar
    train_data = Featureschb03_04_1612022;%matriz features para testear
    data = chb03_04_1612022Data;              %Data de dos los canales de testeo
elseif paciente==4 && opcion==4
    test_data = Featureschb05_13_16181810; %matriz features para entrenar
    train_data = Featureschb05_22_164171;%matriz features para testear
    data = chb05_22_164171Data;              %Data de dos los canales de testeo
elseif paciente==5 && opcion==4
    test_data = Featureschb11_82_72319; %matriz features para entrenar
    train_data = Featureschb11_92_168221;%matriz features para testear
    data = chb11_92_168221Data;              %Data de dos los canales de testeo
end 
if paciente==1 && opcion==2
    test_data = Featureschb01_15_512; %matriz features para entrenar
    train_data = Featureschb01_16_1115;%matriz features para testear
    data = chb01_16_1115Data;              %Data de dos los canales de testeo
elseif paciente==2 && opcion==2
    test_data = Featureschb02_16_1718; %matriz features para entrenar
    train_data = Featureschb02_19_716;%matriz features para testear
    data = chb02_19_716Data;              %Data de dos los canales de testeo
elseif paciente==3 && opcion==2
    test_data = Featureschb03_03_164; %matriz features para entrenar
    train_data = Featureschb03_04_312;%matriz features para testear
    data = chb03_04_312Data;              %Data de dos los canales de testeo
elseif paciente==4 && opcion==2
    test_data = Featureschb05_13_238; %matriz features para entrenar
    train_data = Featureschb05_22_146;%matriz features para testear
    data = chb05_22_146Data;              %Data de dos los canales de testeo
elseif paciente==5 && opcion==2
    test_data = Featureschb11_82_186; %matriz features para entrenar
    train_data = Featureschb11_92_1217;%matriz features para testear
    data = chb11_92_1217Data;              %Data de dos los canales de testeo
end 

%Llamar función clasificar, especificar matriz de entrenamiento y testeo
%Kmeans_labels devuelve el vector dado por kmeans de los datos a testear

[train_label,test_label] = Clasificar(train_data,test_data)

%SVM con libreria

 %Entrenamiento de SVM mediante dos kernels
 % Linear Kernel
 model_linear = svmtrain(train_label, train_data, '-t 0 ');
 % Testing model
 [predict_label_L, accuracy_L, dec_values_L] = svmpredict(test_label, test_data, model_linear);
 % RBF Kernel 
 model_precomputed = svmtrain(train_label, [(1:length(train_data))', train_data*train_data'], '-t 4 -c 2  ');
 % Testing model
 [predict_label_P, accuracy_P, dec_values_P] = svmpredict(test_label, [(1:length(test_data))', test_data*train_data'], model_precomputed);

 accuracy_L % Accuracy con kernel lineal
 accuracy_P % Accuracy con  kernel RBF


 figure(2);
 cm1 = plotconfusion(test_label',predict_label_L',{'Matriz de confusion Kernel Lineal'},test_label',predict_label_P',{'Matriz de confusion Kernel RBF'});
 set(gca,'xticklabel',{'Clase 1' 'Clase 2' ''})
 set(gca,'yticklabel',{'Clase 1' 'Clase 2' ''})
%  
figure(3);
muestras =2000;
j=0;
Predicted_labels = ones(length(test_data),1);
for i=1:length(test_label)
    Predicted_labels((j*muestras)+1:i*muestras,1) = predict_label_L(i)*ones(muestras,1);
    Kmeans_labels((j*muestras)+1:i*muestras,1) = test_label(i)*ones(muestras,1);
    j = j+1;
    
end
subplot(2,2,1);
plot(data(Predicted_labels==0,1),'color','b' );
hold on;
plot(data(Predicted_labels==1,1),'color','r' );
ylabel('Predicted Data SVM')
xlabel('Muestras')
subplot(2,2,2);
plot(data(Kmeans_labels==0,1),'color','b' );
hold on;
plot(data(Kmeans_labels==1,1),'color','r' );
ylabel('Predicted Data K-means')
xlabel('Muestras')
subplot(2,2,3);
plot(data(Predicted_labels==0,2),'color','b' );
hold on;
plot(data(Predicted_labels==1,2),'color','r' );
ylabel('Predicted Data SVM')
xlabel('Muestras')
subplot(2,2,4);
plot(data(Kmeans_labels==0,2),'color','b' );
hold on;
plot(data(Kmeans_labels==1,2),'color','r' );
ylabel('Predicted Data K-means')
xlabel('Muestras')
