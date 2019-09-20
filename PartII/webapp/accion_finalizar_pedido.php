<?php

	session_start();

	include_once("funciones_utilidades.php");
	include_once("gestionPedidosBD.php");
	include_once("gestion_BD.php");

	if(count($_SESSION['carrito']) == 0){
			Header("Location: productos.php");
	}elseif(isLogged()){
		$pedido = tramitar_pedido();

		if($pedido){

			$_SESSION['exito_pedido'] = $pedido;

			Header('Location: exito_pedido.php');
		}


	}else{
		Header("Location: login.php");
	}

?>
