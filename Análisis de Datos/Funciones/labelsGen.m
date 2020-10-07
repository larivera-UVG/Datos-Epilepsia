% Se obtienen los conjuntos train y test para entrenar y validar
% clasificadores a utilizar utilizando clustering
function [train_label,test_label] = labelsGen(train_data,test_data)
%Features_train : Matriz de features para entrenar clasificador
%Features_test : Matriz de features para validar clasificador
%C: vector de centros utilizados (x,y)

%Clustering K-means para entrenamiento
% Centros propuestos
%      x      y
%   0.0190   18.9348
%   0.0080   22.1894
%C = [0.0190,0.0080;18.9348,22.1894];
[E, centros] = k_means(train_data,2,0);
train_label = [zeros(sum(E==1),1); ones(sum(E==2),1)];
%Clustering K-means para testeo
[E1, centros1] = k_means(test_data,2,0);
test_label = [zeros(sum(E1==1),1); ones(sum(E1==2),1)];

end

