%Cargar workspace con features segun ventana o descomentar  linea para cargar csv deseado
%features = load('C:\Users\USUARIO\OneDrive Personal\OneDrive\Megaproyecto\Base de datos\EEG dataset Bonn University\Matriz_Features1.csv');
%Elegir que matriz se desea clasificar
% Opcion 1-6: caracteristicas pacientes normales ojos abiertos/ pacientes con crisis 
% Opcion 7-12: caracteristicas pacientes normales ojos cerrados/ pacientes con crisis 
% La matriz de confusion y resultados se despliegan en consola
% Elegir experimento 1 para ventana 150 muestras y experimento 2 para
% ventana 80 muestras
opcion =1;
experimento =1;
if experimento==1
    load Workspace_ventana_150muestras.mat
elseif experimento ==2;
    load Workspace_ventana_80muestras.mat
end
if opcion==1
    features = MatrizFeatures1;
elseif opcion==2
    features = MatrizFeatures2;
elseif opcion==3
    features = MatrizFeatures3;
elseif opcion==4
    features = MatrizFeatures4;
elseif opcion==5
    features = MatrizFeatures5;
elseif opcion==6
    features = MatrizFeatures6;
elseif opcion==7
    features = MatrizFeatures7;
elseif opcion==8
    features = MatrizFeatures8;
elseif opcion==9
    features = MatrizFeatures9;
elseif opcion==10
    features = MatrizFeatures10;
elseif opcion==11
    features = MatrizFeatures11;
elseif opcion==12
    features = MatrizFeatures12;
end    
    
% Pacientes con crisis /sin crisis 
labels = [zeros(length(features)/2,1); ones(length(features)/2,1)];

%SVM con libreria
k=3; % Elegir numero de particiones 
%Se utilizó K=3 para opciones 1-6 y K=7 para opciones 7-12 para obtener
% las matrices de confusion presentadas
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
 model_precomputed = svmtrain(train_label, [(1:length(train_data))', train_data*train_data'], '-t 2 -c 2  ');
 % Testing model
 [predict_label_P, accuracy_P, dec_values_P] = svmpredict(test_label, [(1:length(test_data))', test_data*train_data'], model_precomputed);

 accuracy_L % Accuracy con kernel lineal
 accuracy_P % Accuracy con  kernel RBF

 %cMatrix1 = confusionmat(test_label',predict_label_L') %Matriz de confusion con kernel lineal
 %cMatrix2 = confusionmat(test_label',predict_label_P') %Matriz de confusion con kernel RBF
 figure1= figure();
 cm1 = plotconfusion(test_label',predict_label_L',{'Matriz de confusion Kernel Lineal'},test_label',predict_label_P',{'Matriz de confusion Kernel RBF'});
 set(gca,'xticklabel',{'Con crisis' 'Sin crisis' ''})
 set(gca,'yticklabel',{'Con crisis' 'Sin crisis' ''})

 

 
