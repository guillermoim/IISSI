<?php
session_start();

include_once('consultar_usuarios_admin.php');
include_once('gestion_BD.php');

if(isset($_REQUEST["submit"])){
  $dato = $_REQUEST["dato"];
  $pass = $_REQUEST["pass"];
  $con = crearConexionBD();
  $numUsuarios = consultarEmpleado($con, $dato, $pass);
  if ($numUsuarios > 0){
    //En este tipo de login no se lleva a cabo de un registro de quien se
    //esta loggeando, simplemente se verifica que los datos son correctos
    // y se garantiza acceso
    $_SESSION['login-admin'] = $dato;

    header('Location: admin-menu.php');
  }else{
    $_SESSION['error_login_admin'] = 'Los datos que ha introducido no son correctos.';
    header('Location: login_admin.php');
  }
  cerrarConexionBD($con, $dato, $pass);

}else{
  header('Location: login_admin.php');
} ?>
