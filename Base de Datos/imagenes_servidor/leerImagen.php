<!doctype html>
<html>
<head>
<meta charset="utf-8">
<title>Leer Imagen</title>

</head>

<body>

<?php
require("config.php");
$conexion=mysqli_connect($host,$dbuser,$dbpwd);
	if(mysqli_connect_errno()){
		echo "Fallo al conectar con la BD";
		exit();
	}
	mysqli_select_db($conexion,$db) or die ("No se encuentra la BD");
	mysqli_set_charset($conexion, "utf8");

	$consulta="SELECT IMAGEN FROM PRODUCTOS WHERE ID_PRODUCTO='2'";
	
	$resultado=mysqli_query($conexion, $consulta);
	
	while($fila=mysqli_fetch_array($resultado)){
		
		$ruta_img=$fila["IMAGEN"];
	}

?>

<div>
	<img src="/uploads/<?php echo $ruta_img;?>" alt="Imagen del primer articulo" width="25%"/>
</div>

</body>
</html>