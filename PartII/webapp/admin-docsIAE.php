<?php
session_start();

if(!isset($_SESSION['login-admin'])){
  Header('Location: login_admin.php');
}
include_once('gestion_BD.php');
include_once('gestion_documentos_iae.php');

?>

<!DOCTYPE html>
<html lang="en" dir="ltr">
 <head>
   <meta charset="utf-8">
   <title></title>
 </head>
 <body>
<?php include_once('header-admin.php'); ?>
<h1>Gestión de documentos IAE</h1>


<p>Estás en: <a href="admin-menu.php">Menú principal</a>  > Gestión de documentos IAE <p>

Ver:
<a href="admin-docsIAE.php">En espera</a> /
<a href="admin-docsIAE.php?kw=ACEPTADO">Aceptados</a> /
<a href="admin-docsIAE.php?kw=RECHAZADO"> Rechazados</a>


<?php



$con = crearConexionBD();

if(isset($_REQUEST['kw'])){
  $kw = $_REQUEST['kw'];
  if($kw=='ACEPTADO')
    $documentos = consultarDocumentosIAEAceptados($con);
  else
    $documentos = consultarDocumentosIAERechazados($con);
}else{
  $documentos = consultarDocumentosIAE($con);
}

cerrarConexionBD($con);
?><table>
  <tr>
    <th>NIF</th>
    <th>Nombre</th>
    <th>Apellidos</th>
    <th>Estado</th>


  </tr>

<?php
foreach ($documentos as $doc) {
  ?>
    <tr>
      <td><?=$doc['NIF']?></td>
      <td><?=$doc['NOMBRE']?></td>

      <td><?=$doc['APELLIDOS']?></td>
      <td><?=$doc['ESTADO']?></td>
      <td><a href="files/<?=$doc['NIF']?>.pdf" target="_blank">Ver</a></td>
      <?php if($doc['ESTADO']=='ESPERA'){?>
      <td>
        <form action="accion-admin-iae.php" method="post">
          <input type="hidden" name="OID_IAE" value="<?=$doc['OID_IAE']?>">
          <button type="submit" name="accion" value="aceptar">ACEPTAR</button>
        </form>
      </td>

      <td>
        <form action="accion-admin-iae.php" method="post">
          <input type="hidden" name="OID_IAE" value="<?=$doc['OID_IAE']?>">
          <button type="submit" name="accion" value="rechazar">RECHAZAR</button>
        </form>
      </td>
    <?php } ?>
    </tr>


  <?php
}


 ?>
   </table>
 </body>
</html>
