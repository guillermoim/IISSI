<?php
session_start();

if(!isset($_SESSION['login-admin'])){
  Header('Location: login_admin.php');
}

?>

<!DOCTYPE html>
<html lang="en" dir="ltr">
  <head>
    <meta charset="UTF-8">
  	<title>Menú de administración</title>
  	<meta name="viewport" content="width=device-width, initial-scale=1.0">
  </head>
  <body>
    <?php include_once('header-admin.php'); ?>
    <h1>Estás en el menú de adminsitración</h1>
    <h3>Seleccione la opción que desea realizar:</h3>
    <ul>
      <li>  <a href="admin-docsIAE.php">Ver documentos IAE</a></li>
    </ul>

  </body>
</html>
