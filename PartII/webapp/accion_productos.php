

<?php
include_once('gestionProductosBD.php');
include_once('gestion_BD.php');

$con = crearConexionBD();

$productos = obtener_productos_filtered($con, 1, 10, 'a');

echo gettype($productos);
foreach ($productos as $prod) {
  echo $prod['NOMBRE'];
}



 ?>
