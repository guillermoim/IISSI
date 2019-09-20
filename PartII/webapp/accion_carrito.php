<?php

	session_start();

	include_once("funciones_utilidades.php");

	if(isset($_GET['vaciar'])){

		$_SESSION['carrito'] = array();
		unset($_GET['vaciar']);

	}

	if(isset($_REQUEST['id']) && !isset($_REQUEST['remove'])){

		#Recuperamos id, cantidad y precio de la petición
		$id = $_REQUEST['id'];
		$cantidad = $_REQUEST['cantidad'];
		$precio = $_REQUEST['precio'];

		#Recuperamos el carrito de la sesión y lo guardamos en una variable auxiliar
		$carrito = $_SESSION['carrito'];

		#Si el producto ya existe en el carrito, sólo hay que actualizar la cantidad.

		if(array_key_exists($id, $carrito)){

			$nuevaCantidad = $carrito[$id]['cantidad'] + $cantidad;
			if($nuevaCantidad > 0){
				$carrito[$id]['cantidad'] = $nuevaCantidad;
			}
			$_SESSION['carrito'] = $carrito;

		#En otro caso, hay que insertar el producto, la cantidad y el precio
		}else{
			$_SESSION['carrito'][$id] = array('cantidad' => $cantidad, 'precio' => $precio);
		}

		unset($_REQUEST['id']);
		unset($_REQUEST['cantidad']);


	}

	if(isset($_REQUEST['remove'])){
		$id = $_REQUEST['id'];

		$carrito = $_SESSION['carrito'];
		unset($carrito[$id]);

		$_SESSION['carrito'] = $carrito;

		unset($_REQUEST['id']);
		unset($_REQUEST['remove']);

		$total = calcPrecioTotal($_SESSION['carrito']);

		echo 'TOTAL: '.$total;
	}


 ?>
