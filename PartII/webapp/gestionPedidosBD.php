<?php

function crear_pedido($conn){

	$oid_p = $_SESSION['login']['oid_p'];

	$oid_pedido = null;

	try{

		$query = 'CALL insertar_pedido(:oid_p)';
		$stmt = $conn->prepare($query);
		$stmt->bindParam(':oid_p', $oid_p);
		$stmt->execute();

		$stmt2 = $conn->query('SELECT seq_pedidos.currval AS pedido FROM DUAL');

		$pedido = $stmt2->fetch();

		$oid_pedido = $pedido['PEDIDO'];

	}catch(PDOException $e){

		$_SESSION['excepcion'] = $e->getMessage();
		Header('Location: excepcion.php');

	}

	return $oid_pedido;
}


function add_lineas($conn, $carrito, $pedido){

	$oid_pe = $pedido;

	try{

		foreach ($carrito as $id => $item) {

			$oid_pr = $id;
			$cantidad = $item['cantidad'];

			$query = 'CALL insertar_linea_pedido(:oid_pe, :oid_pr, :cantidad)';
			$stmt = $conn->prepare($query);
			$stmt->bindParam(':oid_pe', $oid_pe);
			$stmt->bindParam(':oid_pr', $oid_pr);
			$stmt->bindParam(':cantidad', $cantidad);
			$stmt->execute();

		}

	}catch(PDOException $e){
		$_SESSION['excepcion'] = $e->getMessage();
		Header('Location: excepcion.php');

	}


}

function cerrar_pedido($conn, $pedido){

	$oid_pe = $pedido;

	try{

		$query = 'CALL cerrar_pedido(:oid_pe)';
		$stmt = $conn->prepare($query);
		$stmt->bindParam(':oid_pe', $oid_pe);
		$stmt->execute();
		unset($_SESSION['carrito']);

	} catch(PDOException $e) {
		$_SESSION['excepcion'] = $e->getMessage();
		Header('Location: excepcion.php');

	}
}

function tramitar_pedido(){

		$oid_p = $_SESSION['login']['oid_p'];

		$conn = crearConexionBD();
		$pedido = crear_pedido($conn);
		add_lineas($conn, $_SESSION['carrito'], $pedido);
		cerrar_pedido($conn, $pedido);

		cerrarConexionBD($conn);

		return $pedido;
}


?>
