<?php
//Recibir datos de la imagen
$nombre_archivo=$_FILES['archivo']['name'];
$tipo_archivo=$_FILES['archivo']['type'];
$tamano_archivo=$_FILES['archivo']['size'];
$paciente=$_POST["paciente"];

if($tipo_archivo=="text/plain"){
	
//Ruta del destino del servidor
$carpeta_destino=$_SERVER['DOCUMENT_ROOT'].'/proyecto/uploads/';

//Mover imagen del directorio temporar al directorio escogido
move_uploaded_file($_FILES['archivo']['tmp_name'],$carpeta_destino.$nombre_archivo);

require("config.php");
$conexion=mysqli_connect($host,$dbuser,$dbpwd);
	if(mysqli_connect_errno()){
		echo "Fallo al conectar con la BD";
		exit();
	}
	mysqli_select_db($conexion,$db) or die ("No se encuentra la BD");
	mysqli_set_charset($conexion, "utf8");
	
	//$sql="INSERT INTO 'productos' (imagen) VALUES ('$nombre_imagen')";
	$sql="UPDATE DATOS SET EEG='$nombre_archivo' WHERE id_paciente='$paciente'";
	$resultado=mysqli_query($conexion, $sql);
}
else{
	echo "No es el tipo de archivo correcto";
}
?>  