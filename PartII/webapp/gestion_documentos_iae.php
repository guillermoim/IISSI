<?php

function consultarDocumentosIAE($con){

  try {

      $query = "SELECT OID_IAE, NIF, NOMBRE, APELLIDOS, ESTADO FROM CLIENTES
                NATURAL JOIN PERSONAS
                NATURAL JOIN DOCUMENTOSIAE
                WHERE ESTADO = 'ESPERA'";

      $stmt = $con->prepare($query);
      $stmt->execute();
  		return $stmt;

  } catch (PDOException $e) {
    	$_SESSION['excepcion'] = $e->GetMessage();
      Header('Location: excepcion.php');
  }


}

function consultarDocumentosIAEAceptados($con){

  try {

      $query = "SELECT NIF, NOMBRE, APELLIDOS, ESTADO FROM CLIENTES
                NATURAL JOIN PERSONAS
                NATURAL JOIN DOCUMENTOSIAE
                WHERE ESTADO = 'ACEPTADO'";

      $stmt = $con->prepare($query);
      $stmt->execute();
  		return $stmt;

  } catch (PDOException $e) {
    	$_SESSION['excepcion'] = $e->GetMessage();
      Header('Location: excepcion.php');
  }


}

function consultarDocumentosIAERechazados($con){

  try {

      $query = "SELECT NIF, NOMBRE, APELLIDOS, ESTADO FROM CLIENTES
                NATURAL JOIN PERSONAS
                NATURAL JOIN DOCUMENTOSIAE
                WHERE ESTADO = 'RECHAZADO'";

      $stmt = $con->prepare($query);
      $stmt->execute();
  		return $stmt;

  } catch (PDOException $e) {
    	$_SESSION['excepcion'] = $e->GetMessage();
      Header('Location: excepcion.php');
  }
}

function aceptarDocumentoIAE($con, $oid_iae){
  try {

    $query = "CALL ACEPTAR_DOC_IAE(:oid_iae)";
    $stmt = $con->prepare($query);
		$stmt->bindParam(':oid_iae',$oid_iae);
    $stmt->execute();
    return true;


  } catch (PDOException $e) {
    $_SESSION['excepcion'] = $e->GetMessage();
    Header('Location: excepcion.php');
  }

}

function rechazarDocumentoIAE($con, $oid_iae){
  try {

    $query = "CALL RECHAZAR_DOC_IAE(:oid_iae)";
    $stmt = $con->prepare($query);
		$stmt->bindParam(':oid_iae',$oid_iae);
    $stmt->execute();
    return true;


  } catch (PDOException $e) {
    $_SESSION['excepcion'] = $e->GetMessage();
    Header('Location: excepcion.php');
  }

}



?>
