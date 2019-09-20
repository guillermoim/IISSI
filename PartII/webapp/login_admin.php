<?php
  session_start();
?>
<!DOCTYPE html>
<html lang="en" dir="ltr">
  <head>
    <meta charset="utf-8">
    <title></title>
  </head>
  <body>
    <h1>Inicio de sesión administración</h1>
    <?php if(isset($_SESSION['login-admin'])){
      echo "<p>".$_SESSION['login-admin']."</p>";
    } ?>
    <form action="accion_login_admin.php" method="post">
      Usuario:<br> <input type="text" name="dato"><br>
      Contraseña:<br> <input type="password" name="pass" name="pass"><br>
      <input type="submit" name="submit" value="Aceptar"><br>
    </form>
  </body>
</html>
