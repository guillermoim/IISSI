<?php
session_start();

if(!isset($_SESSION['login-admin'])){
  Header('Location: login_admin.php');
}else{
  unset($_SESSION['login-admin']);
  Header('Location: login_admin.php');
}

?>
