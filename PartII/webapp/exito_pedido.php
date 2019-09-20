<?php
session_start();
include_once('header.php');
$titulo = 'Exito pedido';
$pedido = $_SESSION['exito_pedido'];

unset($_SESSION['exito_pedido']);
?>

<h2>Su pedido con número #<?=$pedido?> ha siso tramitado.</h2>
<p>En breves recibirá más información en su correo.
Pulse <a href="productos.php">aquí</a> para seguir comprando </p>


<?php include_once('footer.php'); ?>
