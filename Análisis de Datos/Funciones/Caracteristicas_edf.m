%Generador de matrices features con funcion Features_edf
% Las pruebas se realizan con 10 grabaciones de 5 pacientes distintos siendo
%"edf" la opción del paciente a realizar la prueba. Pueden elegirse de 1-4
%canales a procesar.
edf=1;
if edf==1
    nombre = 'chb01_15';
elseif edf==2
    nombre = 'chb01_16';
elseif edf==3
    nombre = 'chb02_16';
elseif edf==4
    nombre = 'chb02_19';
elseif edf==5
    nombre = 'chb03_03';
elseif edf==6
    nombre = 'chb03_04';
elseif edf==7
    nombre = 'chb05_13';
elseif edf==8
    nombre = 'chb05_22';
elseif edf==9
    nombre = 'chb11_82';
elseif edf==10
    nombre = 'chb11_92';
end
%Colocar ruta de archivos de prueba edf
[header, recorddata] = edfread(['C:\Users\USUARIO\OneDrive Personal\OneDrive\Megaproyecto\Base de datos\edf_files\',nombre,'.edf']);

%-----------------------------------------------------------------------
%Para llamar función de Features_edf
%Indicar número de canales que se desean analizar, número de muestras
%por cada ventana tomar en cuenta Fs = 256Hz 
canales = 2;
muestras = 2000;

[Matriz_Features,channel_ventana,c]= Features_edf(recorddata,canales,muestras);
%Guardar vector de caracteristicas
if canales==1
    csvwrite(['Features_',nombre,'_',num2str(c(1)),'.csv'],Matriz_Features);
    csvwrite([nombre,'_',num2str(c(1)),'_Data','.csv'],channel_ventana);
elseif canales==2
    csvwrite(['Features_',nombre,'_',num2str(c(1)),'_',num2str(c(2)),'.csv'],Matriz_Features);
    csvwrite([nombre,'_',num2str(c(1)),num2str(c(2)),'_Data','.csv'],channel_ventana);
elseif canales==3
    csvwrite(['Features_',nombre,'_',num2str(c(1)),num2str(c(2)),num2str(c(3)),'.csv'],Matriz_Features);
    csvwrite([nombre,'_',num2str(c(1)),num2str(c(2)),num2str(c(3)),'_Data','.csv'],channel_ventana);
elseif canales==4
    csvwrite(['Features_',nombre,'_',num2str(c(1)),'_',num2str(c(2)),'_',num2str(c(3)),'_',num2str(c(4)),'.csv'],Matriz_Features);
    csvwrite([nombre,'_',num2str(c(1)),num2str(c(2)),num2str(c(3)),num2str(c(4)),'_Data','.csv'],channel_ventana);
end

%Graficar
%Descomentar si se desea graficar
% figure(3);
% [D, P]=VAT(Matriz_Features);
% figure(4);
% hold off
% t = 0:length(channel_ventana)-1;
% 
% if length(c)==1
%     subplot(2,2,1);
%     plot(t, channel_ventana(:,1), '-r');
%     ylabel(['Canal ',num2str(c(1))])
%     xlabel('Muestras')
% elseif length(c)==2
%     subplot(2,2,1);
%     plot(t, channel_ventana(:,1), '-r');
%     ylabel(['Canal ',num2str(c(1))])
%     xlabel('Muestras')
%     subplot(2,2,2);
%     plot(t, channel_ventana(:,2),'b');
%     ylabel(['Canal ',num2str(c(2))])
%     xlabel('Muestras')  
% elseif length(c)==3
%     subplot(2,2,1);
%     plot(t, channel_ventana(:,1), '-r');
%     ylabel(['Canal ',num2str(c(1))])
%     xlabel('Muestras')
%     subplot(2,2,2);
%     plot(t, channel_ventana(:,2),'b');
%     ylabel(['Canal ',num2str(c(2))])
%     xlabel('Muestras')
%     subplot(2,2,3);
%     plot(t, channel_ventana(:,3),'b');
%     ylabel(['Canal ',num2str(c(3))])
%     xlabel('Muestras')
% elseif length(c)==4
%     subplot(2,2,1);
%     plot(t, channel_ventana(:,1), '-r');
%     ylabel(['Canal ',num2str(c(1))])
%     xlabel('Muestras')
%     subplot(2,2,2);
%     plot(t, channel_ventana(:,2),'b');
%     ylabel(['Canal ',num2str(c(2))])
%     xlabel('Muestras')
%     subplot(2,2,3);
%     plot(t, channel_ventana(:,3),'b');
%     ylabel(['Canal ',num2str(c(3))])
%     xlabel('Muestras')
%     subplot(2,2,4);
%     plot(t, channel_ventana(:,4),'b');
%     ylabel(['Canal ',num2str(c(4))])
%     xlabel('Muestras')
% end
% 
