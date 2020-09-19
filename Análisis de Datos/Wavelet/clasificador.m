%load workspace
 load chb01_wavelet_features.mat
 load chb03_wavelet_features.mat
 load chb08_wavelet_features.mat
 load chb13_wavelet_features.mat
 load chb15_wavelet_features.mat

%load setD_E_features.mat;
%load setD_E_features.mat;

canales=1;

x = randi([1 5],1);
c = 1;
x=6
if x==1
    train_data = [chb01.DFeatures(:,c);chb03.DFeatures(:,c);chb08.DFeatures(:,c);chb13.DFeatures(:,c)];
    test_data = chb15.DFeatures(:,c);
elseif x==2
    train_data = [chb01.DFeatures(:,c);chb03.DFeatures(:,c);chb08.DFeatures(:,c);chb15.DFeatures(:,c)];
    test_data = chb13.DFeatures(:,c);
elseif x==3
    train_data = [chb01.DFeatures(:,c);chb03.DFeatures(:,c);chb13.DFeatures(:,c);chb15.DFeatures(:,c)];
    test_data = chb08.DFeatures(:,c);
elseif x==4
    train_data = [chb01.DFeatures(:,c);chb08.DFeatures(:,c);chb13.DFeatures(:,c);chb15.DFeatures(:,c)];
    test_data = chb03.DFeatures(:,c);
elseif x==5
    train_data = [chb03.DFeatures;chb08.DFeatures;chb13.DFeatures;chb15.DFeatures];
    test_data = chb01.DFeatures(:,c);
end

%features = M_Features;
%labels = [ones(round(size(M_Features,1)/2),1);zeros(round(size(M_Features,1)/2),1)];

% k=4; % Elegir numero de particiones 
% %Se utilizó K=4 k=5 k=10
% cvFolds = crossvalind('Kfold', labels, k);   
% cp = classperf(labels);                      %# init performance tracker
% for i = 1:k                                  %# for each fold
%     testIdx = (cvFolds == i);                %# get indices of test instances
%     trainIdx = ~testIdx; 
%     %Obtener conjuntos train y test
%     train_data = features(trainIdx,:);
%     train_label = labels(trainIdx,:);
%     test_data = features(testIdx,:);
%     test_label = labels(testIdx,:);
% end
%labels
train_data = M_Features_train;
test_data = M_Features_test;


train_label = [ones(round(size(M_Features_train,1)/2),1);zeros(round(size(M_Features_train,1)/2)-1,1)];
test_label = [ones(round(size(M_Features_test,1)/2)-1,1);zeros(round(size(M_Features_test,1)/2),1)];
%SVM con libreria
 %Entrenamiento de SVM mediante dos kernels
% train_data = M_Features_train;
 %test_data = M_Features_test;
 % Linear Kernel
 model_linear = svmtrain(train_label, train_data, '-t 0 -h 0');
 % RBF Kernel 
 %model_precomputed = svmtrain(train_label, [(1:size(train_data,1))', train_data*train_data'], '-t 4 -c 0.001  ');
 model_precomputed = svmtrain(train_label, train_data, '-t 2 -h 0'); 
 % Testing model
 [predict_label_L, accuracy_L, dec_values_L] = svmpredict(test_label, test_data, model_linear);
 [predict_label_P, accuracy_P, dec_values_P] = svmpredict(test_label, test_data, model_precomputed);

 accuracy_L % Accuracy con kernel lineal
 accuracy_P % Accuracy con  kernel RBF
 
 %graficar
  figure(1);
  cm1 = plotconfusion(test_label',predict_label_L',{'Matriz de confusion Kernel Lineal'},test_label',predict_label_P',{'Matriz de confusion Kernel RBF'});
  %set(gca,'xticklabel',{'Con crisis' 'Sin crisis' ''})
  %set(gca,'yticklabel',{'Con crisis' 'Sin crisis' ''})
  j=0;
%  for i=1:length(test_label)
%     Predicted_labels((j*muestras)+1:i*muestras,1) = predict_label_L(i)*ones(muestras,1);
%     j = j+1;  
%  end
%  
%  figure(2);
%  t = 1:1:length(Predicted_labels);
%  data = signal_test(1,1:length(Predicted_labels));
%  plot(t(Predicted_labels==0),data(Predicted_labels==0),'color','b' );
%  hold on; 
%  plot(t(Predicted_labels==1),data(Predicted_labels==1),'color','r' );
%  ylabel(['Predicted Data SVM '])
%  xlabel(['Muestras Canal ',num2str(canal_test)])