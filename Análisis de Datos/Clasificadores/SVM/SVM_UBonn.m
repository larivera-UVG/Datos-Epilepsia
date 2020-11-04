%Cargar workspace con features segun ventana o descomentar  linea para cargar csv deseado
%features = load('C:\Users\USUARIO\OneDrive Personal\OneDrive\Megaproyecto\Base de datos\EEG dataset Bonn University\Matriz_Features1.csv');
%Elegir que matriz se desea clasificar
% Opcion 1: caracteristicas pacientes normales/con crisis (SetA/SetE)
% Opcion 2: caracteristicas pacientes epilépticos sin crisis/con crisis (SetD/SetE)
% La matriz de confusion y resultados se despliegan en consola

opcion =1;
load Features_ventana_4096muestras.mat
if opcion==1
    features = featuressetAE;
elseif opcion==2
    features = featuressetDE;
end
    
% Pacientes con crisis /sin crisis 
labels = [zeros(length(features)/2,1); ones(length(features)/2,1)];

%SVM con libreria
k=4; % Elegir numero de particiones 
%Se utilizó K=4 k=5 k=10
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
 kernel = 'linear';
 model_linear =fitcsvm(train_data, train_label,'KernelFunction',kernel,'Standardize',true,...
      'BoxConstraint',1,'ClassNames',[0,1]);
 % Testing model
  [predict_label_L,scores1] =  predict(model_linear, test_data);
 matc1 = confusionmat(test_label,predict_label_L);
 s1 = sum(matc1);
 accuracy_L = 100*(matc1(1,1)+matc1(2,2))/(s1(1)+s1(2));
 kernel = 'rbf';
 cl = fitcsvm(train_data, train_label,'KernelFunction',kernel,'Standardize',true,...
      'BoxConstraint',1,'ClassNames',[0,1]);
 [predict_label_R,scores] =  predict(cl, test_data);
 matc = confusionmat(test_label,predict_label_R);
 s = sum(matc);
 accuracy_R = 100*(matc(1,1)+matc(2,2))/(s(1)+s(2));
 accuracy_L % Accuracy con kernel lineal
 accuracy_R % Accuracy con  kernel RBF

 figure1= figure();
 cm1 = plotconfusion(test_label',predict_label_L',{'Matriz de confusion Kernel Lineal'},test_label',predict_label_R',{'Matriz de confusion Kernel RBF'});
 
 %Red neuronal 
 %load  UBonn_variablesparapruebasfinales.mat
%  trainFcn = 'trainscg';  % Scaled conjugate gradient backpropagation.
%  hiddenLayerSize = 10;
%  
% %train_data = train_data_DE_k4;
% %train_label = train_label_DE_k4;
% %test_data = test_data_DE_k4;
% %test_label = test_label_DE_k4;
% %se concatenan los vectores de feature(test y train)
% %y los vectores de etiqueta(train y test)
% features = [train_data;test_data];
% labels = [train_label;test_label];
% 
% %Creacion de red neuronal
% net = patternnet(hiddenLayerSize, trainFcn);
% 
% % Entrenar la red 
% [net,tr] = train(net,features',labels');
% % Setup Division of Data for Training, Validation, Testing
% net.divideParam.trainRatio = 70/100;
% net.divideParam.valRatio = 15/100;
% net.divideParam.testRatio = 15/100;
% 
% % Testear la red
% y = net(features'); 
% 
%  e = gsubtract(labels',y);
%  performance = perform(net,labels',y);
%  tind = vec2ind(labels');  
%  yind = vec2ind(y);                      
% percentErrors = sum(tind ~= yind)/numel(tind);
% 
