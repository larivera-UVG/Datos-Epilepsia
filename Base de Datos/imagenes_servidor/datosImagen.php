<?php
//Recibir datos de la imagen
$nombre_imagen=$_FILES['imagen']['name'];
$tipo_imagen=$_FILES['imagen']['type'];
$tamano_imagen=$_FILES['imagen']['size'];

//Ruta del destino del servidor
$carpeta_destino=$_SERVER['DOCUMENT_ROOT'].'/uploads/';

//Mover imagen del directorio temporar al directorio escogido
move_uploaded_file($_FILES['imagen']['tmp_name'],$carpeta_destino.$nombre_imagen);

require("config.php");
$conexion=mysqli_connect($host,$dbuser,$dbpwd);
	if(mysqli_connect_errno()){
		echo "Fallo al conectar con la BD";
		exit();
	}
	mysqli_select_db($conexion,$db) or die ("No se encuentra la BD");
	mysqli_set_charset($conexion, "utf8");
	
	//$sql="INSERT INTO 'productos' (imagen) VALUES ('$nombre_imagen')";
	$sql="UPDATE PRODUCTOS SET IMAGEN='$nombre_imagen' WHERE ID_PRODUCTO='2'";
	$resultado=mysqli_query($conexion, $sql);
	
?>  