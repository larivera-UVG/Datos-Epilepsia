%cargar datos etiquetados de 5 pacientes de Physionet
load 'C:\Users\USUARIO\Downloads\Physionet EEG scalp database\Physionet_data_etiquetada.mat'

Fs = 256;
muestras=2500;  %cada 10s
canales = 2;
op=1;
comb = combnk(1:23,canales); %para eeg de 23 canales
i=1;
%Dejar un paciente afuera de train, para realizar testeo
x =randi([1 5]);
if x==1
    datostrain = [chb01(:,1:length(chb01/2)),chb03(:,1:length(chb03/2)),chb08(:,1:length(chb08/2)),...
        chb13(:,1:length(chb13/2)),chb01(:,length(chb01/2)+1:length(chb01)),chb03(:,length(chb03/2)+1:length(chb03))...
        ,chb13(:,length(chb13/2)+1:length(chb13))];
    datostest = chb15;
elseif x==2
    datostrain = [chb01(:,1:length(chb01/2)),chb03(:,1:length(chb03/2)),chb08(:,1:length(chb08/2)),...
        chb15(:,1:length(chb15/2)),chb01(:,length(chb01/2)+1:length(chb01)),chb03(:,length(chb03/2)+1:length(chb03))...
        ,chb08(:,length(chb08/2)+1:length(chb08)),chb15(:,length(chb15/2)+1:length(chb15))];
    datostest = chb13;

elseif x==3
    datostrain = [chb01(:,1:length(chb01/2)),chb03(:,1:length(chb03/2)),chb13(:,1:length(chb13/2)),...
        chb15(:,1:length(chb15/2)),chb01(:,length(chb01/2)+1:length(chb01)),chb03(:,length(chb03/2)+1:length(chb03))...
        ,chb13(:,length(chb13/2)+1:length(chb13)),chb15(:,length(chb15/2)+1:length(chb15))];
    datostest = chb08;
elseif x==4
    datostrain = [chb01(:,1:length(chb01/2)),chb08(:,1:length(chb08/2)),chb13(:,1:length(chb13/2)),...
        chb15(:,1:length(chb15/2)),chb01(:,length(chb01/2)+1:length(chb01)),chb08(:,length(chb08/2)+1:length(chb08))...
        ,chb13(:,length(chb13/2)+1:length(chb13)),chb15(:,length(chb15/2)+1:length(chb15))];
    datostest = chb03;
else
    datostrain = [chb03(:,1:length(chb03/2)),chb08(:,1:length(chb08/2)),chb13(:,1:length(chb13/2)),...
        chb15(:,1:length(chb15/2)),chb03(:,length(chb03/2)+1:length(chb03)),chb08(:,length(chb08/2)+1:length(chb08))...
        ,chb13(:,length(chb13/2)+1:length(chb13)),chb15(:,length(chb15/2)+1:length(chb15))];
    datostest = chb01;
end
r=1;
while (r<=length(comb))  
 if canales==2   
    [train_data,channel_ventana_train,c]= Features_edf(datostrain,canales,muestras,[comb(i,1),comb(i,2)],op);
    [test_data,channel_ventana_test,c1]= Features_edf(datostest,canales,muestras,[comb(i,1),comb(i,2)],op);
 elseif canales==4
     [train_data,channel_ventana_train,c]= Features_edf(datostrain,canales,muestras,[comb(r,1),comb(r,2),comb(r,3),comb(r,4)],op);
    [test_data,channel_ventana_test,c1]= Features_edf(datostest,canales,muestras,[comb(r,1),comb(r,2),comb(r,3),comb(r,4)],op);
 end
 %concatenar features sin crisis y con crisis en matriz caracteristicas
 train_label = [zeros(round(length(train_data)/2,0),1);ones(round(length(train_data)/2),1)];
 test_label =  [zeros(round(length(test_data)/2,0),1);ones(round(length(test_data)/2),1)];
if i==1
    trainlabel = ones(length(train_label),length(comb));
    testlabel =  ones(length(test_label),length(comb));
    predict_label_L = ones(length(test_data),length(comb));
    predict_label_R = ones(length(test_data),length(comb));
    accuracy_R =  ones(1,length(comb));
    accuracy_L =  ones(3,length(comb));
end

trainlabel(:,i) = train_label; 
testlabel(:,i) = test_label; 
%SVM con libreria
  
 %Entrenamiento de SVM mediante dos kernels 
 % Linear Kernel
 model_linear = svmtrain(trainlabel(:,i), train_data, '-t 0 ');
 % Testing model
 [predict_label_L(:,i), accuracy_L(:,i), dec_values_L] = svmpredict(testlabel(:,i), test_data, model_linear);
 % RBF Kernel 
 model_rbf = fitcsvm(train_data, trainlabel(:,i),'KernelFunction','rbf','Standardize',true,...
      'BoxConstraint',1,'ClassNames',[0,1]);
 [predict_label_R(:,i),scores] =  predict(model_rbf, test_data);
 % Testing model
 matc = confusionmat(testlabel(:,i),predict_label_R(:,i));
 s = sum(matc);
 accuracy_R(1,i) = 100*(matc(1,1)+matc(2,2))/(s(1)+s(2));
  i = i+1
 max_accuracyrbf = max(accuracy_R(1,:))
 max_accuracylinear = max(accuracy_L(1,:))
 if  max_accuracylinear>89 && max_accuracyrbf>75
     break;
 end
 r = r+1;
end

for l=1:length(comb)
    if(max_accuracylinear)==accuracy_L(1,l)
        index1 = l;
        break;
    end
end
for m=1:length(comb)
    if(max_accuracyrbf)==accuracy_R(1,m);
        index2 = m;
        break;
    end
end
 
 %Redes Neuronales
 trainFcn = 'trainscg';  % Scaled conjugate gradient backpropagation.
 % Ajustar parametros deseados
 hiddenLayerSize = 10;
 %se concatenan los vectores de feature(test y train)
%y los vectores de etiqueta(train y test)
features = [train_data;test_data];
labels = [train_label;test_label];

%Creacion de red neuronal
net = patternnet(hiddenLayerSize, trainFcn);

% Entrenar la red 
[net,tr] = train(net,features',labels');
% Setup Division of Data for Training, Validation, Testing
net.divideParam.trainRatio = 70/100;
net.divideParam.valRatio = 15/100;
net.divideParam.testRatio = 15/100;

% Testear la red
y = net(features'); 

e = gsubtract(labels',y);
performance = perform(net,labels',y);
tind = vec2ind(labels');  
yind = vec2ind(y);                      
percentErrors = sum(tind ~= yind)/numel(tind);
 
