 op =2;
%Cargar matriz de características
if op==1
    %Bonn University
    load ('C:\Users\USUARIO\OneDrive Personal\OneDrive\Megaproyecto\Base de datos\SVM\Workspace_ventana_80muestras.mat');
    X = MatrizFeatures1;
    [idx,C] = kmeans(X,3);
elseif op==2
    %Physionet
   load("Physionet.mat");
   X = features;
   [idx,C] = kmeans(X,2);
end
%plot
figure;
plot(X(idx==1,1),X(idx==1,2),'r.','MarkerSize',12)
hold on
plot(X(idx==2,1),X(idx==2,2),'b.','MarkerSize',12)
plot(X(idx==3,1),X(idx==3,2),'g.','MarkerSize',12)
plot(C(:,1),C(:,2),'kx',...
     'MarkerSize',15,'LineWidth',3) 
legend('Cluster 1','Cluster 2','Centroides',...
       'Ubicación','NW')
title 'Cluster y Centroides'
hold off