%clear;
%clc;
%cargar datos 
%load ('C:\Users\USUARIO\Downloads\HUMANA\edf_humana.mat');

%elegir edf: 1. AL  2. GIKA  3. CLEA
op =2;
%Si desea cargar nuevo edf
%ruta = 'C:\Users\USUARIO\OneDrive Personal\OneDrive\Megaproyecto\Base de datos\edf_files\';
%nombre = 'chb01_15';
%Elegir numero de canales para matriz de features 
canales = 2;
%Elegir numero de muestras por ventana
muestras= 2500; 
%RN=1 si se desea analizar red neuronal
RN=0;


%Asignación de variables 
if op==1
    header = header_AL; edf = edf_AL;
    paciente = 1;
elseif op==2
    header = header_GIKA; edf = edf_GIKA;
    paciente = 2;
elseif op==3
    header = header_CLEA; edf = edf_CLEA;
    paciente = 3;
elseif op==4
    [header, edf] = edfread([ruta,nombre,'.edf']);
    paciente = 4;
end

Fs = 200;
ctot = header.ns;               %# de canales presentes en el eeg
comb = combnk(1:ctot,canales);  %combinaciones para generar mejor respuesta
i=1;

while (i<=length(comb))  
 %obtener matrices de features
 [Matriz_features,data,c] = Features_edf(edf,canales,muestras,[comb(i,1),comb(i,2)]);
 %Obtener vectores train y test mediante clustering y kfold validation
 [E, ~] = k_means(Matriz_features,2,0);
 labels = [zeros(sum(E==1),1); ones(sum(E==2),1)];
 M = 0.20;
 [trainIdx, testIdx] = crossvalind('Holdout', labels, M);
 %Obtener conjuntos train y test
 train_data = Matriz_features(trainIdx,:);
 train_label = labels(trainIdx,:);
 test_data = Matriz_features(testIdx,:);
 test_label = labels(testIdx,:);
 if i==1
    tesindex = ones(length(testIdx),length(comb));
    trainlabel = ones(length(train_label),length(comb));
    testlabel =  ones(length(test_label),length(comb));
    predict_label_L = ones(length(test_data),length(comb));
    predict_label_P = ones(length(test_data),length(comb));
    accuracy_P =  ones(3,length(comb));
    accuracy_L =  ones(3,length(comb));
 end
 
 trainlabel(:,i) = train_label; 
 testlabel(:,i) = test_label; 
 tesindex(:,i) = testIdx;
 %SVM con libreria

 %Entrenamiento de SVM mediante dos kernels 
 % Linear Kernel
 model_linear = svmtrain(trainlabel(:,i), train_data, '-t 0 ');
 % Testing model
 [predict_label_L(:,i), accuracy_L(:,i), dec_values_L] = svmpredict(testlabel(:,i), test_data, model_linear);
 % RBF Kernel 
 model_precomputed = svmtrain(trainlabel(:,i), [(1:length(train_data))', train_data*train_data'], '-t 4 -c 2  ');
 % Testing model
 [predict_label_P(:,i), accuracy_P(:,i), dec_values_P] = svmpredict(testlabel(:,i), [(1:length(test_data))', test_data*train_data'], model_precomputed);
 
  i = i+1
  max_accuracy1 = max(accuracy_P(1,:));
  max_accuracy2 = max(accuracy_L(1,:));
 if max_accuracy1>53 || max_accuracy2>53
     break;
 end
end
for l=1:length(comb)
    if(max_accuracy1)==accuracy_P(1,l)
        index1 = l;
        break;
    end
end
for m=1:length(comb)
    if(max_accuracy2)==accuracy_L(1,m)
        index2 = m;
        break;
    end
end
%  figure(8);
%  cm1 = plotconfusion(testlabel(:,index2)',predict_label_L(:,index2)',{'Matriz de confusion Kernel Lineal'},testlabel(:,index1)',predict_label_P(:,index1)',{'Matriz de confusion Kernel RBF'});
%  set(gca,'xticklabel',{'Con Crisis' 'Sin crisis' ''})
%  set(gca,'yticklabel',{'Con Crisis' 'Sin Crisis' ''})
%  

%Graficar en todos los canales
t = 1:1:length(edf);
row = ctot/4;
if  rem(row,2)~=0
    row = round(row,0)+1;
end
figure(10);
for i=1:row
    subplot(row,1,i)
    plot(t,edf(i,:),'color','b' );
    ylabel('Amplitud ')
    xlabel(['Muestras canal ',num2str(i)])
end
figure(11);
for i=row+1:(row*2)
    subplot(row,1,i-row)
    plot(t,edf(i,:),'color','b' );
    ylabel('Amplitud ')
    xlabel(['Muestras canal ',num2str(i)])
end
figure(12);
for i=(row*2)+1:(row*3)
    subplot(row,1,i-(row*2))
    plot(t,edf(i,:),'color','b' );
    ylabel('Amplitud ')
    xlabel(['Muestras canal ',num2str(i)])
end
figure(13);
for i=(row*3)+1:ctot
    subplot(row,1,i-(row*3))
    plot(t,edf(i,:),'color','b' );
    ylabel('Amplitud ')
    xlabel(['Muestras canal ',num2str(i)])
end