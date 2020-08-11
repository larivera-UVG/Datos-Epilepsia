%CARGAR DATOS GENERADOS EN CARACTERISTICAS_EDF
load FEATURES_PRUEBAS_EDF.mat
%Elegir características a clasificar
opcion = 1;
if opcion==1
    features = Features_chb01_15_canales_21_3;
elseif opcion==2
    features = Features_chb01_15_canales_22_15;
elseif opcion==3
    features = Features_chb02_16_canales_3_7;
elseif opcion==4
    features = Features_chb02_16_canales_13_23;
elseif opcion==5
    features = Features_chb03_04_canales_1_7;
elseif opcion==6
    features = Features_chb03_04_canales_23_4;
elseif opcion==7
    features = Features_chb05_22_canales_22_19;
elseif opcion==8
    features = Features_chb05_22_canales_23_16;
elseif opcion==9
    features = Features_chb11_82_canales_4_17;
elseif opcion==10
    features = Features_chb11_82_canales_22_16;
end    

%Clustering K-means
[E, centros] = k_means(features,2,1);
% Pacientes con crisis /sin crisis 
labels = [ones(sum(E==1),1); 2*ones(sum(E==2),1)];

%SVM con libreria
k=3; % Elegir numero de particiones 
cvFolds = crossvalind('Kfold', labels, k);   
cp = classperf(labels);                      %# init performance tracker
for i = 1:k                                  %# for each fold
    testIdx = (cvFolds == i);                %# get indices of test instances
    trainIdx = ~testIdx; 
    %Obtener conjuntos train y test
    train_data = features(trainIdx,:);
    train_label = labels(trainIdx,:);
    test_data = features(testIdx,:);
    test_label = labels(testIdx,:);
end

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


 figure1= figure();
 cm1 = plotconfusion(test_label',predict_label_L',{'Matriz de confusion Kernel Lineal'},test_label',predict_label_P',{'Matriz de confusion Kernel RBF'});
 set(gca,'xticklabel',{'Con crisis' 'Sin crisis' ''})
 set(gca,'yticklabel',{'Con crisis' 'Sin crisis' ''})
