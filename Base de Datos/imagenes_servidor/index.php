<!doctype html>
<html>
<head>
<meta charset="utf-8">
<title>Formulario</title>
<style>
table{
	margin:auto;
	width:450px;
	border:2px dotted #FF0000;
}
</style>
</head>

<body>

<form action="datosImagen.php" method="post" enctype="multipart/form-data">

<table>
<tr>
<td>
<label for="imagen">Imagen:</label></td>

<td><input type="file" name="imagen" size"20"></td></tr>

<tr><td colspan="2" style="text-align:Center"><input type="submit" value="Enviar Archivo"></td></tr></table>


</form>

</body>
</html>