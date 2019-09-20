<?php

session_start();

if(!isset($_SESSION['login-admin'])){
  Header('Location: login_admin.php');
}

if (!isset($_REQUEST['OID_IAE'])) {
  Header("Location: admin-docsIAE.php");
}

include_once('gestion_BD.php');
include_once('gestion_documentos_iae.php');

$oid_iae = $_REQUEST['OID_IAE'];
$con = crearConexionBD();

if($_REQUEST['accion'] == 'aceptar'){
  aceptarDocumentoIAE($con, $oid_iae);

}else{
  rechazarDocumentoIAE($con, $oid_iae);
}
cerrarConexionBD($con);
header('Location: admin-docsIAE.php');



?>
