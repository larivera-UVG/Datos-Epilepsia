%************************************************************************************
% Diseño red Neuronal mediante toolbox nn utilizando setA/setE y setD/setE
%Si se desean utilizar otras señales o caracteristicas, generar el .mat con el script
%Caracteristicas.m
load Features_ventana_4096muestras.mat
%*************************************************************************************
% Elegir funcion de entrenamiento
% For a list of all training functions type: help nntrain
trainFcn = 'trainscg';  % Scaled conjugate gradient backpropagation.
% Ajustar parametros deseados
hiddenLayerSize = 10;
% Opcion 1: caracteristicas pacientes normales/con crisis (SetA/SetE)
% Opcion 2: caracteristicas pacientes epilépticos sin crisis/con crisis (SetD/SetE)
opcion = 1;
if opcion==1
    features = featuressetAE;
elseif opcion==2
    features = featuressetDE;
end
%*************************************************************************************
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


% Generar vector de clases
labels = zeros(length(features),2);
for i=1:length(features)/2
    labels(i,1:2) = [1,0];
end
for j=(length(features)/2+1):length(features)
    labels(j,1:2) = [0,1];
end
net = patternnet(hiddenLayerSize, trainFcn);

% Entrenar la red 
[net,tr] = train(net,features',labels');
% Setup Division of Data for Training, Validation, Testing
net.divideParam.trainRatio = 70/100;
net.divideParam.valRatio = 15/100;
net.divideParam.testRatio = 15/100;

% Testear la red
y = net(features');  % Se pasan los datos por la red.
e = gsubtract(labels',y);
performance = perform(net,labels',y)
tind = vec2ind(labels');  
yind = vec2ind(y);  
                    
                    
                    
percentErrors = sum(tind ~= yind)/numel(tind);

% View the Network
view(net)