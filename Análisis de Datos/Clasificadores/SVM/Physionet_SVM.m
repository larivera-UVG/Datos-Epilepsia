%Cargar datos etiquetados 2 pacientes de Physionet. Este workspace incluye data preseleccionada de 2 pacientes distintos.
%Los datos se encuentran balanceados, la mitad de las muestras corresponden a registros normales y la mitad restante a registros ictales.
load Physionet_datasets.mat

Fs = 256;
muestras=2500;  %cada 10s
canales = 2;
op=1;
comb = combnk(1:23,canales); %para eeg de 23 canales
i=1;
%Si desea modificarse, cargar datos para entrenamiento en variable datostrain y datos de prueba en variable datostest.
%Opcional dejar un paciente afuera de train, para realizar testeo. 
%datostrain = ;
%datostest = ;

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
 model_linear = fitcsvm(train_data, trainlabel(:,i),'KernelFunction','linear','Standardize',true,...
      'BoxConstraint',1,'ClassNames',[0,1]);
 % Testing model
 [predict_label_L(:,i),scores1] =  predict(model_linear, test_data);
 matc1 = confusionmat(testlabel(:,i),predict_label_L(:,i));
 s1 = sum(matc1);
 accuracy_L(1,i) = 100*(matc1(1,1)+matc1(2,2))/(s1(1)+s1(2));
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
 %modificar exactitud para acelerar las iteraciones
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
 
 %Graficar matriz de confusion
 figure(5);
 cm1 = plotconfusion(testlabel(:,index1)',predict_label_L(:,index1)',{'Matriz de confusion Kernel Lineal'},testlabel(:,index2)',predict_label_R(:,index2)',{'Matriz de confusion Kernel RBF'});


 
