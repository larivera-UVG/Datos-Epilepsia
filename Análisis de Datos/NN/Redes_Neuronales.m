%************************************************************************************
% Diseño red Neuronal mediante toolbox nn utilizando setA/setE y setB/setE
% con tamaños de ventana de 150 muestras y 80 muestras
%***********************************************************************************
%Elegir experimento a realizar 
%opcion=1 --> red neuronal con ventana de 150 muestras/ K=3 set A/set E
                                                     %/  K=7 set B/set E
%opcion=2 --> red neuronal con ventana de 150 muestras/ K=3 set A/set E
                                                     %/  K=7 set B/set E

%Elegir señales a analizar senal = 1-12
% [1-6 ]Set A/Set E: Z001/S100  Z020/S080  Z030/S060  Z040/S040  Z050/S020  Z060/S001
% [7-12]Set B/Set E: O100/S015  O090/S025 O080/S035 O070/S045 O060/S055 O050/S065

%Si se desean utilizar otras señales o caracteristicas, generar el .mat con el script
%Caracteristicas.m
%*************************************************************************************
% Elige señal y opcion
opcion = 2;
senal = 7;
% Elegir funcion de entrenamiento
% For a list of all training functions type: help nntrain
trainFcn = 'trainscg';  % Scaled conjugate gradient backpropagation.
% Ajustar parametros deseados
hiddenLayerSize = 10;

%*************************************************************************************
if opcion==1 
    load Workspace_ventana_150muestras.mat
elseif opcion==2 
    load Workspace_ventana_80muestras.mat
end
if senal==1
    features = MatrizFeatures1;
elseif senal==2
    features = MatrizFeatures2;
elseif senal==3
    features = MatrizFeatures3;
elseif senal==4
    features = MatrizFeatures4;
elseif senal==5
    features = MatrizFeatures5;
elseif senal==6
    features = MatrizFeatures6;
elseif senal==7
    features = MatrizFeatures7;
elseif senal==8
    features = MatrizFeatures8;
elseif senal==9
    features = MatrizFeatures9;
elseif senal==10
    features = MatrizFeatures10;
elseif senal==11
    features = MatrizFeatures11;
elseif senal==12
    features = MatrizFeatures12;
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